{
  programs.nixvim = {
    plugins.nvim-cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        performance = {
	  debounce = 60;
	  fetchingTimeout = 200;
	  maxViewEntries = 30;
	};
	sources = [
          {name = "nvim_lsp";}
	  {
	    name = "buffer";
	    option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
	    keywordLength = 3;
	  }
	  {
	    name = "path";
	    keywordLength = 3;
	  }
	];
      };
    };

    plugins.cmp-nvim-lsp.enable = true;
    plugins.cmp-buffer.enable = true;
    plugins.cmp-path.enable = true;
    plugins.cmp-cmdline.enable = true;
  };
}
