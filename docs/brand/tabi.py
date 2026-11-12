#!/usr/bin/env python3
"""Generate the PENF identity, Tabi in Asagi: python3 docs/brand/tabi.py [DOCS_DIR]

Writes, under DOCS_DIR (default: the docs/ folder this script lives in):
  public/logo.svg, public/logo-dark.svg      hero logo: the mark on its brushed AMR ground, with the seal
  public/mark.svg, public/mark-dark.svg      nav logo: the small cut, no ground, no seal, heavier strokes
  public/favicon.svg                         the small cut, following the visitor's light/dark setting
  public/favicon-16.png, favicon-32.png,     PNG fallbacks, washi tile, plus the iOS home-screen icon
  public/apple-touch-icon.png, favicon.ico   (PNGs need rsvg-convert, the .ico needs ImageMagick)
  public/icons/<name>.svg, <name>-dark.svg   the nine feature icons

The mark, Tabi 旅: an inrō worn on the road, hung from the obi by its netsuke and swinging as you walk.
The one thing in colour is the ojime bead that keeps the five tiers (the kinds) shut; the carved seal
sits lower right in the same colour, over the family's three-level brushed AMR ground.
Every stroke is seeded: the output is identical on every run. Needs numpy.
"""
import math
import os
import shutil
import subprocess
import sys

import numpy as np

sys.dont_write_bytecode = True
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from brush import stroke, blob, ring, sample, fmt, amr_ground, SEAL  # noqa: E402

# --------------------------------------------------------------------------- palette
WASHI = dict(ground="#f3ede1", raised="#f7f2e8", ink="#1d1b18", mesh="#6f6a62", acc="#00788a")
NIGHT = dict(ground="#0e1116", raised="#141820", ink="#e8ecf0", mesh="#8b949e", acc="#3fc8d8")
OPACITY = [0.62, 0.384, 0.186]          # AMR levels 0, 1, 2
ICONS = ["integer-kinds", "real-kinds", "number-to-string", "string-to-number", "binary-strings",
         "format-strings", "limits", "endianness", "multi-licensed"]
LABELS = ["Integer kinds", "Real kinds", "Number to string", "String to number", "Binary strings",
          "Format strings", "Min and max limits", "Endianness", "Multi-licensed"]
W = 1.9

def M():
    return dict(ink=[], acc=[], shadow=[], spine=[], hot=[])



def add(d, layer, pts, w, kind="tome", seed=1, wm=1.0, **kw):
    d[layer].append(stroke(pts, w, kind, seed=seed, wm=wm, **kw))
    d["spine"] += sample(pts, 40)
    if layer == "acc":
        d["hot"] += sample(pts, 40)



def addb(d, layer, cx, cy, rx, ry=None, rot=0, seed=1, wm=1.0):
    d[layer].append(blob(cx, cy, rx * wm ** 0.5, (ry or rx) * wm ** 0.5, rot, seed=seed))
    d["spine"].append((cx, cy))
    if layer == "acc":
        d["hot"].append((cx, cy))



