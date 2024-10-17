{
  programs.nixvim = {
    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings =  {
      performance = {
        debounce = 60;
        fetchingTimeout = 200;
        maxViewEntries = 30;
      };
      #snippet = {expand = "luasnip";};
      sources = [
        {name = "nvim_lsp";}
        {
          name = "buffer";
          option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          keywordLength = 3;
        }
        {name = "copilot";}
        {
          name = "path";
          keywordLength = 3;
        }
        {
          name = "luasnip";
          keywordLength = 3;
        }
      ];

      mapping = {
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.close()";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
      };
      };
    };

    plugins.cmp-nvim-lsp.enable = true;
    plugins.cmp-buffer.enable = true;
    plugins.cmp-path.enable = true;
    plugins.cmp-cmdline.enable = true;
    plugins.cmp_luasnip.enable = true;

    extraConfigLua = ''
      luasnip = require("luasnip")
    '';
  };
}
