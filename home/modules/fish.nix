{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    package = pkgs.fish;

    interactiveShellInit = ''
      set fish_greeting
      set -x EDITOR nvim
      set -x VISUAL nvim
      set -x PAGER less
      set -x MANPAGER "less -R"
      set -x BAT_THEME "Fahrenheit"
      set -x BROWSER "brave"

      # ── FZF ──
      set -x FZF_DEFAULT_OPTS "--layout=reverse --height=60% --border --inline-info"
      set -x FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
      set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
      set -x FZF_ALT_C_COMMAND "fd --type d --hidden --follow --exclude .git"

      # ── Prompt ──
      function fish_prompt
        set -l last_status $status
        set -l fg "#ffffce"
        set -l red "#700000"
        set -l green "#9e744d"
        set -l yellow "#fecf75"
        set -l blue "#720102"
        set -l cyan "#979797"
        set -l bg "#000000"

        set -l user (set_color $red --bold)"$USER"
        set -l at (set_color $cyan)"@"
        set -l host (set_color $red --bold)(hostname -s 2>/dev/null || echo "host")
        set -l sep (set_color $cyan)":"

        set -l dir (set_color $fg)(prompt_pwd)

        set -l prompt_char (set_color $fg)"❯"
        if test $last_status -ne 0
          set prompt_char (set_color $blue)"❯"
        end

        set -l git_info ""
        if command -v git >/dev/null 2>&1
          set -l branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
          if test -n "$branch"
            if git diff --quiet 2>/dev/null
              set git_info (set_color $green)"  $branch"
            else
              set git_info (set_color $yellow)"  $branch ±"
            end
          end
        end

        echo -n "$user$at$host$sep$dir$git_info "
        echo -n "$prompt_char "
      end

      function fish_right_prompt
        set -l cyan "#979797"
        echo -n (set_color $cyan)(date "+%H:%M")
      end
    '';

    functions = {
      mkcd = {
        description = "Create directory and cd into it";
        body = ''
          mkdir -p $argv[1] && cd $argv[1]
        '';
      };
      extract = {
        description = "Extract any archive";
        body = ''
          if test -f $argv[1]
            switch $argv[1]
              case "*.tar.bz2"
                tar xjf $argv[1]
              case "*.tar.gz"
                tar xzf $argv[1]
              case "*.tar.xz"
                tar xJf $argv[1]
              case "*.bz2"
                bunzip2 $argv[1]
              case "*.gz"
                gunzip $argv[1]
              case "*.tar"
                tar xf $argv[1]
              case "*.tbz2"
                tar xjf $argv[1]
              case "*.tgz"
                tar xzf $argv[1]
              case "*.zip"
                unzip $argv[1]
              case "*.rar"
                unrar x $argv[1]
              case "*.7z"
                7z x $argv[1]
              case '*'
                echo "Unknown archive: $argv[1]"
            end
          else
            echo "File not found: $argv[1]"
          end
        '';
      };
    };

    plugins = [
      {
        name = "bass";
        src = pkgs.fishPlugins.bass.src;
      }
      {
        name = "colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf.src;
      }
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "sponge";
        src = pkgs.fishPlugins.sponge.src;
      }
      {
        name = "forgit";
        src = pkgs.fishPlugins.forgit.src;
      }
    ];
  };

  home.packages = with pkgs; [
    oh-my-fish
    fd
    ripgrep
    bat
    eza
    fzf
    zoxide
  ];
}
