{
  pkgs,
  lib,
  ...
}: let
  copilotChatRepo = {
    owner = "copilotc-nvim";
    repo = "CopilotChat.nvim";
    rev = "51ec2b45fed9cb0c8551c94ee2f2fb68de1e970a";
    hash = "sha256-Nuy5OzzxuW81+exUhbkW1g4kEvBtJB2xolrThOoPl9k=";
  };
in {
  programs.nixvim = {
    extraPlugins = with pkgs.vimUtils; [
      (buildVimPlugin {
        pname = "copilotchat";
        version = "2.4.0";
        src = pkgs.fetchFromGitHub copilotChatRepo;
        meta = {
          description = "Chat with GitHub Copilot in Neovim";
          homepage = "https://github.com/CopilotC-Nvim/CopilotChat.nvim/";
          license = lib.licenses.gpl3;
        };
      })
    ];
    extraConfigLua = ''
      require("CopilotChat").setup { }
    '';

    keymaps = [
      {
        mode = "x";
        key = "<leader>'";
        action = "+copilot";
      }
      {
        mode = "x";
        key = "<leader>'e";
        action = "<cmd>CopilotChatExplain<cr>";
      }
      {
        mode = "x";
        key = "<leader>'f";
        action = "<cmd>CopilotChatFix<cr>";
      }
      {
        mode = "x";
        key = "<leader>'d";
        action = "<cmd>CopilotChatDocs<cr>";
      }
      {
        mode = "x";
        key = "<leader>'c";
        action = "<cmd>CopilotChatCommit<cr>";
      }
    ];
  };
}
