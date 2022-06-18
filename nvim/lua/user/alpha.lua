local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {

  [[                                                     gg                     ]],
  [[                                                     ""                     ]],
  [[  ,ggg,,ggg,    ,ggg,     ,ggggg,       ggg    gg    gg    ,ggg,,ggg,,ggg,  ]],
  [[ ,8" "8P" "8,  i8" "8i   dP"  "Y8ggg   d8"Yb   88bg  88   ,8" "8P" "8P" "8, ]],
  [[ I8   8I   8I  I8, ,8I  i8'    ,8I    dP  I8   8I    88   I8   8I   8I   8I ]],
  [[,dP   8I   Yb, `YbadP' ,d8,   ,d8'  ,dP   I8, ,8I  _,88,_,dP   8I   8I   Yb,]],
  [[8P'   8I   `Y8888P"Y888P"Y8888P"    8"     "Y8P"   8P""Y88P'   8I   8I   `Y8]],

}
dashboard.section.buttons.val = {
  dashboard.button("e", "探", ":NvimTreeToggle <CR>"),
	dashboard.button("n", "新", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "計画", ":Telescope projects <CR>"),
	dashboard.button("r", "歴史", ":Telescope oldfiles <CR>"),
	dashboard.button("c", "構成", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", "やめる", ":qa<CR>"),
}

local function footer()
-- NOTE: requires the fortune-mod package to work
	-- local handle = io.popen("fortune")
	-- local fortune = handle:read("*a")
	-- handle:close()
	-- return fortune
	return vim.cmd('source /home/tim/test_vimscript.vim')
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
