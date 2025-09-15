<p align="center">
  <img src="./logo.png" width="600" alt="Logo" />
</p>

<p align="center">
  A macOS bootstrapper for developers who want a clean setup with defaults.
</p>

## 🚀 Quick Start

```bash
curl -L https://raw.githubusercontent.com/politive/yamato/main/boot.sh | bash
```

### Options

| Option        | Description                                     |
| ------------- | ----------------------------------------------- |
| `--verbose`   | Enable verbose logging output                   |
| `--dryrun`    | Perform a dry run without making actual changes |
| `--skip-pull` | Skip git pull if yamato is already installed    |
| `--dev`       | Development mode (keeps .gitignore unchanged)   |
| `--help`      | Show help information                           |

### Examples

```bash
# Basic installation
curl -L https://raw.githubusercontent.com/politive/yamato/main/boot.sh | bash

# With verbose output
curl -L https://raw.githubusercontent.com/politive/yamato/main/boot.sh --verbose | bash

# Dry run (test without changes)
curl -L https://raw.githubusercontent.com/politive/yamato/main/boot.sh --dryrun | bash

# Skip git pull if already installed
curl -L https://raw.githubusercontent.com/politive/yamato/main/boot.sh --skip-pull | bash
```

## ⚙️ Configuration

YAMATO uses YAML configuration files to define tools, settings, and file operations. You can customize your setup by creating or modifying `yamato.yaml` in your repository.

### YAML Structure

```yaml
# macOS defaults configuration
defaults:
  - domain: com.apple.dock
    key: autohide
    type: bool
    value: true
    comment: "Enabling auto-hide"

# Tools installation and configuration
tools:
  - command: git
    description: "Version control system"
    check:  # Check if already installed
      type: path
      value: /opt/homebrew/bin/git
```

### Configuration Options

| Option        | Description                        | Example                               |
| ------------- | ---------------------------------- | ------------------------------------- |
| `command`     | Homebrew package name              | `starship`                            |
| `description` | Tool description (optional)        | `"Cross-shell prompt for astronauts"` |
| `check.type`  | Check method (`command` or `path`) | `command`                             |
| `check.value` | Expected command or path to check  | `starship`                            |
| `cask`        | Install as Homebrew cask           | `true`                                |
| `tap`         | Custom Homebrew tap                | `politive/kimigayo`                   |

### Post-Install Scripts

YAMATO automatically detects and runs post-installation scripts by placing `post_install.sh` in `yamato.d/tools/{command}/post_install.sh`

Example auto-detection:
```bash
# yamato.d/tools/colima/post_install.sh
if command -v colima >/dev/null 2>&1; then
  log_skipped "colima service start (already installed)"
else
  brew services start colima
  log_applied "colima service started"
fi
```

### File Operations

YAMATO automatically creates symlinks from `yamato.d/tools/{command}/dotfiles/` to your home directory. Simply place your configuration files in the appropriate tool directory and they will be automatically linked.

## 📄 License

YAMATO is released under the MIT License.  
See the [LICENSE](./LICENSE) file for full details.

## 🙏 Acknowledgements

Inspired by [Omakub](https://omakub.org) and the many dotfiles authors who came before.
