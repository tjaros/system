{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions.file_browser.enable = true;

    keymaps = {
      "<leader>f" = {
        action = "find_files, {}"
	desc = "Find project files"
      };
      "<leader>/" = {
        action = "live_grep";
	desc = "Grep (root dir)"
      }
    };
  };
}
