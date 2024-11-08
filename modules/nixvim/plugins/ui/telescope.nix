{pkgs, ...}: {
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      extensions = {
        file-browser.enable = true;
        fzf-native.enable = true;
      };

      settings.defaults = {
        layout_strategy = "bottom_pane";
        layout_config = {
          height = 0.3;
        };
        sorting_strategy = "ascending";
      };

      keymaps = {
        "<leader>/" = {
          action = "current_buffer_fuzzy_find, {}";
          options.desc = "Buffer fzf.";
        };
        "<leader>:" = {
          action = "command_history, {}";
          options.desc = "Command History";
        };
        "<leader>ff" = {
          action = "find_files";
          options.desc = "Find project files";
        };
        "<leader>fr" = {
          action = "live_grep, {}";
          options.desc = "Find text";
        };
        "<leader>fg" = {
          action = "oldfiles, {}";
          options.desc = "Recent";
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
