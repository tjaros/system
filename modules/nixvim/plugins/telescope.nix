{pkgs, ...}: {
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      extensions = {
        file_browser.enable = true;
        fzf-native.enable = true;
      };

      defaults = {
        layout_strategy = "bottom_pane";
        layout_config = {
          height = 0.3;
        };
        sorting_strategy = "ascending";
      };

      keymaps = {
        "<leader>/" = {
          action = "current_buffer_fuzzy_find, {}";
          desc = "Buffer fzf.";
        };
        "<leader>:" = {
          action = "command_history, {}";
          desc = "Command History";
        };
        "<leader>ff" = {
          action = "find_files, {}";
          desc = "Find project files";
        };
        "<leader>fr" = {
          action = "live_grep, {}";
          desc = "Find text";
        };
        "<leader>fg" = {
          action = "oldfiles, {}";
          desc = "Recent";
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      telescope-zoxide
    ];

    extraConfigLua = ''
      require("telescope").load_extension("zoxide")
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>fz";
        action = "<cmd>Telescope zoxide list<CR>";
        options = {
          desc = "LazyGit (root dir)";
        };
      }
    ];
  };
}
