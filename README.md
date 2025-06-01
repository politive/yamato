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

### Mode

| Mode                    | Description                                                                                                                                                |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| --omakase               | Installs a recommended set of tools and settings automatically.<br>Best for users who want a ready-to-use, best-practice environment with minimal prompts. |
| --interactive (default) | Lets you interactively select each tool and setting during installation.<br>Best for users who want to customize their setup step by step.                 |
| --preset \<file\>       | Installs tools and settings based on your custom YAML file.<br>*Best for advanced users who want to define their own setup in a file.*                     |

### Examples

```bash
# Omakase (recommended defaults)
curl -L https://raw.githubusercontent.com/politive/yamato/main/boot.sh --omakase | bash

# Interactive (choose each tool)
curl -L https://raw.githubusercontent.com/politive/yamato/main/boot.sh --interactive | bash

# Use your own config file
curl -L https://raw.githubusercontent.com/politive/yamato/main/boot.sh --preset mysetup.yml | bash
```

## 🧰 Tools

### Text Editor
| Tool                                                |
| --------------------------------------------------- |
| [alacritty](https://github.com/alacritty/alacritty) |
| [iterm2](https://github.com/gnachman/iTerm2)        |
| [kitty](https://github.com/kovidgoyal/kitty)        |
| [warp](https://github.com/warpdotdev/warp)          |
| [WezTerm](https://github.com/wez/wezterm)           |

### Docker

| Category        | Tool                                                                  |
| --------------- | --------------------------------------------------------------------- |
| All in One tool | [Docker Desktop for Mac](https://github.com/docker/for-mac)           |
| All in One tool | [Podman Desktop](https://github.com/podman-desktop/podman-desktop)    |
| All in One tool | [Rancher Desktop](https://github.com/rancher-sandbox/rancher-desktop) |
| CLI             | [Docker CLI](https://github.com/docker/cli)                           |
| CLI             | [Docker Compose](https://github.com/docker/compose)                   |
| Deamon          | [Colima](https://github.com/abiosoft/colima)                          |
| Deamon          | [Lima](https://github.com/lima-vm/lima)                               |
| TUI             | [lazydocker](https://github.com/jesseduffield/lazydocker)             |

### Desktop Application

| Tool                                                                                | Description                                                 |
| ----------------------------------------------------------------------------------- | ----------------------------------------------------------- |
| [1Password](https://1password.com)                                                  | Password manager for teams and individuals.                 |
| [Figma](https://www.figma.com)                                                      | Collaborative interface design tool.                        |
| [Spotify](https://www.spotify.com)                                                  | Music streaming service.                                    |
| [Microsoft Teams](https://www.microsoft.com/en/microsoft-teams/group-chat-software) | Communication and collaboration platform for teams.         |
| [Visual Studio Code](https://code.visualstudio.com)                                 | A powerful source-code editor with extensions preinstalled. |

### Other CLI Tool

| Tool                                             | Description                                                    |
| ------------------------------------------------ | -------------------------------------------------------------- |
| [eza](https://github.com/eza-community/eza)      | A modern replacement for `ls` with icons and colors.           |
| [git](https://github.com/git/git)                | A distributed version control system.                          |
| [gum](https://github.com/charmbracelet/gum)      | A tool for building rich shell scripts with interactive UI.    |
| [hackgen](https://github.com/yuru7/HackGen)      | A programming font with Nerd Font support and Japanese glyphs. |
| [libpq](https://github.com/postgres/postgres)    | PostgreSQL client libraries and tools.                         |
| [libyaml](https://github.com/yaml/libyaml)       | A C library for parsing and emitting YAML.                     |
| [mise](https://github.com/jdx/mise)              | A runtime version manager for tools like Node, Ruby, etc.      |
| [starship](https://github.com/starship/starship) | A fast, minimal, and highly customizable shell prompt.         |
| [yq](https://github.com/mikefarah/yq)            | A lightweight and portable command-line YAML processor.        |
| [zsh](https://github.com/zsh-users/zsh)          | A powerful and customizable Unix shell.                        |

## 📄 License

YAMATO is released under the MIT License.  
See the [LICENSE](./LICENSE) file for full details.

## 🙏 Acknowledgements

Inspired by [Omakub](https://omakub.org) and the many dotfiles authors who came before.