def inro_tabi(wm=1.0):
    d = M()
    add(d, "ink", [(1.0, 13.4), (24, 12.6), (48, 13.2), (63.0, 12.8)], 4.4, "even", 250, wm, kasure=5, k0=0.6)
    add(d, "ink", [(1.0, 19.0), (26, 19.6), (63.0, 18.8)], 2.2, "even", 251, wm, kasure=3, k0=0.7)
    addb(d, "ink", 25.5, 7.4, 4.3, 3.4, -0.2, 252, wm)
    add(d, "ink", [(26.4, 10.4), (27.2, 16), (28.6, 22.8)], 1.0, "even", 253, wm)
    addb(d, "acc", 29.4, 25.4, 3.0, 2.6, 0.3, 254, wm)
    a = math.radians(-9)
    ca, sa = math.cos(a), math.sin(a)
    cx, cy = 34.5, 44.0

    def R(p):
        x, y = p[0] - cx, p[1] - cy
        return (cx + x * ca - y * sa, cy + x * sa + y * ca)
    xl, xr, yt, yb, r = 21.5, 47.5, 31.5, 56.0, 4.6
    segs = [
        ([(xl + r, yt + 0.2), (xl + 1.0, yt + 1.4), (xl - 0.2, yt + r + 0.6), (xl - 0.6, (yt + yb) / 2), (xl, yb - r), (xl + 1.2, yb - 1.1), (xl + r + 1, yb + 0.2)], 2.8, "tome", 0),
        ([(xr - r, yt + 0.2), (xr - 1.0, yt + 1.4), (xr + 0.2, yt + r + 0.6), (xr + 0.6, (yt + yb) / 2), (xr, yb - r), (xr - 1.2, yb - 1.1), (xr - r - 1, yb + 0.2)], 2.8, "tome", 0),
        ([(xl + r - 0.6, yt + 0.3), ((xl + xr) / 2, yt - 0.8), (xr - r + 0.6, yt + 0.3)], 2.7, "tome", 0),
        ([(xl + r, yb + 0.3), ((xl + xr) / 2, yb + 0.9), (xr - r, yb + 0.2)], 2.7, "tome", 4),
    ]
    for k, (pts, w, kind, ks) in enumerate(segs):
        add(d, "ink", [R(p) for p in pts], w, kind, 255 + k, wm, kasure=ks, k0=0.7)
    for k in range(3):
        y = yt + (yb - yt) * (k + 1) / 4
        add(d, "ink", [R((xl + 1.5, y)), R((34.5, y - 0.3)), R((xr - 1.5, y))], 1.05, "even", 260 + k, wm)
    add(d, "ink", [(27.8, 27.6), R((xl - 1.4, 34)), R((xl - 1.9, 48))], 1.0, "even", 264, wm)
    add(d, "ink", [(31.0, 27.4), R((xr + 1.4, 34)), R((xr + 1.9, 48))], 1.0, "even", 265, wm)
    # motion: the swing, two dry strokes
    d["shadow"].append(stroke([(8.0, 38.0), (10.6, 46.0), (14.4, 52.6)], 1.3, "harai", seed=266, wm=wm))
    d["shadow"].append(stroke([(5.0, 43.0), (7.0, 49.0), (10.0, 54.0)], 0.9, "harai", seed=267, wm=wm))
    return d



class P:
    def __init__(self, seed):
        self.ink, self.acc, self.seed = [], [], seed

    def s(self, pts, w=W, kind="tome", a=False, **kw):
        self.seed += 1
        (self.acc if a else self.ink).append(stroke(pts, w, kind, seed=self.seed, jit=0.06, **kw))

    def b(self, cx, cy, rx, ry=None, a=False, rot=0):
        self.seed += 1
        (self.acc if a else self.ink).append(blob(cx, cy, rx, ry or rx, rot, seed=self.seed, jit=0.05))

    def o(self, cx, cy, r, w=1.4, a=False, a0=-1.9):
        self.seed += 1
        (self.acc if a else self.ink).append(ring(cx, cy, r, w, a0=a0, sweep=2 * math.pi * 0.93, seed=self.seed, jit=0.05))

    def out(self):
        return self.ink, self.acc


def text_col(p, x, ys=((3, 7), (9.5, 13.5), (16, 20))):
    for y0, y1 in ys:
        p.s([(x, y0), (x + 0.1, y1)], 1.6, "tome")


def case(p, x0, x1, y0, y1, seams, w=1.7):
    r = min(2.4, (x1 - x0) / 4)
    p.s([(x0 + r, y0), (x0 + 0.4, y0 + 0.9), (x0, y0 + r), (x0 - 0.2, (y0 + y1) / 2), (x0, y1 - r), (x0 + 0.5, y1 - 0.6), (x0 + r + 0.5, y1)], w)
    p.s([(x1 - r, y0), (x1 - 0.4, y0 + 0.9), (x1, y0 + r), (x1 + 0.2, (y0 + y1) / 2), (x1, y1 - r), (x1 - 0.5, y1 - 0.6), (x1 - r - 0.5, y1)], w)
    p.s([(x0 + r - 0.3, y0), ((x0 + x1) / 2, y0 - 0.3), (x1 - r + 0.3, y0)], w)
    p.s([(x0 + r, y1 + 0.1), ((x0 + x1) / 2, y1 + 0.3), (x1 - r, y1 + 0.1)], w)
    for i in range(seams):
        y = y0 + (y1 - y0) * (i + 1) / (seams + 1)
        p.s([(x0 + 1.0, y), ((x0 + x1) / 2, y - 0.15), (x1 - 1.0, y)], 0.85, "even")


