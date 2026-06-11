#!/usr/bin/env bash
set -euo pipefail

# ─────────────────────────────────────────────
#  Dotfiles installer — macOS (brew) & Ubuntu
# ─────────────────────────────────────────────

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_VERSION="0.12.3"   # bump here when upgrading

# ── colours ──────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; BOLD='\033[1m'; RESET='\033[0m'

info()    { echo -e "${BLUE}[INFO]${RESET}  $*"; }
success() { echo -e "${GREEN}[OK]${RESET}    $*"; }
warn()    { echo -e "${YELLOW}[WARN]${RESET}  $*"; }
error()   { echo -e "${RED}[ERROR]${RESET} $*" >&2; exit 1; }
step()    { echo -e "\n${BOLD}▶ $*${RESET}"; }

# ── OS detection ─────────────────────────────
detect_os() {
  case "$(uname -s)" in
    Darwin) echo "macos" ;;
    Linux)
      if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
          ubuntu|debian|linuxmint|pop) echo "debian" ;;
          fedora|rhel|centos|rocky)    echo "fedora" ;;
          arch|manjaro)                echo "arch"   ;;
          *) echo "linux" ;;
        esac
      else
        echo "linux"
      fi
      ;;
    *) error "Unsupported OS: $(uname -s)" ;;
  esac
}

OS=$(detect_os)
info "Detected OS: ${OS}"

# ── helpers ──────────────────────────────────
cmd_exists() { command -v "$1" &>/dev/null; }

symlink() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    warn "Backing up existing $dst → ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -sfn "$src" "$dst"
  success "Linked $src → $dst"
}

