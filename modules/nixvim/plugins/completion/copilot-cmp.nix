{
  programs.nixvim = {
    plugins.copilot-cmp = {
      enable = true;
    };
    plugins.copilot-lua.enable = false;

    extraConfigLua = ''
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    '';
  };
}
