{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = false;
      settings = {
      	format_on_save = {
          lspFallback = false;
          timeoutMs = 500;
      	};
        notify_on_error = true;
        formatters_by_ft = {
          liquidsoap = ["liquidsoap-prettier"];
          html = [["prettierd" "prettier"]];
          css = [["prettierd" "prettier"]];
          javascript = [["prettierd" "prettier"]];
          javascriptreact = [["prettierd" "prettier"]];
          typescript = [["prettierd" "prettier"]];
          typescriptreact = [["prettierd" "prettier"]];
          python = ["black"];
          lua = ["stylua"];
          nix = ["alejandra"];
          markdown = [["prettierd" "prettier"]];
          yaml = ["yamllint" "yamlfmt"];
	};
      };
    };
  };
}