# ── package managers ─────────────────────────
install_brew() {
  if ! cmd_exists brew; then
    step "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add brew to PATH for Apple Silicon
    if [ -f /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  else
    success "Homebrew already installed"
  fi
}

brew_install() {
  local pkg="$1"
  if brew list "$pkg" &>/dev/null; then
    success "$pkg already installed"
  else
    info "brew install $pkg"
    brew install "$pkg"
  fi
}

apt_install() {
  info "apt install $*"
  sudo apt-get install -y "$@"
}

# ── Neovim ───────────────────────────────────
install_neovim_macos() {
  brew_install neovim
}

install_neovim_debian() {
  if cmd_exists nvim; then
    local current
    current=$(nvim --version | head -1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
    if [ "$current" = "$NVIM_VERSION" ]; then
      success "Neovim ${current} already installed"
      return
    fi
    warn "Found Neovim ${current}, want ${NVIM_VERSION} — reinstalling"
  fi

  step "Installing Neovim ${NVIM_VERSION} (appimage)"
  local arch
  arch=$(uname -m)
  local url

  if [ "$arch" = "x86_64" ]; then
    url="https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-x86_64.appimage"
  elif [ "$arch" = "aarch64" ]; then
    # ARM64: build from tarball
    url="https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-arm64.appimage"
  else
    error "Unsupported architecture: $arch"
  fi

  local tmp
  tmp=$(mktemp -d)
  curl -fsSL "$url" -o "$tmp/nvim.appimage"
  chmod +x "$tmp/nvim.appimage"

  # Extract appimage (works without FUSE)
  cd "$tmp"
  ./nvim.appimage --appimage-extract &>/dev/null
  sudo rm -rf /opt/nvim
  sudo mv "$tmp/squashfs-root" /opt/nvim
  sudo ln -sfn /opt/nvim/usr/bin/nvim /usr/local/bin/nvim
  rm -rf "$tmp"
  success "Neovim installed at /usr/local/bin/nvim"
}

install_neovim_fedora() {
  if cmd_exists nvim; then
    success "Neovim already installed ($(nvim --version | head -1))"
    return
  fi
  sudo dnf install -y neovim
}

install_neovim_arch() {
  if cmd_exists nvim; then
    success "Neovim already installed ($(nvim --version | head -1))"
    return
  fi
  sudo pacman -S --noconfirm neovim
}

# ── Core dependencies ─────────────────────────
install_deps_macos() {
  step "Installing dependencies (macOS)"
  brew_install git
  brew_install curl
  brew_install ripgrep
  brew_install fd
  brew_install lazygit
  brew_install node       # for many LSP servers
  brew_install python3
  brew_install go
}

install_deps_debian() {
  step "Installing dependencies (Debian/Ubuntu)"
  sudo apt-get update -qq
  apt_install git curl wget unzip build-essential python3 python3-pip

  # ripgrep
  if ! cmd_exists rg; then
    info "Installing ripgrep"
    local rg_ver="14.1.1"
    local arch
    arch=$(uname -m)
    local deb="ripgrep_${rg_ver}-1_${arch}.deb"
    # Map arch names
    [ "$arch" = "x86_64" ] && deb="ripgrep_${rg_ver}-1_amd64.deb"
    [ "$arch" = "aarch64" ] && deb="ripgrep_${rg_ver}-1_arm64.deb"
    local url="https://github.com/BurntSushi/ripgrep/releases/download/${rg_ver}/${deb}"
    wget -qO /tmp/rg.deb "$url" && sudo dpkg -i /tmp/rg.deb && rm /tmp/rg.deb
  else
    success "ripgrep already installed"
  fi

  # fd-find
  if ! cmd_exists fd && ! cmd_exists fdfind; then
    apt_install fd-find
    # Ubuntu installs it as fdfind — make fd alias
    if ! cmd_exists fd && cmd_exists fdfind; then
      mkdir -p ~/.local/bin
      ln -sfn "$(command -v fdfind)" ~/.local/bin/fd
    fi
  else
    success "fd already installed"
  fi

  # lazygit
  if ! cmd_exists lazygit; then
    info "Installing lazygit"
    local lg_ver
    lg_ver=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
      | grep '"tag_name"' | sed 's/.*"v\([^"]*\)".*/\1/')
    local arch
    arch=$(uname -m)
    local tar_arch="Linux_x86_64"
    [ "$arch" = "aarch64" ] && tar_arch="Linux_arm64"
    local url="https://github.com/jesseduffield/lazygit/releases/download/v${lg_ver}/lazygit_${lg_ver}_${tar_arch}.tar.gz"
    curl -fsSL "$url" | tar xz -C /tmp lazygit
    sudo mv /tmp/lazygit /usr/local/bin/lazygit
  else
    success "lazygit already installed"
  fi

  # Node.js (for LSP servers)
  if ! cmd_exists node; then
    info "Installing Node.js via NodeSource"
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    apt_install nodejs
  else
    success "Node.js already installed ($(node --version))"
  fi
}

install_deps_fedora() {
  step "Installing dependencies (Fedora)"
  sudo dnf install -y git curl wget unzip gcc make python3 python3-pip ripgrep fd-find nodejs

  if ! cmd_exists lazygit; then
    info "Installing lazygit"
    sudo dnf copr enable atim/lazygit -y
    sudo dnf install -y lazygit
  fi
}

install_deps_arch() {
  step "Installing dependencies (Arch)"
  sudo pacman -S --noconfirm git curl wget unzip base-devel python python-pip ripgrep fd lazygit nodejs npm
}

# ── Fonts ────────────────────────────────────
install_nerd_font_macos() {
  step "Installing Nerd Font (JetBrainsMono)"
  if ! brew list --cask font-jetbrains-mono-nerd-font &>/dev/null; then
    brew install --cask font-jetbrains-mono-nerd-font
    success "JetBrainsMono Nerd Font installed — set it in your terminal"
  else
    success "JetBrainsMono Nerd Font already installed"
  fi
}

install_nerd_font_linux() {
  step "Installing Nerd Font (JetBrainsMono)"
  local font_dir="$HOME/.local/share/fonts/JetBrainsMono"
  if [ -d "$font_dir" ]; then
    success "JetBrainsMono Nerd Font already installed"
    return
  fi
  mkdir -p "$font_dir"
  local url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
  curl -fsSL "$url" | tar xJ -C "$font_dir"
  fc-cache -f "$font_dir"
  success "JetBrainsMono Nerd Font installed — set it in your terminal"
}

# ── Symlinks ──────────────────────────────────
link_configs() {
  step "Linking config files"
  symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
}

# ── Plugin bootstrap ──────────────────────────
bootstrap_nvim_plugins() {
  step "Bootstrapping Neovim plugins (lazy.nvim)"
  nvim --headless "+Lazy! restore" +qa 2>/dev/null || \
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
  success "Plugins installed"
}

# ── Shell PATH helpers ────────────────────────
ensure_path_entries() {
  local shell_rc=""
  case "$SHELL" in
    */zsh)  shell_rc="$HOME/.zshrc" ;;
    */bash) shell_rc="$HOME/.bashrc" ;;
  esac

  if [ -z "$shell_rc" ]; then return; fi

  local entries=()
  [ -d "$HOME/.local/bin" ] && entries+=('export PATH="$HOME/.local/bin:$PATH"')

  for entry in "${entries[@]}"; do
    if ! grep -qF "$entry" "$shell_rc" 2>/dev/null; then
      echo "$entry" >> "$shell_rc"
      info "Added to $shell_rc: $entry"
    fi
  done
}

# ── Main ─────────────────────────────────────
main() {
  echo -e "${BOLD}"
  echo "╔══════════════════════════════════╗"
  echo "║      dotfiles installer          ║"
  echo "╚══════════════════════════════════╝"
  echo -e "${RESET}"

  case "$OS" in
    macos)
      install_brew
      install_deps_macos
      install_neovim_macos
      install_nerd_font_macos
      ;;
    debian)
      install_deps_debian
      install_neovim_debian
      install_nerd_font_linux
      ensure_path_entries
      ;;
    fedora)
      install_deps_fedora
      install_neovim_fedora
      install_nerd_font_linux
      ;;
    arch)
      install_deps_arch
      install_neovim_arch
      install_nerd_font_linux
      ;;
    *)
      warn "Unknown Linux variant — skipping package install. Install neovim, ripgrep, fd, lazygit, node manually."
      ;;
  esac

  link_configs
  bootstrap_nvim_plugins

  echo -e "\n${GREEN}${BOLD}✓ 설치 완료!${RESET}"
  echo ""
  echo "  nvim 실행 후 Mason이 LSP 서버를 자동 설치합니다."
  echo "  :Mason 으로 설치 상황을 확인할 수 있습니다."
  echo ""
  echo "  터미널 폰트를 'JetBrainsMono Nerd Font'로 설정하세요."
  echo ""
}

main "$@"
