{ config, lib, pkgs, ... }:

let
  cfg = config.modules.nvim;
in
{
  options.modules.nvim = {
    enable = lib.mkEnableOption "neovim with LazyVim";

    colorscheme = lib.mkOption {
      type = lib.types.str;
      default = "fahrenheit";
      description = "Default colorscheme for Neovim";
    };

    copilot = {
      enable = lib.mkEnableOption "GitHub Copilot in Neovim";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        gcc
        gnumake
        ripgrep
        fd
        lazygit
        lua-language-server
        nil
        nixd
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted
        pyright
        taplo
        stylua
        nixfmt-rfc-style
        prettierd
        shfmt
      ];
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    xdg.configFile = {
      "nvim/init.lua" = { source = ./init.lua; force = true; };
      "nvim/lua/config/options.lua" = { source = ./lua/config/options.lua; force = true; };
      "nvim/lua/config/keymaps.lua" = { source = ./lua/config/keymaps.lua; force = true; };
      "nvim/lua/config/autocmds.lua" = { source = ./lua/config/autocmds.lua; force = true; };
      "nvim/lua/config/lazy.lua" = {
        text = ''
          require("lazy").setup({
            {
              "LazyVim/LazyVim",
              import = "lazyvim.plugins",
              opts = { colorscheme = "${cfg.colorscheme}" },
            },
            { import = "plugins" },
          }, {
            defaults = { lazy = true },
            install = { colorscheme = { "${cfg.colorscheme}" } },
            checker = { enabled = true, notify = false },
            change_detection = { notify = false },
          })
        '';
        force = true;
      };
    };

    xdg.configFile."nvim/colors/fahrenheit.lua" = { source = ./colors/fahrenheit.lua; force = true; };
    xdg.configFile."nvim/lua/fahrenheit.lua" = { source = ./lua/fahrenheit.lua; force = true; };
    xdg.configFile."nvim/lua/plugins/fahrenheit.lua" = { source = ./lua/plugins/fahrenheit.lua; force = true; };
    xdg.configFile."nvim/lua/plugins/snacks.lua" = { source = ./lua/plugins/snacks.lua; force = true; };

    xdg.configFile."nvim/lua/plugins/copilot.lua" = lib.mkIf cfg.copilot.enable {
      text = ''
        return { "github/copilot.vim", lazy = false }
      '';
      force = true;
    };
  };
}
