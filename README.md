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
  - name: starship
    command: starship
    check:
      type: command
      value: starship
    hooks:
      post: $YAMATO_D_PATH/tools/starship/export.zsh
    symlinks:
      - source: $YAMATO_D_PATH/tools/starship/starship.toml
        target: $HOME/.config/starship.toml
    copies:
      - source: "$YAMATO_D_PATH/dotfiles/.docker/config.json"
        target: "$HOME/.docker/config.json"
        force: true

# Global symlinks
symlinks:
  - source: "$YAMATO_D_PATH/dotfiles/.zshrc"
    target: "$HOME/.zshrc"

# Global file copies
copies:
  - source: "$YAMATO_D_PATH/dotfiles/.editorconfig"
    target: "$HOME/.editorconfig"
    force: true
```

### Configuration Options

| Option        | Description                        | Example                                    |
| ------------- | ---------------------------------- | ------------------------------------------ |
| `name`        | Tool identifier                    | `starship`                                 |
| `command`     | Homebrew package name              | `starship`                                 |
| `check.type`  | Check method (`command` or `path`) | `command`                                  |
| `check.value` | Expected command or path           | `starship`                                 |
| `hooks.post`  | Post-installation script           | `$YAMATO_D_PATH/tools/starship/export.zsh` |
| `symlinks`    | Create symbolic links              | See example above                          |
| `copies`      | Copy files with optional force     | See example above                          |
| `force`       | Force overwrite existing files     | `true`                                     |

### File Operations

- **Symlinks**: Create symbolic links from source to target
- **Copies**: Copy files from source to target
  - `force: true` - Overwrite existing files
  - `force: false` (default) - Skip if target exists

## 📄 License

YAMATO is released under the MIT License.  
See the [LICENSE](./LICENSE) file for full details.

## 🙏 Acknowledgements

Inspired by [Omakub](https://omakub.org) and the many dotfiles authors who came before.
