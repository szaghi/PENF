"""Sumi brush engine of the Sumi family identities (shared by the szaghi.github.io projects).

Strokes are filled polygons: a centre-line (Catmull-Rom through control
points), a width profile (tome / harai / swell / even / hook), low-frequency
edge noise and optional kasure (dry-brush split at the tail).
"""
import math
import numpy as np

DENS = 1.7

SEAL = ("M62.00 62.64 L61.82 53.62 L52.65 53.78 L52.78 62.95 Z M60.40 56.85 L59.33 56.85 "
        "L59.33 57.92 L60.40 57.92 L60.40 58.68 L57.68 58.68 L57.68 61.40 L56.92 61.40 "
        "L56.92 58.68 L54.20 58.68 L54.20 57.92 L56.92 57.92 L56.92 55.20 L57.68 55.20 "
        "L57.68 56.27 L58.75 56.27 L58.75 55.20 L59.33 55.20 L59.33 56.27 L60.40 56.27 Z "
        "M57.68 56.85 L57.68 57.92 L58.75 57.92 L58.75 56.85 Z")


def _cr(pts, n):
    p = np.array(pts, float)
    if len(p) == 2:
        t = np.linspace(0, 1, n)[:, None]
        return p[0] * (1 - t) + p[1] * t
    p = np.vstack([2 * p[0] - p[1], p, 2 * p[-1] - p[-2]])
    seg = len(p) - 3
    out = []
    for i in range(seg):
        p0, p1, p2, p3 = p[i], p[i + 1], p[i + 2], p[i + 3]
        m = max(2, int(n / seg))
        for t in np.linspace(0, 1, m, endpoint=(i == seg - 1)):
            t2, t3 = t * t, t * t * t
            out.append(0.5 * ((2 * p1) + (-p0 + p2) * t + (2 * p0 - 5 * p1 + 4 * p2 - p3) * t2
                              + (-p0 + 3 * p1 - 3 * p2 + p3) * t3))
    return np.array(out)


def _resample(c, n):
    d = np.r_[0, np.cumsum(np.hypot(*np.diff(c, axis=0).T))]
    s = np.linspace(0, d[-1], n)
    return np.c_[np.interp(s, d, c[:, 0]), np.interp(s, d, c[:, 1])], d[-1]


def _ss(a, b, x):
    x = np.clip((x - a) / (b - a), 0, 1)
    return x * x * (3 - 2 * x)


def profile(kind, t):
    bump0 = np.exp(-((t - 0.04) / 0.06) ** 2)
    bump1 = np.exp(-((t - 0.95) / 0.05) ** 2)
    capA = np.clip(t / 0.025, 0, 1) ** 0.5
    capB = np.clip((1 - t) / 0.02, 0, 1) ** 0.5
    if kind == "tome":
        return (1 + 0.32 * bump0 + 0.28 * bump1) * capA * capB
    if kind == "harai":
        return (1 + 0.3 * bump0) * capA * (1 - 0.94 * _ss(0.45, 1.0, t))
    if kind == "irihai":  # thin entry, heavy exit (a press at the end)
        return (0.25 + 0.75 * _ss(0.0, 0.45, t) + 0.3 * bump1) * capB
    if kind == "swell":
        return np.clip(np.sin(np.pi * t), 0, 1) ** 0.55 + 0.04
    if kind == "even":
        return capA * capB * (1 + 0.12 * bump0)
    if kind == "hook":  # tome then a short flick
        return (1 + 0.3 * bump0) * capA * (1 - 0.85 * _ss(0.82, 1.0, t))
    raise ValueError(kind)


class Rng:
    def __init__(self, seed):
        self.r = np.random.default_rng(seed)

    def noise(self, t, amp, waves=3):
        v = np.zeros_like(t)
        for k in range(waves):
            f = self.r.uniform(1.5, 5.5) * (k + 1)
            v += math.sqrt(1 / (k + 1)) * np.sin(2 * np.pi * f * t + self.r.uniform(0, 6.3))
        return amp * v / waves


def fmt(poly, nd=2):
    poly = np.asarray(poly)
    x, y = poly[:, 0], poly[:, 1]
    if 0.5 * np.sum(x * np.roll(y, -1) - np.roll(x, -1) * y) < 0:
        poly = poly[::-1]
    f = "%%.%df" % nd
    s = "M" + f % poly[0][0] + " " + f % poly[0][1] + "L"
    s += " ".join(f % x + " " + f % y for x, y in poly[1:])
    return s + "Z"


