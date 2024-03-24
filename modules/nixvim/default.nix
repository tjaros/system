{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.nixvim;

in {
  options.modules.nixvim= { enable = mkEnableOption "nixvim"; };
    config = mkIf cfg.enable {
      programs.nixvim = {
      	enable = true;

	globals.mapleader = " ";

	options = {
	  number = true;
	  shiftwidth = 4;
	};

	colorschemes.gruvbox.enable = true;

        keymaps = [
          {
            action = "<cmd>Telescope live_grep<CR>";
            key = "<leader>g";
          }
        ];

	plugins.lsp = {
	  enable = true;

	  servers = {
	    
	  };
	};

	plugins.luasnip = {
	  enable = true;
	};

	plugins.nvim-cmp = {
	  enable = true;
	  autoEnableSources = true;
          sources = [
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
            {name = "luasnip";}
          ];

          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = {
              action = ''
                function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif luasnip.expandable() then
                    luasnip.expand()
                  elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                  elseif check_backspace() then
                    fallback()
                  else
                    fallback()
                  end
                end
              '';
              modes = [ "i" "s" ];
            };
          };
	};
      };
    };
}
