# Contributing

## Commit style

PENF uses [Conventional Commits](https://www.conventionalcommits.org/) so that `CHANGELOG.md` is generated automatically from the git log:

| Prefix | Purpose | Changelog section |
|--------|---------|-------------------|
| `feat:` | New feature or capability | New features |
| `fix:` | Bug fix | Bug fixes |
| `perf:` | Performance improvement | Performance |
| `refactor:` | Code restructuring | Refactoring |
| `docs:` | Documentation only | Documentation |
| `test:` | Tests | Testing |
| `build:` | Build system | Build system |
| `ci:` | CI/CD pipeline | CI/CD |
| `chore:` | Maintenance | Miscellaneous |

Append `!` for breaking changes (`feat!:`, `fix!:`). Reference issues with `#123` — they are auto-linked.

```
feat: add R32P kind parameter
fix: correct byte_size for character arrays (#42)
feat!: rename check_endian to init_endian
```

---

## Creating a release

Releases are fully automated via `scripts/bump.sh` and GitHub Actions. The only steps needed are:

```bash
# Install git-cliff once
npx git-cliff@latest

# Then, to release:
scripts/bump.sh patch   # v1.2.3 → v1.2.4
scripts/bump.sh minor   # v1.2.3 → v1.3.0
scripts/bump.sh major   # v1.2.3 → v2.0.0
scripts/bump.sh v2.1.0  # explicit version
```

`bump.sh` will ask for confirmation, then:

1. Regenerate `CHANGELOG.md` from the git log via [git-cliff](https://git-cliff.org/)
2. Commit with `chore(release): vX.Y.Z`
3. Create an annotated git tag
4. Push commit + tag

Pushing the tag triggers the GitHub Actions release workflow, which automatically:
- Runs the full test suite and uploads coverage to Codecov
- Builds this documentation site and deploys it to GitHub Pages
- Packages a versioned tarball `PENF-vX.Y.Z.tar.gz`
- Publishes a GitHub release with the changelog section as release notes

