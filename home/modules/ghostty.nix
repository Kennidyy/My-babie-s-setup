{ pkgs, ... }: {
  xdg.configFile."ghostty/config" = {
    force = true;
    text = ''
      confirm-close-surface = false
      theme = Fahrenheit
      font-family = IBM Plex Mono
      font-size = 13
    '';
  };
}
