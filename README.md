# dotfiles

개인 개발 환경 설정 (Neovim + 플러그인)

## 지원 환경

| OS | 방법 |
|---|---|
| macOS | Homebrew |
| Ubuntu / Debian | apt + GitHub Releases |
| Fedora / RHEL | dnf |
| Arch / Manjaro | pacman |

## 설치

```bash
git clone https://github.com/<your-username>/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash install.sh
```

원라인 설치:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/<your-username>/dotfiles/main/install.sh)
```

> 단, 원라인은 `~/dotfiles` 디렉토리가 없을 때만 권장합니다.

## 구조

```
dotfiles/
├── install.sh          # 설치 스크립트 (macOS / Ubuntu / Fedora / Arch)
├── nvim/               # Neovim 설정 (~/.config/nvim 으로 심링크)
│   ├── init.lua
│   └── lua/
│       ├── config/
│       │   ├── options.lua     # 기본 옵션
│       │   └── keymaps.lua     # 키맵
│       └── plugins/
│           ├── colorscheme.lua # Catppuccin
│           ├── ui.lua          # lualine, bufferline, noice, which-key
│           ├── telescope.lua   # 파일/검색
│           ├── treesitter.lua  # 구문 강조
│           ├── lsp.lua         # LSP + Mason
│           ├── completion.lua  # nvim-cmp + LuaSnip
│           ├── editor.lua      # 편집 편의 플러그인들
│           ├── formatting.lua  # conform + nvim-lint
│           └── git.lua         # lazygit, diffview
└── README.md
```

## 주요 키맵 (`<Space>` = leader)

| 키 | 동작 |
|---|---|
| `<Space>ff` | 파일 찾기 |
| `<Space>fg` | 텍스트 검색 |
| `<Space>fb` | 버퍼 전환 |
| `<Space>e` | 파일트리 토글 |
| `<Space>gg` | LazyGit |
| `<C-\>` | 터미널 토글 |
| `<Space>xx` | 에러 목록 |
| `s` | Flash 점프 |
| `K` | LSP 도움말 |
| `gd` | 정의로 이동 |
| `<Space>ca` | Code action |
| `<Space>rn` | 심볼 이름 변경 |
| `<Space>fm` | 파일 포맷 |
| `<Space>?` | 키맵 힌트 (which-key) |

## 설치 후

터미널 폰트를 **JetBrainsMono Nerd Font** 로 설정하세요.  
`nvim` 실행 후 `:Mason` 으로 LSP 서버 설치 현황을 확인할 수 있습니다.

## 설정 업데이트

```bash
cd ~/dotfiles
git pull
# 심링크이므로 별도 복사 불필요 — nvim 재시작 후 :Lazy sync 실행
```
