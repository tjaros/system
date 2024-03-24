{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      file_browser.enable = true;
      fzf-native.enable = true;
    };

    defaults = {
      layout_config = {
        horizontal = {
	  prompt_position = "top";
	};
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
}
