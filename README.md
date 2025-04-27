# clipkit

**clipkit** is a lightweight, modular, command-line clipboard toolkit designed for minimal Linux environments, including headless systems like Raspberry Pi and WSL2.

It provides a set of simple, scriptable utilities to manage text clipboards without requiring a graphical environment or heavy dependencies.

---

## Features

- Minimal dependencies (pure Bash)
- Supports standard clipboard actions:
  - Copy text
  - Append text
  - Paste text
  - Run text as a command (with confirmation)
  - Clear clipboard
  - Edit clipboard manually
- Auto-discovered, self-documenting tools
- Colorized, organized `cliphelp`
- Versioned and future-proof
- Designed for DietPi, WSL2, Raspberry Pi, and lightweight Linux setups

---

## Installation

You can install clipkit into your personal `~/bin/` directory using `make`:

```bash
git clone https://github.com/dvonpasecky/clipkit.git
cd clipkit
make install
```

This will install the clipkit commands to `~/bin`, assuming it is in your `PATH`.

> **Note:** You can customize the install location by editing the `Makefile`.

---

## Uninstallation

To remove clipkit from your system:

```bash
make uninstall
```

---

## Quick Start

| Command | Description |
|:--------|:------------|
| `clipcopy "some text"` | Copy text to clipboard |
| `clipappend "more text"` | Append text to clipboard |
| `clippaste` | Print clipboard contents |
| `cliprun` | Run clipboard contents as a command (with confirmation) |
| `clipedit` | Manually edit clipboard contents with `nano` |
| `clipclear` | Clear clipboard contents |
| `cliphelp` | Display help for all installed clipkit tools |

---

## Usage Examples

Copy text:

```bash
clipcopy "ls -la /var/log"
```

Append more text:

```bash
clipappend "df -h"
```

View clipboard:

```bash
clippaste
```

Run clipboard contents safely:

```bash
cliprun
```

Edit clipboard manually:

```bash
clipedit
```

Clear the clipboard:

```bash
clipclear
```

See all available commands:

```bash
cliphelp
```

Check the version of any clipkit tool:

```bash
clipcopy --version
```

Get help for any clipkit tool:

```bash
clipcopy --help
```

---

## Philosophy

clipkit is built with a few key principles:
- **Simplicity**: Only pure Bash. No dependencies beyond the POSIX shell.
- **Transparency**: Clipboard contents are plain-text files (`~/clipboard.txt`).
- **Safety**: Confirmation before running commands.
- **Extensibility**: Easy to add new tools that auto-register into `cliphelp`.
- **Minimalism**: Perfect for lightweight and headless Linux environments.

---

## License

This project is licensed under the [MIT License](LICENSE).

---

## Contributing

Contributions are welcome! Feel free to fork the project, submit pull requests, or open issues for ideas, bugs, or feature requests.

Please keep contributions consistent with the lightweight and minimal design goals of clipkit.

---

## Credits

Developed by [Dan Von Pasecky](https://github.com/dvonpasecky) with ❤️ for the Linux community.
