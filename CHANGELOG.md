# Changelog

All notable changes to this project are documented here.
Versions follow [Semantic Versioning](https://semver.org/).
Format follows [Keep a Changelog](https://keepachangelog.com/).

## [2.0.1] — 2026-10-02
### Fixed
- **cmake**: Repair find_package config and read version from VERSION


## [2.0.0] — 2026-10-02
### Fixed
- **stringify**: Make real str exact, bstr endian-free, rename _R16P ⚠ BREAKING CHANGE


## [1.3.18] — 2026-10-02
### Fixed
- **fobos**: Correct gcov invocation in makecoverage rule

- **fobos**: Move gcov out of makecoverage to fix CI

- **docs**: Untrack package-lock and pin esbuild for lock-free vite build

- **cmake**: Define _R16P when quadruple precision real is supported


## [1.3.15] — 2026-02-27
### Documentation
- **install**: Overhaul README and install guide


## [1.3.14] — 2026-02-27
### Added
- **release**: Add VERSION file kept in sync by bump.sh


## [1.3.13] — 2026-02-18
### Documentation
- **index**: Correct contributing.md link


## [1.3.12] — 2026-02-18
### Documentation
- **index**: Add quick start section with kind tables and format strings


## [1.3.11] — 2026-02-18
### Documentation
- **contributing**: Expand guide with coding style and PR workflow

- **guide**: Restructure guide with Introduction/Getting Started/Project sections


## [1.3.8] — 2026-02-17
### Fixed
- **ci**: Sync formal generate flags and ford config filename across build files


## [1.3.7] — 2026-02-17
### Documentation
- Restructure API docs layout and add Mermaid diagram support


## [1.3.6] — 2026-02-16
### Documentation
- Minor update in documentations


## [1.3.0] — 2026-02-16
### Added
- **memcheck**: Add help-methods for allocatables

- Migrate documentations to FORMAL (ford2vitepress)

- Improve release and CI workflow, add bump.sh script


### Fixed
- Fix issue #25 on type mismatch memory

- Try to ammend vitepress vulnerability warnings

- Fix bug on GH action CI

- Fix bug in bump.sh script



