**Gentoo Update Tool**
This tool automates the full Gentoo maintenance workflow while keeping everything transparent and under user control.  
It is designed for users who understand Gentoo’s internals and want a predictable, reproducible update cycle without unnecessary complexity.
---
Features
• Sync Portage
• Update @world
• Rebuild reverse dependencies
• Clean unused packages
• Check preserved libraries
• Apply config file updates
• Optional detection of unused USE flags
• Optional detection of outdated language targets (PHP, Python, etc.)
• Clear, structured output
• No hidden magic — every step is explicit
---
Why this tool exists
Gentoo gives you full control, but the update process can be repetitive.  
This script captures the best‑practice sequence that experienced Gentoo users normally run manually and turns it into a consistent workflow.
It does not hide complexity — it simply removes the tedium.
---
Usage
Run as root:
./update_new.sh

he script will:
1. Sync Portage
2. Update @world
3. Rebuild reverse dependencies
4. Check for preserved libraries
5. Clean unused packages
6. Apply config updates
7. Optionally detect unused USE flags
You remain in full control of USE‑flag changes and configuration merges.
---
Requirements
• Gentoo Linux
• Portage
• Standard system tools (bash, diff, etc.)

**Clone & Run**
git clone https://github.com/elmarotter/gentoo-update-tool.git
cd gentoo-update-tool
sudo ./update_new.sh

License (MIT)
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

