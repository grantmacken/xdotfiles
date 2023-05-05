local ok, tree = pcall(require, "neo-tree")
if not ok then
  return
end

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

tree.setup({
  default_source = "filesystem",
  sources = {
    "filesystem",
    "buffers",
    "git_status",
    "diagnostics",
    -- ...and any additional source
  },
  close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    -- popup_border_style is for input and confirmation dialogs.
    -- Configurtaion of floating window is done in the individual source sections.
    -- "NC" is a special style that works well with NormalNC set
  popup_border_style = "NC", -- "double", "none", "rounded", "shadow", "single" or "solid"
  use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
  close_floats_on_escape_key = true,
  enable_git_status = true,
  enable_diagnostics = true,
  open_files_in_last_window = true, -- false = open files in top left window
  log_level = "info", -- "trace", "debug", "info", "warn", "error", "fatal"
  log_to_file = false, -- true, false, "/path/to/file.log", use :NeoTreeLogs to show the file
    --
    --event_handlers = {
      --  {
        --    event = "before_render",
        --    handler = function (state)
          --      -- add something to the state that can be used by custom components
          --    end
          --  },
      --  {
        --    event = "file_opened",
        --    handler = function(file_path)
          --      --auto close
          --      require("neo-tree").close_all()
          --    end
          --  },
      --  {
        --    event = "file_opened",
        --    handler = function(file_path)
          --      --clear search after opening a file
          --      require("neo-tree.sources.filesystem").reset_search()
          --    end
          --  },
      --  {
        --    event = "file_renamed",
        --    handler = function(args)
          --      -- fix references to file
          --      print(args.source, " renamed to ", args.destination)
          --    end
          --  },
      --  {
        --    event = "file_moved",
        --    handler = function(args)
          --      -- fix references to file
          --      print(args.source, " moved to ", args.destination)
          --    end
          --  },
      --},
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 1,
      with_markers = false,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      default = "*",
      folder_empty = "ﰊ",
      highlight = "NeoTreeFileIcon"
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
    },
    git_status = {
      symbols = {
        -- Change type
        --added     = "✚",
       deleted   = "✖",
       -- modified  = "",
       renamed   = "",
        -- Status type
          untracked = "",
        ignored   = "",
        unstaged  = "",
        staged    = "",
        conflict  = "",
      }
    },
  },
  window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
    -- possible options. These can also be functions that return these options.
      position = "left", -- left, right, float, current
      width = 40, -- applies to left and right positions
      popup = { -- settings that apply to float position only
        size = {
          height = "80%",
          width = "50%",
        },
        position = "50%", -- 50% means center it
          -- you can also specify border here, if you want a different setting from
          -- the global popup_border_style.
      },
    -- Mappings for tree window. See `:h nep-tree-mappings` for a list of built-in commands.
      -- You can also create your own commands by providing a function instead of a string.
      mappings = {
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["C"] = "close_node",
        ["z"] = "close_all_nodes",
        --["<bs>"] = "navigate_up",
        -- ["."] = "set_root",
        ["R"] = "refresh",
        ["a"] = "add",
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy", -- takes text input for destination
        ["m"] = "move", -- takes text input for destination
        ["q"] = "close_window",
      },
  },
  renderers = {
    directory = {
      { "indent" },
      { "icon" },
      { "current_filter" },
      { "name" },
      -- {
        --   "symlink_target",
        --   highlight = "NeoTreeSymbolicLinkTarget",
        -- },
      { "clipboard" },
      { "diagnostics", errors_only = true },
      --{ "git_status" },
    },
    file = {
      { "indent" },
      { "icon" },
      {
        "name",
        use_git_status_colors = true,
      },
      -- {
        --   "symlink_target",
        --   highlight = "NeoTreeSymbolicLinkTarget",
        -- },
      { "bufnr" },
      { "clipboard" },
      { "diagnostics" },
      { "git_status" },
    },
  },
  filesystem = {
    window = {
      mappings = {
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        --["/"] = "filter_as_you_type", -- this was the default until v1.28
        ["f"] = "filter_on_submit",
        ["<C-x>"] = "clear_filter",
      },
      popup = {
        position = { col = "100%", row = "2" },
        size = function(state)
          local root_name = vim.fn.fnamemodify(state.path, ":~")
          local root_len = string.len(root_name) + 4
          return {
            width = math.max(root_len, 50),
            height = vim.o.lines - 6
          }
        end
      },
    },
    bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
    -- The renderer section provides the renderers that will be used to render the tree.
    --   The first level is the node type.
    --   For each node type, you can specify a list of components to render.
    --  Components are rendered in the order they are specified.
    --  The first field in each component is the name of the function to call.
    components = {
      harpoon_index = function(config, node)
        local Marked = require("harpoon.mark")
        local path = node:get_id()
        local success, index = pcall(Marked.get_index_of, path)
        if success and index and index > 0 then
          return {
            text = string.format(" ⥤ %d", index), -- <-- Add your favorite harpoon like arrow here
            highlight = config.highlight or "NeoTreeDirectoryIcon",
          }
        else
          return {}
        end
      end
    },
    renderers = {
      file = {
      {"icon"},
      {"name", use_git_status_colors = true},
      {"harpoon_index"}, --> This is what actually adds the component in where you want it
      {"diagnostics"},
      {"git_status", highlight = "NeoTreeDimText"},
      }
    },
      -- The rest of the fields are passed to the function as the "config" argument.
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          "node_modules",
        },
        never_show = { -- remains hidden even if visible is toggled to true
          --".DS_Store",
          --"thumbs.db"
        },
        gitignore_source = "git check-ignored", -- or "git status", which may be faster in some repos
      },
    find_by_full_path_words = false,  -- `false` means it only searches the tail of a path.
      -- `true` will change the filter into a full path
      -- search with space as an implicit ".*", so
      -- `fi init`
      -- will match: `./sources/filesystem/init.lua
      find_command = "fd", -- this is determined automatically, you probably don't need to set it
      find_args = {  -- you can specify extra args to pass to the find command.
          fd = {
          "--hidden",
          "--exclude", ".git",
           "--exclude",  "node_modules"
            }
        },
      search_limit = 50, -- max number of search results when using filters
      follow_current_file = false, -- This will find and focus the file in the active buffer every time
      -- the current file is changed while the tree is open.
      hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
      -- in whatever position is specified in window.position
      -- "open_current",-- netrw disabled, opening a directory opens within the
      -- window like netrw would, regardless of window.position
      -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
      use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
      -- instead of relying on nvim autocmd events.
  },
  buffers = {
    bind_to_cwd = true,
    window = {
      mappings = {
        ["bd"] = "buffer_delete",
      },
    },
  },
  git_status = {
    symbols = {
      -- Change type
      added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
      modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
      deleted   = "✖",-- this can only be used in the git_status source
      renamed   = "",-- this can only be used in the git_status source
      -- Status type
      untracked = "",
      ignored   = "",
      unstaged  = "",
      staged    = "",
      conflict  = "",
    },
      window = {
      mappings = {
        ["A"] = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
      },
    },
  },
  diagnostics = {
   window = {
      popup = {
        position = { col = "100%", row = "2" },
        size = function(state)
          local root_name = vim.fn.fnamemodify(state.path, ":~")
          local root_len = string.len(root_name) + 4
          return {
            width = math.max(root_len, 50),
            height = vim.o.lines - 6
          }
        end
      },
    },
    bind_to_cwd = true,
    diag_sort_function = "severity", -- "severity" means diagnostic items are sorted by severity in addition to their positions.
                                     -- "position" means diagnostic items are sorted strictly by their positions.
                                     -- May also be a function.
    follow_behavior = { -- Behavior when `follow_current_file` is true
      always_focus_file = false, -- Focus the followed file, even when focus is currently on a diagnostic item belonging to that file.
      expand_followed = true, -- Ensure the node of the followed file is expanded
      collapse_others = true, -- Ensure other nodes are collapsed
    },
    follow_current_file = true,
    group_dirs_and_files = true, -- when true, empty folders and files will be grouped together
    group_empty_dirs = true, -- when true, empty directories will be grouped together
    show_unloaded = true, -- show diagnostics from unloaded buffers
  },



})




