<p align="center">
  <img src="./logo.png" width="600" alt="Logo" />
</p>

<p align="center">
  A macOS bootstrapper for developers who want a clean setup with defaults.
</p>

## 🚀 Quick Start

### Option 1: Use the original repository

```bash
# Clone and run yamato
git clone https://github.com/politive/yamato.git ~/.local/share/yamato
cd ~/.local/share/yamato
./yamato

# Run yamato again (after initial installation)
yamato
```

### Option 2: Fork and customize (Recommended)

```bash
# 1. Fork this repository on GitHub
# 2. Clone your fork
git clone https://github.com/yourusername/yamato.git ~/.local/share/yamato
cd ~/.local/share/yamato

# 3. Run yamato with your fork
YAMATO_REPO=yourusername/yamato ./yamato

# 4. Run yamato again (after initial installation)
YAMATO_REPO=yourusername/yamato yamato
```

### Options

| Option        | Description                                     |
| ------------- | ----------------------------------------------- |
| `--verbose`   | Enable verbose logging output                   |
| `--dryrun`    | Perform a dry run without making actual changes |
| `--skip-pull` | Skip git pull if yamato is already installed    |
| `--dev`       | Development mode (keeps .gitignore unchanged)   |
| `--help`      | Show help information                           |

### Environment Variables

| Variable      | Description                            | Default           |
| ------------- | -------------------------------------- | ----------------- |
| `YAMATO_REPO` | GitHub repository in `org/repo` format | `politive/yamato` |

### Examples

```bash
# Basic installation
curl -L https://raw.githubusercontent.com/politive/yamato/main/yamato | bash

# Run yamato with options
yamato --verbose
yamato --dryrun
yamato --skip-pull
yamato --help
```

## ⚙️ Configuration

YAMATO uses YAML configuration files to define tools, settings, and file operations. To customize your setup:

1. **Fork this repository** to your GitHub account
2. **Clone your fork** to `~/.local/share/yamato`
3. **Modify `yamato.yaml`** to add your tools and settings
4. **Update `yamato.d/`** with your configuration files
5. **Run yamato** from your local repository

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

| Option        | Description                       | Default    | Example                               |
| ------------- | --------------------------------- | ---------- | ------------------------------------- |
| `command`     | Homebrew package name             | -          | `starship`                            |
| `description` | Tool description (optional)       | -          | `"Cross-shell prompt for astronauts"` |
| `check.type`  | How to check if tool is installed | `command`  | `command` or `path`                   |
| `check.value` | What to check for                 | `$command` | `starship` or `/opt/homebrew/bin/git` |
| `cask`        | Install as Homebrew cask          | `false`    | `true`                                |
| `tap`         | Custom Homebrew tap               | -          | `politive/kimigayo`                   |

**Check Types:**
- `command`: Check if command exists in PATH (default)
- `path`: Check if specific file path exists

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

### PATH Configuration

After installation, add the following to your `~/.zshrc` to use the `yamato` command:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

This is already included in the provided `.zshrc` sample.

## 📄 License

YAMATO is released under the MIT License.  
See the [LICENSE](./LICENSE) file for full details.

## 🙏 Acknowledgements

Inspired by [Omakub](https://omakub.org) and the many dotfiles authors who came before.
