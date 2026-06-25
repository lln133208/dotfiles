local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- 远程桌面/VDI/虚拟机里系统 OpenGL 太旧,默认 "OpenGL" 后端报
-- "The OpenGL implementation is too old to work with glium" 开不了窗口。
-- 注意: "OpenGL" 和 "Software" 都基于 glium,仍需一个可用的(软件)OpenGL 上下文,
-- 在连软件 GL 都给不出的环境里照样失败。"WebGpu" 完全不走 glium/OpenGL,改用
-- Direct3D(RDP 下可退到 WARP 软件 D3D),才是这类环境的正解。
config.front_end = "WebGpu"

-- 默认起 PowerShell 7(不带 -NoProfile),这样会加载你的 profile:
-- oh-my-posh 主题 + posh-git,prompt 与直连 pwsh 时一致。
config.default_prog = { 'pwsh.exe', '-NoLogo' }

-- 字体:你已装的 JetBrainsMono Nerd Font Mono(含全套 Nerd 字形,等宽变体)。
-- Symbols Nerd Font Mono 仅作兜底,正常用不到。
config.font = wezterm.font_with_fallback({
  'JetBrainsMono Nerd Font Mono',
  'Symbols Nerd Font Mono',
})

-- 本地多路复用域:程序跑在后台的 wezterm-mux-server 里。
-- 关闭 GUI 窗口 = detach,会话(含多开的 claude)继续在后台运行;
-- 重开 WezTerm 会自动 attach 回来。能扛住断开/关窗口,扛不住重启/关机。
config.unix_domains = {
  { name = 'main' },
}

-- GUI 启动时自动连接到 'main' 域,而不是开一个随窗口一起销毁的本地会话。
config.default_gui_startup_args = { 'connect', 'main' }

-- 键位暂用 WezTerm 默认:
--   新标签 Ctrl+Shift+T  新分屏 Ctrl+Shift+Alt+" (上下) / Ctrl+Shift+Alt+% (左右)
--   切分屏 Ctrl+Shift+方向键

return config
