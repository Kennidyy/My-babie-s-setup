{
  programs.ranger = {
    enable = true;

    settings = {
      preview_images = true;
      preview_images_method = "kitty";
      draw_borders = true;
      draw_bookmark_borders = true;
      draw_progress_bar_in_statusbar = true;
      padding_right = 2;
      column_ratios = "1,2,3";
      sort_directories_first = true;
      sort_case_insensitive = true;
      autosave_bookmarks = true;
      autoupdate_cumulative_size = true;
      confirm_on_delete = "multiple";
      display_tags_in_all_columns = true;
      hidden_filter = "";
      mouse_enabled = true;
      preview_files = true;
      preview_directories = true;
      scroll_offset = 8;
      show_hidden_bookmarks = true;
      show_selection_in_titlebar = true;
      statusbar_on_top = false;
      update_title = true;
      vcs_aware = true;
      vcs_backend_git = "enabled";
      w3m_delay = 0;
      wrap_plaintext_previews = true;
    };

    mappings = {
      yy = "copy";
      dd = "cut";
      pp = "paste";
      po = "paste overwrite";
      pl = "paste symlink";
      ph = "paste hardlink";
      Y = "copy";
      X = "cut";
      "delete" = "delete";
      " " = "mark";

      H = "history_go -1";
      L = "history_go 1";
      "~" = "toggle_visual_mode";
      "." = "toggle_flat";
      zi = "toggle_preview";
      zh = "toggle_hidden";
      "<C-f>" = "move_right 10";
      "<C-b>" = "move_left 10";

      "gn" = "tab_new";
      "gf" = "tab_new ~";
      "gt" = "tab_move 1";
      "gT" = "tab_move -1";
      "gc" = "tab_close";
      "gr" = "tab_restore";

      "gh" = "cd ~";
      "gd" = "cd ~/Downloads";
      "g/" = "cd /";

      "mb" = "add_bookmark";
      "ub" = "remove_bookmark";
      "cb" = "clear_bookmarks";
      "tb" = "traverse";

      "/" = "search";
      "n" = "search_next";
      "N" = "search_prev";

      "os" = "sort size";
      "on" = "sort name";
      "od" = "sort mtime";
      "ot" = "sort type";
      "or" = "sort reverse";

      S = "shell";
      t = "shell touch %f";
      md = "mkdir";
      "!" = "shell -w";
      cw = "rename";
      A = "rename_append";
      a = "rename_append";
      I = "rename_prepend";
      du = "shell -w du --max-depth=1 -h";

      e = "edit";
      i = "display_file";
      r = "open_with";
      q = "quit";
      Q = "quitall";
      "<C-q>" = "quit";
      "<C-w>" = "tab_close";

      ec = "compress";
      ex = "extract";

      b = "fzm";
      F = "fzf_select";

      br = "bulkrename";
      yp = "shell echo -n %d | xclip -selection clipboard";
      yd = "shell echo -n %d/%f | xclip -selection clipboard";
      nv = "shell nvim %d/%f";
    };

    extraConfig = ''
      default_linemode devicons2
      set preview_script ~/.config/ranger/scope.sh
      set use_preview_script true
      set colorscheme default

      map zh set hidden!
      map zi set preview_files!
      map zp set preview_directories!
      map dt chain cut; paste
      map te shell tmux split-window -h
      map td shell tmux split-window -v
      map tt shell tmux new-window

      class fzf_select(Command):
          def execute(self):
              import subprocess
              command="fd --type f --hidden --follow --exclude .git | fzf --height=60% --reverse --border"
              fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
              stdout, _ = fzf.communicate()
              if fzf.returncode == 0:
                  fzf_file = stdout.rstrip('\n')
                  self.fm.select_file(fzf_file)
    '';

    plugins = [
      {
        name = "ranger-archives";
        src = builtins.fetchGit {
          url = "https://github.com/maximtrp/ranger-archives";
          ref = "master";
          rev = "b4e136b24fdca7670e0c6105fb496e5df356ef25";
        };
      }
      {
        name = "ranger-devicons2";
        src = builtins.fetchGit {
          url = "https://github.com/cdump/ranger-devicons2";
          ref = "master";
          rev = "94bdcc19218681debb252475fd9d11cfd274d9b1";
        };
      }
      {
        name = "ranger_tmux";
        src = builtins.fetchGit {
          url = "https://github.com/joouha/ranger_tmux";
          ref = "master";
          rev = "05ba5ddf2ce5659a90aa0ada70eb1078470d972a";
        };
      }
    ];
  };

  home.file.".config/ranger/scope.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      set -o noclobber -o noglob -o nounset -o pipefail
      IFS=$'\n'

      handle_extension() {
          case "''${FILE_EXTENSION_LOWER}" in
              a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
              rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|z|zip)
                  atool --list -- "''${FILE_PATH}" && exit 5;;
              rar)
                  unrar lt -p- -- "''${FILE_PATH}" && exit 5;;
              7z)
                  7z l -p -- "''${FILE_PATH}" && exit 5;;
              pdf)
                  pdftotext -l 10 -nopgbrk -q -- "''${FILE_PATH}" "-" && exit 5;;
              htm|html|xhtml)
                  w3m -dump "''${FILE_PATH}" && exit 5;;
              json)
                  python3 -m json.tool -- "''${FILE_PATH}" && exit 5;;
          esac
      }

      handle_mime() {
          case "''${1}" in
              text/*)
                  bat --color=always --pager=never --theme=Fahrenheit "''${FILE_PATH}" && exit 5;;
              image/*)
                  exit 4;;
              video/*|audio/*)
                  exiftool "''${FILE_PATH}" && exit 5;;
              application/pdf)
                  pdftotext -l 10 -nopgbrk -q -- "''${FILE_PATH}" "-" | fmt -w "''${PV_WIDTH}" && exit 5;;
              application/zip|application/x-tar)
                  atool --list -- "''${FILE_PATH}" && exit 5;;
          esac
      }

      FILE_PATH="''${1}"
      PV_WIDTH="''${3}"
      FILE_EXTENSION="''${FILE_PATH##*.}"
      FILE_EXTENSION_LOWER="$(echo "''${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')"
      handle_extension
      MIMETYPE="$(file --dereference --brief --mime-type -- "''${FILE_PATH}")"
      handle_mime "''${MIMETYPE}"
      exit 1
    '';
  };
}
