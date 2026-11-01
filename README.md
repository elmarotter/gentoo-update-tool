# Gentoo Update Tool

A minimalistic, reliable update script for Gentoo Linux.  
This tool automates the full Gentoo maintenance workflow while keeping everything transparent and under user control.  
It is designed for users who understand Gentoo’s internals and want a predictable, reproducible update cycle without unnecessary complexity.

---

## Clone & Run

```bash
git clone https://github.com/elmarotter/gentoo-update-tool.git
cd gentoo-update-tool
chmod u+x ./update_new_NL-NL.sh
chmod u+x ./update_new.sh
./update_new.sh 
```
For Dutch version run:
```bash
./update_new_NL-NL.sh
```
---

## Features

- Sync Portage
- Update @world
- Rebuild reverse dependencies
- Clean unused packages
- Check preserved libraries
- Apply config file updates
- Optional detection of unused USE flags
- Optional detection of outdated language targets (PHP, Python, etc.)
- Generate package.accept_keywords entries in the format:
  `=category/package-version ~amd64`
- Interactive category-based keyword generation
- Clear, structured output
- No hidden magic — every step is explicit

---

## Why this tool exists

Gentoo gives you full control, but the update process can be repetitive.  
This script captures the best‑practice sequence that experienced Gentoo users normally run manually and turns it into a consistent workflow.

It does **not** hide complexity — it simply removes the tedium.

---

## Usage

Run as a normal user. The script will use sudo only for operations that require elevated privileges.

```bash
./update_new.sh
```

The script will:
1 Sync Portage with eix-sync
2 Update
3 Update using binary packages
4 Clean
5 Remove old kernels
6 @preserved-rebuild
7 Check and repair
8 Run eix-test-obsolete
9 Update configuration files
10 Rebuild system
11 Rebuild world
12 Rebuild system and world
13 Show news
14 Show all news
15 Perl cleaner all
16 Perl cleaner reallyall
17 Clean distfiles
18 Show installed packages
19 Generate ~amd64 keywords by category
20 Exit

You remain in full control of USE‑flag changes and configuration merges.

---

## Requirements

- Gentoo Linux  
- Portage  
- Standard system tools (bash, diff, etc.)  

---

## License (MIT)

```text
MIT License

Copyright (c) 2024 Elmar Otter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN THE SOFTWARE.
```