def inro_icons():
    I = []
    p = P(2000); case(p, 5, 19, 8.5, 21, 3); p.s([(5.2, 11), (6.5, 6.2), (10.4, 3.9)], 0.7, "even")
    p.s([(18.8, 11), (17.5, 6.2), (13.6, 3.9)], 0.7, "even"); p.b(12, 3.6, 2.0, 1.7, a=True); I.append(p.out())
    p = P(2010); case(p, 4.5, 19.5, 5, 19.5, 2); p.b(12, 12.2, 1.7, a=True); I.append(p.out())
    p = P(2020); p.b(5.2, 5.4, 2.2, 1.9, a=True); p.s([(6.4, 7.4), (8.4, 11.6), (11.6, 14.2)], 0.8, "even")
    text_col(p, 17.8); I.append(p.out())
    p = P(2030); text_col(p, 6.2); p.s([(12.4, 9.6), (15.6, 12.4), (17.4, 16.6)], 0.8, "even")
    p.b(18.8, 18.6, 2.2, 1.9, a=True); I.append(p.out())
    p = P(2040); p.s([(1.4, 12.2), (12, 11.8), (22.6, 12.1)], 0.7, "even"); p.b(5.6, 12, 2.3, 2.0)
    p.o(12, 12, 2.4, 1.3, a=True); p.b(18.4, 12, 2.3, 2.0); I.append(p.out())
    p = P(2050); p.s([(5.0, 7.0), (5.6, 4.6), (12, 3.6), (18.4, 4.6), (19.0, 7.0)], 1.9, a=True)
    case(p, 5, 19, 11, 20.5, 1); I.append(p.out())
    p = P(2060); case(p, 4.5, 19.5, 3.6, 20.4, 0, 2.0); p.s([(6.2, 12.1), (12, 11.8), (17.8, 12.0)], 1.7, a=True); I.append(p.out())
    p = P(2070); case(p, 2.6, 10.4, 9.5, 19.5, 1, 1.5); p.b(6.5, 6.0, 1.9, 1.6, a=True)
    case(p, 13.6, 21.4, 4.5, 14.5, 1, 1.5); p.b(17.5, 18.0, 1.9, 1.6); I.append(p.out())
    return I


def license_icon():
    sq = "M3.2 3.4L20.9 3.1 20.8 20.8 3.1 20.9Z"
    carve = [stroke([(x, 6.4), (x + 0.1, 12), (x, 17.6)], 1.6, "tome", seed=9010 + k, jit=0.05)
             for k, x in enumerate((7.6, 12.0, 16.4))]
    return sq, " ".join(carve)


# --------------------------------------------------------------------------- SVG writers
def svg(vb, body, label):
    return ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="%s" role="img" aria-label="%s">%s</svg>\n' % (vb, label, body))


def mark_body(pal, seed=7):
    d = inro_tabi(1.0)
    S, H = np.array(d["spine"]), np.array(d["hot"] or d["spine"])

    def near(P, m, x0, y0, x1, y1):
        dx = np.maximum(np.maximum(x0 - P[:, 0], P[:, 0] - x1), 0)
        dy = np.maximum(np.maximum(y0 - P[:, 1], P[:, 1] - y1), 0)
        return (np.hypot(dx, dy) <= m).sum()

    def hot(x0, y0, x1, y1):
        if x1 - x0 <= 4.01:
            return 2 if near(H, 0.6, x0, y0, x1, y1) else 0
        return 2 if near(H, 1.0, x0, y0, x1, y1) else (1 if near(S, 0.0, x0, y0, x1, y1) >= 6 else 0)
    out = []
    for i, s in enumerate(amr_ground(hot, seed=seed)):
        if s:
            out.append('<path fill="%s" opacity="%s" d="%s"/>' % (pal["mesh"], OPACITY[i], s))
    for s in d["shadow"]:
        out.append('<path fill="%s" opacity="0.5" d="%s"/>' % (pal["mesh"], s))
    out.append('<path fill="%s" d="%s"/>' % (pal["ink"], " ".join(d["ink"])))
    out.append('<path fill="%s" d="%s"/>' % (pal["acc"], " ".join(d["acc"])))
    out.append('<path fill="%s" fill-rule="evenodd" d="%s"/>' % (pal["acc"], SEAL))
    return "".join(out)