def stroke(pts, w, kind="tome", seed=1, jit=0.07, n=None, kasure=0, k0=0.55, wm=1.0, nd=2):
    """Return SVG path data for one brushed stroke."""
    rng = Rng(seed)
    c = _cr(pts, 400)
    L = np.sum(np.hypot(*np.diff(c, axis=0).T))
    n = n or int(np.clip(L * DENS, 14, 140))
    c, L = _resample(c, n)
    t = np.linspace(0, 1, n)
    tg = np.gradient(c, axis=0)
    tg /= np.linalg.norm(tg, axis=1)[:, None] + 1e-12
    nm = np.c_[-tg[:, 1], tg[:, 0]]
    W = w * wm * profile(kind, t) / 2
    W = np.maximum(W, 0.015)
    eL = W * (1 + rng.noise(t, jit * 2.2))
    eR = W * (1 + rng.noise(t, jit * 2.2))
    if not kasure:
        left = c + nm * eL[:, None]
        right = c - nm * eR[:, None]
        poly = np.vstack([left, right[::-1]])
        return fmt(poly, nd)
    # kasure: split into bands that separate after k0
    parts = []
    edges = np.linspace(-1, 1, kasure + 1)
    gap = _ss(k0, 1.0, t) * 0.55 / kasure
    for i in range(kasure):
        a, b = edges[i], edges[i + 1]
        end = 1.0 - (rng.r.uniform(0.0, 0.22) if i not in (0, kasure - 1) else rng.r.uniform(0.0, 0.1))
        m = t <= end
        if m.sum() < 4:
            continue
        aa = a + gap - 0.03
        bb = b - gap + 0.03
        aa = np.where(i == 0, a, aa)
        bb = np.where(i == kasure - 1, b, bb)
        fade = 1 - 0.85 * _ss(end - 0.08, end, t)
        mid = (aa + bb) / 2
        hw = (bb - aa) / 2 * np.where(t > k0, fade, 1)
        lo = mid - hw
        hi = mid + hw
        Wv = np.where(lo < 0, eR, eL)
        Wh = np.where(hi < 0, eR, eL)
        P1 = c + nm * (hi * Wh)[:, None]
        P2 = c + nm * (lo * Wv)[:, None]
        poly = np.vstack([P1[m], P2[m][::-1]])
        parts.append(fmt(poly, nd))
    return " ".join(parts)


def blob(cx, cy, rx, ry=None, rot=0, seed=1, jit=0.08, n=28, nd=2):
    rng = Rng(seed)
    ry = ry or rx
    t = np.linspace(0, 1, n, endpoint=False)
    r = 1 + rng.noise(t, jit * 2.5)
    a = 2 * np.pi * t
    x, y = rx * r * np.cos(a), ry * r * np.sin(a)
    ca, sa = math.cos(rot), math.sin(rot)
    P = np.c_[cx + x * ca - y * sa, cy + x * sa + y * ca]
    return fmt(P, nd)


def ring(cx, cy, r, w, a0=0, sweep=2 * math.pi * 0.95, kind="tome", seed=1, **kw):
    a = np.linspace(a0, a0 + sweep, 40)
    pts = np.c_[cx + r * np.cos(a), cy + r * np.sin(a)]
    return stroke(list(map(tuple, pts)), w, kind, seed=seed, **kw)


# ---------------------------------------------------------------- AMR ground
def amr_ground(hot, seed=7, size=64, step=8, wm=1.0):
    """hot: function (x0,y0,x1,y1)->level wanted (0,1,2). Returns 3 path strings."""
    rng = np.random.default_rng(seed)
    out = ["", "", ""]
    wid = [0.24, 0.2, 0.16]

    def seg(level, p, q, split=True):
        if split and rng.random() < 0.45:
            f = rng.uniform(0.3, 0.7)
            g = rng.uniform(0.02, 0.06)
            m1 = (p[0] + (q[0] - p[0]) * (f - g), p[1] + (q[1] - p[1]) * (f - g))
            m2 = (p[0] + (q[0] - p[0]) * (f + g), p[1] + (q[1] - p[1]) * (f + g))
            seg(level, p, m1, False)
            seg(level, m2, q, False)
            return
        L = math.hypot(q[0] - p[0], q[1] - p[1])
        # broken brush dash with overshoot
        o = rng.uniform(-0.5, 0.7)
        o2 = rng.uniform(-0.5, 0.7)
        dx, dy = (q[0] - p[0]) / L, (q[1] - p[1]) / L
        a = (p[0] - dx * o, p[1] - dy * o)
        b = (q[0] + dx * o2, q[1] + dy * o2)
        wob = rng.uniform(-0.12, 0.12)
        m = ((a[0] + b[0]) / 2 - dy * wob, (a[1] + b[1]) / 2 + dx * wob)
        k = "even" if rng.random() < 0.6 else "harai"
        out[level] += " " + stroke([a, m, b], wid[level], k, seed=int(rng.integers(1e9)), jit=0.12, wm=wm, n=max(6, int(L * 0.9)), nd=1)

    n = size // step
    done = set()
    for i in range(n + 1):
        for j in range(n):
            for e in (((i * step, j * step), (i * step, (j + 1) * step)),
                      ((j * step, i * step), ((j + 1) * step, i * step))):
                if e not in done:
                    done.add(e)
                    seg(0, *e)
    for i in range(n):
        for j in range(n):
            x0, y0 = i * step, j * step
            lv = hot(x0, y0, x0 + step, y0 + step)
            if lv >= 1:
                h = step / 2
                seg(1, (x0 + h, y0), (x0 + h, y0 + step))
                seg(1, (x0, y0 + h), (x0 + step, y0 + h))
                for a in (0, 1):
                    for b in (0, 1):
                        xa, ya = x0 + a * h, y0 + b * h
                        if hot(xa, ya, xa + h, ya + h) >= 2:
                            q = h / 2
                            seg(2, (xa + q, ya), (xa + q, ya + h))
                            seg(2, (xa, ya + q), (xa + h, ya + q))
    return [s.strip() for s in out]


def _hot_from_points(pts, r1=4.0, r2=1.6):
    P = np.array(pts)

    def hot(x0, y0, x1, y1):
        dx = np.maximum(np.maximum(x0 - P[:, 0], P[:, 0] - x1), 0)
        dy = np.maximum(np.maximum(y0 - P[:, 1], P[:, 1] - y1), 0)
        d = np.hypot(dx, dy).min()
        return 2 if d <= r2 else (1 if d <= r1 else 0)
    return hot


def sample(pts, n=60):
    return list(map(tuple, _cr(pts, n)))
