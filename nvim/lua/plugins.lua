return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    --- Optimization ---
    use 'lewis6991/impatient.nvim' -- Cache plugin files
    use 'antoinemadec/FixCursorHold.nvim'

    -- Themes --
    -- use 'ful1e5/onedark.nvim'
    -- use 'Shatur/neovim-ayu'
    -- use 'NTBBloodbath/doom-one.nvim'
    -- use 'rmehri01/onenord.nvim'
    -- use 'tiagovla/tokyodark.nvim'
    -- use 'folke/tokyonight.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }

    --- UI ---
    use {
        -- Status line
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function() require("custom.lualine") end
    }

    use {
        -- Starting screen
        'goolord/alpha-nvim',
        config = function () require("custom.alpha") end
    }

    use {
        -- Code diagnostics window
        "folke/trouble.nvim",
        requires = 'kyazdani42/nvim-web-devicons',
        cmd = "Trouble",
        config = function()
            require("trouble").setup { use_diagnostic_signs = true }
        end
    }

    use {
        -- Highlight todo comments
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function() require("custom.todocomments") end
    }

    use {
        -- Smooth scrolling
        'karb94/neoscroll.nvim',
        config = function () require("custom.neoscroll") end
    }

    use {
        -- Scrollbar
        'petertriho/nvim-scrollbar',
        config = function ()
            require("scrollbar").setup {
                handle = { highlight = "CursorLine" },
            }
        end
    }

    use {
        -- Nested mappings with mappings cheatsheet
        "folke/which-key.nvim",
        config = function() require("custom.which-key") end
    }

    use 'famiu/bufdelete.nvim' -- Remove buffers without closing windows
    use {
        -- Tabs
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function () require("custom.bufferline") end
    }

    use {
        -- Markdown preview
        "ellisonleao/glow.nvim",
        cmd = "Glow",
        config = function ()
            vim.g.glow_style = "~/Library/Preferences/glow/catppuccin.json"
            vim.g.glow_border = "rounded"
        end
    }

    --- File finders and managers ---
    use {
        -- Native finder for telescope
        'nvim-telescope/telescope-fzf-native.nvim',
        cmd = "Telescope",
        run = 'make'
    }

    use {
        -- File browser in telescope
        "nvim-telescope/telescope-file-browser.nvim",
        after = "telescope-fzf-native.nvim"
    }

    use {
        -- Fuzzy finder
        'nvim-telescope/telescope.nvim',
        after = "telescope-file-browser.nvim",
        requires = 'nvim-lua/plenary.nvim',
        config = function () require("custom.telescope") end
    }

    use {
        -- File tree
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        cmd = {
            'NvimTreeClipboard',
            'NvimTreeClose',
            'NvimTreeFindFile',
            'NvimTreeOpen',
            'NvimTreeRefresh',
            'NvimTreeToggle',
            'NvimTreeFocus',
        },
        config = function() require("custom.nvtree") end
    }

    --- Git ---
    use {
        -- Git integration
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('gitsigns').setup() end
    }

    use {
        -- Cycle through modified files
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim',
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
            "DiffviewRefresh"
        },
        config = function ()
            require("diffview").setup {
                icons = {
                    folder_closed = "",
                    folder_open = "",
                },
                signs = {
                    fold_closed = "",
                    fold_open = "",
                },
                file_panel = { width = 30 }
            }
        end
    }

    --- Editor ---
    use {
        -- Surround word with quotes or parentheses
        "blackCauldron7/surround.nvim",
        event = 'BufEnter',
        config = function() require"surround".setup { mappings_style = "surround" } end
    }

    use {
        -- Jump out of quotes and parentheses
        'abecodes/tabout.nvim',
        config = function()
            require('tabout').setup {
                tabouts = {
                    {open = "'", close = "'"},
                    {open = '"', close = '"'},
                    {open = '`', close = '`'},
                    {open = '(', close = ')'},
                    {open = '[', close = ']'},
                    {open = '{', close = '}'},
                    {open = '<', close = '>'},
                },
            }
        end,
        wants = 'nvim-treesitter', -- or require if not used so far
        after = 'nvim-cmp' -- if a completion plugin is using tabs load it before
    }

    use {
        -- Comment lines
        'numToStr/Comment.nvim',
        keys = { {"n", "gc"}, {"v", "gc"} },
        config = function() require('Comment').setup() end
    }

    use {
        -- Autocomplete quotes and parentheses
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function () require('nvim-autopairs').setup() end
    }

    use {
        -- Alignment by character
        "tommcdo/vim-lion",
        keys = {
            {"n", "gl"},
            {"v", "gl"},
        },
    }

    use "tpope/vim-repeat" -- Repeat more commands with dot

    --- Treesitter ---
    use {
        -- Syntax highlighting
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function () require("custom.treesitter") end
    }

    use 'nvim-treesitter/nvim-treesitter-textobjects'

    use {
        -- Indentation lines
        'lukas-reineke/indent-blankline.nvim' ,
        event = 'BufEnter',
        config = function ()
            require("indent_blankline").setup {
                show_current_context = true,
                show_current_context_start = false,
                filetype_exclude = {
                    "packer",
                    "NvimTree",
                    "Trouble",
                    "alpha",
                    "toggleterm",
                    "terminal",
                    "help"
                }
            }
        end
    }

    --- LSP ---
    use 'ray-x/lsp_signature.nvim' -- Function arguments floating window

    use {
        'neovim/nvim-lspconfig',
        after = "lsp_signature.nvim",
        config = function () require("custom.lsp") end
    }

    use {
        -- Code checking utilities integration
        "jose-elias-alvarez/null-ls.nvim",
        requires = 'nvim-lua/plenary.nvim',
        config = function ()
            require("custom.nullls")
        end
    }

    use {
        -- Show bulb icon when code action is available
        'kosayoda/nvim-lightbulb',
        after = "nvim-lspconfig",
        config = function ()
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                pattern = "*",
                callback = require('nvim-lightbulb').update_lightbulb,
            })
            require("nvim-lightbulb").setup {
                sign = { enabled = false, },
                virtual_text = { enabled = true, text = "", hl_mode = "replace", }
            }
        end
    }

    use {
        -- LSP loading status
        'j-hui/fidget.nvim',
        after = "nvim-lspconfig",
        config = function ()
            require("fidget").setup {
                text = {
                    spinner = "dots",
                    done = "",
                },
                timer = {
                    spinner_rate = 80,
                }
            }
            vim.cmd [[ hi link FidgetTitle Bold ]]
        end
    }

    --- Completion and snippets ---
    use { 'hrsh7th/cmp-nvim-lsp',}
    use { 'hrsh7th/cmp-buffer', event = { "InsertEnter", "CmdLineEnter" } }
    use { 'hrsh7th/cmp-path', after = "cmp-buffer" }
    use { 'hrsh7th/cmp-cmdline', after = "cmp-path" }
    use { 'onsails/lspkind-nvim', after = "cmp-cmdline" }
    use { 'saadparwaiz1/cmp_luasnip',after = "lspkind-nvim" } -- Completion symbols
    use { 'L3MON4D3/LuaSnip', after = "cmp_luasnip" }
    use { 'rafamadriz/friendly-snippets', after = "LuaSnip" } -- Collection of snippets
    use {
        'hrsh7th/nvim-cmp',
        after = "friendly-snippets",
        config = function() require("custom.cmp") end
    }

    --- Terminal ---
    use {
        "akinsho/toggleterm.nvim",
        cmd = { "ToggleTerm", "ToggleTermToggleAll" },
        config = function () require("custom.toggleterm") end
    }

    --- Debugging and running ---
    use {
        'mfussenegger/nvim-dap',
        config = function () require("custom.dap") end
    }

    use {
        -- Python DAP configurations
        'mfussenegger/nvim-dap-python',
        after = 'nvim-dap',
        ft = 'python',
        config = function ()
            require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
        end
    }

    use "rcarriga/nvim-dap-ui" -- VSCode-like DAP UI

    use {
        -- Build and run tasks
        'pianocomposer321/yabs.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        branch = 'hotfix',
        cmd = { "YabsTask", "YabsDefaultTask" },
        config = function () require("custom.yabs") end
    }

    --- Project and session management ---
    use {
        -- Project managment
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".projectile" },
                detection_methods = { "pattern" },
                silent_chdir = true,
            }
        end
    }

    use {
        -- Session management
        "folke/persistence.nvim",
        event = "BufReadPre",
        module = "persistence",
        config = function() require("persistence").setup() end,
    }
end)