def small_paths(cls=False, pal=None):
    d = inro_tabi(1.45)
    if cls:
        return ('<path class="i" d="%s"/><path class="a" d="%s"/>' % (" ".join(d["ink"]), " ".join(d["acc"])))
    return ('<path fill="%s" d="%s"/><path fill="%s" d="%s"/>' % (pal["ink"], " ".join(d["ink"]), pal["acc"], " ".join(d["acc"])))


SMALL_VB = "2 2 60 60"


def favicon_svg():
    style = ("<style>.i{fill:%s}.a{fill:%s}@media (prefers-color-scheme: dark){.i{fill:%s}.a{fill:%s}}</style>"
             % (WASHI["ink"], WASHI["acc"], NIGHT["ink"], NIGHT["acc"]))
    return svg(SMALL_VB, style + small_paths(cls=True), "PENF")


def tile_svg(pal, radius):
    # the small cut on a washi (or night) tile, for the PNG favicons
    return ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64"><rect width="64" height="64" rx="%s" fill="%s"/>'
            '<g transform="translate(3 3) scale(0.9667) translate(-2 -2)">%s</g></svg>\n'
            % (radius, pal["ground"], small_paths(pal=pal)))


def icon_svgs(pal):
    out = {}
    for name, label, (ink, acc) in zip(ICONS, LABELS, inro_icons()):
        out[name] = svg("0 0 24 24", '<path fill="%s" d="%s"/><path fill="%s" d="%s"/>' % (pal["ink"], " ".join(ink), pal["acc"], " ".join(acc)), label)
    sq, carve = license_icon()
    out["multi-licensed"] = svg("0 0 24 24", '<path fill="%s" d="%s"/><path fill="%s" d="%s"/>' % (pal["acc"], sq, pal["ground"], carve), LABELS[-1])
    return out


def main():
    docs = sys.argv[1] if len(sys.argv) > 1 else os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    pub = os.path.join(docs, "public")
    os.makedirs(os.path.join(pub, "icons"), exist_ok=True)

    def w(rel, s):
        with open(os.path.join(pub, rel), "w", encoding="utf-8") as f:
            f.write(s)
    w("logo.svg", svg("0 0 64 64", mark_body(WASHI), "PENF"))
    w("logo-dark.svg", svg("0 0 64 64", mark_body(NIGHT, seed=11), "PENF"))
    w("mark.svg", svg(SMALL_VB, small_paths(pal=WASHI), "PENF"))
    w("mark-dark.svg", svg(SMALL_VB, small_paths(pal=NIGHT), "PENF"))
    w("favicon.svg", favicon_svg())
    for suf, pal in (("", WASHI), ("-dark", NIGHT)):
        for name, s in icon_svgs(pal).items():
            w("icons/%s%s.svg" % (name, suf), s)
    rsvg = shutil.which("rsvg-convert")
    if rsvg:
        tmp = os.path.join(pub, "_tile.svg")
        for name, size, radius in (("favicon-16.png", 16, 12), ("favicon-32.png", 32, 12), ("apple-touch-icon.png", 180, 0)):
            with open(tmp, "w") as f:
                f.write(tile_svg(WASHI, radius))
            subprocess.run([rsvg, "-w", str(size), "-h", str(size), tmp, "-o", os.path.join(pub, name)], check=True)
        os.remove(tmp)
        magick = shutil.which("magick") or shutil.which("convert")
        if magick:
            subprocess.run([magick, os.path.join(pub, "favicon-16.png"), os.path.join(pub, "favicon-32.png"),
                            os.path.join(pub, "favicon.ico")], check=True)
    else:
        print("rsvg-convert not found: SVGs written, PNG favicons skipped")
    print("PENF identity written to", pub)


if __name__ == "__main__":
    main()
