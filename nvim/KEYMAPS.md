# Neovim Keymaps

Leader key: `Space`

## General

| 키 | 모드 | 동작 |
|---|---|---|
| `<leader>w` | n | 저장 |
| `<leader>q` | n | 종료 |
| `<leader>Q` | n | 강제 전체 종료 |
| `<leader>?` | n | 키맵 힌트 (WhichKey) |
| `<Esc>` | n | 검색 하이라이트 제거 |

## Window

| 키 | 모드 | 동작 |
|---|---|---|
| `<C-h>` | n | 왼쪽 창으로 이동 |
| `<C-j>` | n | 아래 창으로 이동 |
| `<C-k>` | n | 위 창으로 이동 |
| `<C-l>` | n | 오른쪽 창으로 이동 |
| `<C-Up>` | n | 창 높이 증가 |
| `<C-Down>` | n | 창 높이 감소 |
| `<C-Left>` | n | 창 너비 감소 |
| `<C-Right>` | n | 창 너비 증가 |
| `<leader>sv` | n | 수직 분할 |
| `<leader>sh` | n | 수평 분할 |
| `<leader>se` | n | 창 크기 균등화 |
| `<leader>sx` | n | 분할 창 닫기 |

## Buffer

| 키 | 모드 | 동작 |
|---|---|---|
| `<S-h>` | n | 이전 버퍼 |
| `<S-l>` | n | 다음 버퍼 |
| `<leader>bd` | n | 버퍼 삭제 |

## Text Editing

| 키 | 모드 | 동작 |
|---|---|---|
| `<A-j>` | n/v | 줄/선택 아래로 이동 |
| `<A-k>` | n/v | 줄/선택 위로 이동 |
| `>` | v | 들여쓰기 (선택 유지) |
| `<` | v | 내어쓰기 (선택 유지) |
| `p` | v | 레지스터 보존 붙여넣기 |

## File Explorer (Neo-tree)

| 키 | 모드 | 동작 |
|---|---|---|
| `<leader>e` | n | 파일 탐색기 토글 |
| `<leader>o` | n | 파일 탐색기 포커스 |

## Search (Telescope)

| 키 | 모드 | 동작 |
|---|---|---|
| `<leader>ff` | n | 파일 찾기 |
| `<leader>fg` | n | 전체 텍스트 검색 (grep) |
| `<leader>fb` | n | 버퍼 목록 |
| `<leader>fh` | n | 도움말 태그 |
| `<leader>fr` | n | 최근 파일 |
| `<leader>fc` | n | 색상 테마 선택 |
| `<leader>ft` | n | TODO 목록 |

**Telescope 내부 (insert 모드)**

| 키 | 동작 |
|---|---|
| `<C-j>` | 다음 항목 |
| `<C-k>` | 이전 항목 |
| `<C-q>` | 선택 항목을 quickfix로 전송 |

## Navigation (Flash)

| 키 | 모드 | 동작 |
|---|---|---|
| `s` | n/x/o | Flash 점프 |
| `S` | n/x/o | Flash treesitter 점프 |

## LSP (LSP 연결 버퍼에서만 활성)

| 키 | 모드 | 동작 |
|---|---|---|
| `K` | n | Hover 문서 |
| `gd` | n | 정의로 이동 |
| `gD` | n | 선언으로 이동 |
| `gi` | n | 구현으로 이동 |
| `gr` | n | 참조 목록 |
| `<leader>rn` | n | 심볼 이름 변경 |
| `<leader>f` | n | 버퍼 포맷 (LSP) |
| `<leader>ca` | n | Code action (버퍼 로컬, Claude Code diff accept보다 우선) |

## Diagnostics

| 키 | 모드 | 동작 |
|---|---|---|
| `<leader>d` | n | Diagnostics float |
| `[d` | n | 이전 diagnostic |
| `]d` | n | 다음 diagnostic |
| `<leader>xx` | n | Trouble: 전체 diagnostics |
| `<leader>xX` | n | Trouble: 현재 버퍼 diagnostics |
| `<leader>cs` | n | Trouble: 심볼 목록 |
| `<leader>cl` | n | Trouble: LSP references |

## Git

| 키 | 모드 | 동작 |
|---|---|---|
| `]h` | n | 다음 hunk |
| `[h` | n | 이전 hunk |
| `<leader>gs` | n | Hunk 스테이징 |
| `<leader>gr` | n | Hunk 되돌리기 |
| `<leader>gp` | n | Hunk 미리보기 |
| `<leader>gb` | n | 현재 줄 blame |
| `<leader>gh` | n | 파일 히스토리 (Diffview) |
| `<leader>gg` | n | LazyGit |
| `<leader>gd` | n | Diffview 열기 |
| `<leader>gD` | n | Diffview 닫기 |

## Terminal (snacks.nvim)

| 키 | 모드 | 동작 |
|---|---|---|
| `<leader>t` | n | 터미널 토글 |
| `<C-\>` | n | 터미널 토글 |
| `<Esc>` | t | 터미널 모드 종료 |

## Claude Code (coder/claudecode.nvim)

| 키 | 모드 | 동작 |
|---|---|---|
| `<leader>cc` | n | 터미널 토글 |
| `<leader>cf` | n | 터미널 포커스 |
| `<leader>cm` | n | 모델 선택 |
| `<leader>cb` | n | 현재 버퍼 컨텍스트 추가 |
| `<leader>cs` | v | 선택 영역 전송 |
| `<leader>ca` | n | Diff 변경사항 수락 (LSP 없는 버퍼에서만 동작) |
| `<leader>cd` | n | Diff 변경사항 거부 |

## Formatting

| 키 | 모드 | 동작 |
|---|---|---|
| `<leader>fm` | n | 파일 포맷 (conform) |

> 저장 시 자동 포맷 활성화

## Rust (rust 파일에서만 활성)

| 키 | 모드 | 동작 |
|---|---|---|
| `K` | n | Rust hover actions (LSP K 대체) |
| `<leader>rr` | n | Runnables |
| `<leader>rd` | n | Debuggables |
| `<leader>rm` | n | 매크로 확장 |
| `<leader>rc` | n | Cargo.toml 열기 |
| `<leader>rp` | n | 상위 모듈 이동 |

## Search & Replace

| 키 | 모드 | 동작 |
|---|---|---|
| `<leader>S` | n | Spectre 검색/교체 패널 |

---

## 키 충돌

| 키 | 등록 A | 등록 B | 결과 |
|---|---|---|---|
| `<leader>ca` | LSP code action (버퍼 로컬) | Claude Code diff accept (전역) | LSP 연결 버퍼에서는 LSP 우선 |
| `<leader>gh` | Gitsigns preview_hunk (keymaps.lua) | Diffview file history (git.lua) | 나중 등록이 덮어씀 |
