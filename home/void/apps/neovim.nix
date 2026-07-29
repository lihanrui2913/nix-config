{ inputs, pkgs, ... }:

let
  extraGrammars = with pkgs.vimPlugins.nvim-treesitter.grammarPlugins; [
    bash
    cpp
    css
    dockerfile
    gitignore
    html
    javascript
    json
    markdown
    nix
    python
    rust
    toml
    tsx
    typescript
    yaml
  ];

  nvfSettings =
    { lib, ... }:
    {
      vim.lineNumberMode = "number";
      vim.options = {
        cursorline = true;
        cursorlineopt = "both";
        grepprg = "${lib.getExe pkgs.ripgrep} --vimgrep --no-heading";
        redrawtime = 100;
      };

      vim.lsp.enable = true;

      vim.languages = {
        bash = {
          enable = true;
          format = {
            enable = true;
            type = [ "shfmt" ];
          };
          extraDiagnostics = {
            enable = true;
            types = [ "shellcheck" ];
          };
        };
        clang = {
          enable = true;
          format = {
            enable = true;
            type = [ "clang-format" ];
          };
        };
        json.enable = true;
        markdown.enable = true;
        nix = {
          enable = true;
          lsp.servers = [ "nixd" ];
          format = {
            enable = true;
            type = [ "nixfmt" ];
          };
        };
        python = {
          enable = true;
          lsp.servers = [
            "ty"
            "ruff"
          ];
          format = {
            enable = true;
            type = [ "ruff" ];
          };
        };
        rust.enable = true;
        toml = {
          enable = true;
          format = {
            enable = true;
            type = [ "taplo" ];
          };
        };
      };

      vim.git.gitsigns.enable = true;
      vim.mini.ai.enable = true;
      vim.mini.pairs.enable = true;
      vim.mini.surround.enable = true;

      vim.formatter.conform-nvim.setupOpts = {
        format_on_save = lib.mkForce null;
        format_after_save = lib.mkForce null;
      };

      vim.autocomplete.blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
        mappings.confirm = null;
        mappings.next = null;
        setupOpts = {
          keymap = {
            preset = "default";
            "<Tab>" = [
              "accept"
              "fallback"
            ];
            "<CR>" = [ "fallback" ];
          };
          signature.enabled = true;
        };
      };

      vim.statusline.lualine = {
        enable = true;
        setupOpts = lib.mkForce {
          options = {
            globalstatus = true;
            always_show_tabline = false;
          };
          tabline = {
            lualine_a = [
              {
                "@1" = "tabs";
                mode = 2;
                tab_max_length = 24;
              }
            ];
          };
        };
      };

      vim.assistant.copilot.enable = true;
      vim.utility.sleuth.enable = true;
      vim.binds.whichKey.enable = true;
      vim.visuals.nvim-web-devicons.enable = true;

      vim.utility.diffview-nvim = {
        enable = true;
        setupOpts.enhanced_diff_hl = true;
      };

      vim.utility.snacks-nvim = {
        enable = true;
        setupOpts = {
          explorer.enabled = true;
          picker.enabled = true;
          picker.ui_select = true;
          picker.sources.explorer.layout.hidden = [ "input" ];
          scroll.enabled = true;
          indent.enabled = true;
          input.enabled = true;
          notifier.enabled = true;
          terminal.win.position = "right";
          words.enabled = true;
          bigfile.enabled = true;
          quickfile.enabled = true;
          dashboard.sections = [
            { section = "header"; }
            {
              section = "keys";
              gap = 1;
              padding = 1;
            }
          ];
        };
      };

      vim.session.nvim-session-manager = {
        enable = true;
        usePicker = false;
      };

      vim.autocmds = [
        {
          event = [ "User" ];
          pattern = [ "SessionSavePre" ];
          command = "lua for _,v in ipairs(require'diffview.lib'.views) do v:close() end";
          desc = "Close Diffview before saving a session";
        }
        {
          event = [ "User" ];
          pattern = [ "SessionLoadPost" ];
          command = "lua Snacks.explorer()";
          desc = "Open explorer after restoring a session";
        }
      ];

      vim.treesitter = {
        enable = true;
        grammars = extraGrammars;
      };

      vim.extraPlugins.quicker = {
        package = pkgs.vimPlugins.quicker-nvim;
        setup = "require('quicker').setup()";
      };

      vim.lazy.plugins."vscode.nvim" = {
        package = pkgs.vimPlugins.vscode-nvim;
        setupModule = "vscode";
        setupOpts.group_overrides =
          let
            background = "#1a1a1a";
          in
          lib.genAttrs
            [
              "Normal"
              "SignColumn"
            ]
            (_: {
              bg = background;
            })
          // {
            LineNr = {
              bg = background;
              fg = "#5a5a5a";
            };
            LineNrAbove.link = "LineNr";
            LineNrBelow.link = "LineNr";
            CursorLineNr = {
              bg = background;
              fg = "#bbbbbb";
            };
            DiffviewFilePanelTitle = {
              fg = "#ffffff";
              bold = true;
            };
            DiffviewFilePanelInsertions.link = "GitSignsAdd";
            DiffviewFilePanelDeletions.link = "GitSignsDelete";
            DiffviewStatusModified.link = "GitSignsChange";
            DiffviewFolderName.fg = "#ffffff";
            DiffviewFolderSign.fg = "#ffffff";
          };
        after = "vim.cmd.colorscheme('vscode')";
      };

      vim.keymaps = [
        {
          mode = "n";
          key = "<F1>";
          action = "function() Snacks.picker.commands() end";
          lua = true;
          desc = "Commands";
        }
        {
          mode = "n";
          key = "<leader>,";
          action = "function() Snacks.picker.buffers() end";
          lua = true;
          desc = "Buffers";
        }
        {
          mode = "n";
          key = "<leader>/";
          action = "function() Snacks.picker.grep() end";
          lua = true;
          desc = "Grep";
        }
        {
          mode = "n";
          key = "<leader>e";
          action = "function() Snacks.explorer() end";
          lua = true;
          desc = "File Explorer";
        }
        {
          mode = "n";
          key = "<leader>gs";
          action = "<cmd>DiffviewOpen<cr>";
          desc = "Git changes";
        }
        {
          mode = "n";
          key = "<leader>cf";
          action = "function() require(\"conform\").format({ async = true }) end";
          lua = true;
          desc = "Format";
        }
        {
          mode = [
            "n"
            "t"
          ];
          key = "<C-\\>";
          action = "function() Snacks.terminal() end";
          lua = true;
          desc = "Toggle Terminal";
        }
      ];
    };
in
{
  imports = [ inputs.nvf.homeManagerModules.default ];

  programs.nvf = {
    enable = true;
    settings = nvfSettings;
  };
}
