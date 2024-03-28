{
  programs.nixvim = {
    globals.mapleader = " ";
    keymaps = [
       {
          mode = "n";
	  key = "<leader>fv";
	  action = "<cmd>:Ex<cr>";
	  options = {desc = "Open netrw";};
       }
    ];
  };
}
