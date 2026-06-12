# dotfiles

개인 개발 환경 설정 (Neovim + 플러그인)

## 지원 환경

| OS | 방법 |
|---|---|
| macOS | Homebrew |
| Ubuntu / Debian | apt + GitHub Releases |

## 설치

### 원라인 (권장)

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/nn1a/dotfiles/main/install.sh)
```

스크립트가 `~/dotfiles`로 자동 clone 후 설치를 진행합니다.  
이미 `~/dotfiles`가 있으면 `git pull`로 최신화한 뒤 설치합니다.

### 수동

```bash
git clone https://github.com/nn1a/dotfiles.git ~/dotfiles
bash ~/dotfiles/install.sh
```

## 스크립트가 설치하는 것

| 항목 | macOS | Ubuntu |
|---|---|---|
| Neovim | brew | AppImage |
| ripgrep, fd | brew | GitHub Release |
| lazygit | brew | GitHub Release |
| Node.js | brew | NodeSource |
| Go | brew | dl.google.com |
| rustup + rust-analyzer | curl | curl |
| ruff | brew | pip |
| tree-sitter CLI | npm | npm |
| JetBrainsMono Nerd Font | brew cask | ~/.local/share/fonts |
| ~/.config/nvim | symlink → ~/dotfiles/nvim | ← |
| Neovim 플러그인 | lazy.nvim 자동 설치 | ← |

## 구조

```
dotfiles/
├── install.sh              # 설치 스크립트
├── nvim/                   # ~/.config/nvim 으로 심링크
│   ├── init.lua
│   ├── KEYMAPS.md          # 키맵 전체 문서
│   └── lua/
│       ├── config/
│       │   ├── options.lua     # 기본 옵션
│       │   └── keymaps.lua     # 키맵
│       └── plugins/
│           ├── ai.lua          # Claude Code (coder/claudecode.nvim)
│           ├── colorscheme.lua # Catppuccin
│           ├── completion.lua  # nvim-cmp + LuaSnip
│           ├── editor.lua      # autopairs, surround, comment, flash, snacks terminal
│           ├── formatting.lua  # conform + nvim-lint
│           ├── git.lua         # lazygit, diffview, gitsigns
│           ├── lsp.lua         # LSP + Mason + trouble.nvim
│           ├── rust.lua        # rustaceanvim + crates.nvim
│           ├── telescope.lua   # 파일/검색
│           ├── treesitter.lua  # 구문 강조
│           └── ui.lua          # lualine, bufferline, noice, which-key
└── README.md
```

## 주요 키맵 (`<Space>` = leader)

| 키 | 동작 |
|---|---|
| `<Space>ff` | 파일 찾기 |
| `<Space>fg` | 텍스트 검색 (grep) |
| `<Space>fb` | 버퍼 전환 |
| `<Space>e` | 파일트리 토글 |
| `<Space>gg` | LazyGit |
| `<C-\>` | 터미널 토글 |
| `<Space>xx` | 에러 목록 |
| `<Space>fm` | 파일 포맷 |
| `s` | Flash 점프 |
| `K` | LSP hover |
| `gd` | 정의로 이동 |
| `<Space>rn` | 심볼 이름 변경 |
| `<Space>?` | 키맵 힌트 (which-key) |
| `<Space>cc` | Claude Code 토글 |
| `<Space>cs` | Claude Code 선택 영역 전송 (visual) |

> 전체 키맵은 [nvim/KEYMAPS.md](nvim/KEYMAPS.md) 참조

### Rust 전용

| 키 | 동작 |
|---|---|
| `K` | Rust hover actions |
| `<Space>rr` | Runnables |
| `<Space>rd` | Debuggables |
| `<Space>rm` | 매크로 확장 |
| `<Space>rc` | Cargo.toml 열기 |

## 설치 후

1. 터미널 폰트를 **JetBrainsMono Nerd Font** 로 설정
2. `nvim` 실행 — Mason이 LSP 서버 자동 설치
3. `:Mason` 으로 설치 현황 확인

## 설정 업데이트

```bash
cd ~/dotfiles && git pull
# 심링크이므로 복사 불필요 — nvim 재시작 후 :Lazy sync
```
