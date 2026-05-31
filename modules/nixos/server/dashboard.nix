{ pkgs, ... }: {
  services.getty.autologinUser = "root";

  programs.bash.loginShellInit = ''
    case "$(tty)" in
      /dev/tty1) exec ${pkgs.btop}/bin/btop ;;
      /dev/tty2) exec journalctl -f ;;
    esac
  '';
}
