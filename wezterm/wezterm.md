# dotfiles

用 [chezmoi](https://www.chezmoi.io/) 管理的配置文件，源文件在 `home-chezmoi/`。

## WezTerm 自定义快捷键

配置文件：`home-chezmoi/dot_wezterm.lua.tmpl`

**Leader 键：`Ctrl` + `` ` ``**（`` ` `` 在 Esc 正下方）。按下后松开，1 秒内再按下一个键。
例如 `LEADER` `s` = 按 `Ctrl` + `` ` `` → 松开 → 按 `s`。

### 窗格

| 快捷键 | 作用 |
|---|---|
| `Ctrl` + `Alt` + `-` | 上下拆分（`-` 像一条横线） |
| `Ctrl` + `Alt` + `\` | 左右拆分（`\` 像一条竖线） |
| `Ctrl` + `Alt` + `k` | 关闭当前窗格（会先确认） |
| `LEADER` `p` | 选一个窗格，给它发一行文字 |

### Workspace

workspace 相当于 WezTerm 里的「多个桌面」：每个 workspace 有自己的一组标签页，切换时整组一起换。

| 快捷键 | 作用 |
|---|---|
| `LEADER` `s` | 按 zoxide 记录的目录切换或新建 workspace |
| `Alt` + `q` | 列出所有 workspace，选一个切过去 |
| `Ctrl` + `Alt` + `n` | 新建 workspace（输入名字） |
| `Ctrl` + `Shift` + `E` | 重命名当前 workspace |
| `Ctrl` + `Shift` + `Y` | 回到 `default` workspace |
| `LEADER` `k` | 关闭当前 workspace 的所有窗格 |

### 远程连接（quick_domains 插件）

| 快捷键 | 作用 |
|---|---|
| `LEADER` `a` | 选择 ssh 主机或 docker 容器，在新标签页里连过去 |
| `LEADER` `-` | 上下拆分，在新窗格里连过去 |
| `LEADER` `\` | 左右拆分，在新窗格里连过去 |

### 其他

| 快捷键 | 作用 |
|---|---|
| `F11` | 全屏。macOS 默认把 F11 当作「显示桌面」，会被系统拦截，可以改用 WezTerm 自带的 `Option` + `Enter` |

### 忘了快捷键时

- `Ctrl` + `Shift` + `P`：打开命令面板，输入关键词（如 `split`、`workspace`）搜索功能，右边会显示对应的快捷键
- `wezterm show-keys`：在终端里列出当前生效的所有快捷键（包括 WezTerm 默认的）
