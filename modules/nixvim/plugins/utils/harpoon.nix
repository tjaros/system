{
  programs.nixvim = {
    plugins.harpoon = {
      enable = true;
      enableTelescope = true;
      keymapsSilent = true;
      keymaps = {
        addFile = "<leader>a";
        toggleQuickMenu = "<C-e>";
        navFile = {
          "1" = "<leader>h";
          "2" = "<leader>t";
          "3" = "<leader>n";
          "4" = "<leader>s";
        };
      };
    };
  };
}
