{
  programs.nixvim = {
    plugins.nvim-cmp = {
      enable = true;
      autoEnableSources = true;
    };

    plugins.cmp-buffer.enable = true;
  };
}
