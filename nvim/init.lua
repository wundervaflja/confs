local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then impatient.enable_profile() end

for _, source in ipairs {
  "core.utils",
  "core.options",
  "core.bootstrap",
  "core.diagnostics",
  "core.autocmds",
  "core.mappings",
  "configs.which-key-register",
} do
  local status_ok, fault = pcall(require, source)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault) end
end

astronvim.conditional_func(astronvim.user_plugin_opts("polish", nil, false))

if vim.fn.has "nvim-0.8" ~= 1 or vim.version().prerelease then
  vim.schedule(function() astronvim.notify("Unsupported Neovim Version! Please check the requirements", "error") end)
end

require('orgmode').setup_ts_grammar()

require('orgmode').setup({
  org_agenda_files = { '~/repo/kb/org/*' },
  org_default_notes_file = '~/repo/org/todo.org',
  org_todo_keywords = {'TODO(t)', 'WAITING(w)', '|', 'DELEGATED(d)', 'DONE(x)'},
  org_todo_keyword_faces = {
    WAITING = ':foreground blue :weight bold',
    DELEGATED = ':foreground pink :slant italic :underline on',
    TODO = ':foreground red', -- overrides builtin color for `TODO` keyword
  },
  org_hide_leading_stars = true,
  org_agenda_start_day = '-2d',
  org_capture_templates = { 
    t = {
      description = 'Todo',
      template = '* TODO %U %?\n %a',
      target = '~/org/todo.org'
    },
    j = {
      description = 'Journal',
      template = '* %U\n %?\n',
      target = '~/org/notes.org'
    },
    n = {
      description = 'Notes',
      template = '* %U %?\n %a',
      target = '~/org/notes.org'
    }
  },
  org_agenda_span = 10,
  win_split_mode = 'tabnew',
})
