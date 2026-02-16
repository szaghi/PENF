---
layout: home

hero:
  name: PENF
  text: Portability Environment for Fortran Poor People
  tagline: A KISS library for portable, parametrized numerical types in modern Fortran (2003+)
  actions:
    - theme: brand
      text: Guide
      link: /guide/
    - theme: alt
      text: API Reference
      link: /api/
    - theme: alt
      text: View on GitHub
      link: https://github.com/szaghi/PENF

features:
  - icon: 🔢
    title: Portable Kind Parameters
    details: Integer and real kind parameters for 1, 2, 4, 8, and 16-byte representations — guaranteed portable across compilers and architectures.
  - icon: 🔄
    title: Number ↔ String Conversion
    details: Comprehensive str(), strz(), cton(), bstr() and bcton() procedures for casting between numbers and strings, including binary representations.
  - icon: 📐
    title: Format Definitions & Limits
    details: Ready-made format strings (FI*P, FR*P) and min/max representable values for every supported kind parameter.
  - icon: 🖥️
    title: Endianness Detection
    details: Built-in check_endian() procedure to detect big- or little-endian byte ordering at runtime.
  - icon: 🧩
    title: Fortran 2003+ Compliant
    details: Fully standard-compliant library. Tested with GNU (≥ 4.9.2) and Intel (≥ 12.x) compilers.
  - icon: 🆓
    title: Free & Open Source
    details: Multi-licensed — GPLv3 for FOSS projects, BSD 2/3-Clause or MIT for commercial use. Any contributor is welcome.
---

## Copyrights

PENF is distributed under a multi-licensing system:

- **FOSS projects**: [GPL v3](http://www.gnu.org/licenses/gpl-3.0.html)
- **Closed source / commercial**: [BSD 2-Clause](http://opensource.org/licenses/BSD-2-Clause), [BSD 3-Clause](http://opensource.org/licenses/BSD-3-Clause), or [MIT](http://opensource.org/licenses/MIT)

Anyone interested in using, developing, or contributing to PENF is welcome — pick the license that best fits your needs.
