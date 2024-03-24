{

  programs.nixvim = {
    globals.mapleader = " ";

    keymaps = [
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>g";
      }
    ];
  };
}
