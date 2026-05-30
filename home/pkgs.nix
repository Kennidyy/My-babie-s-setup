{ pkgs, ... }: {
  home.packages = with pkgs; [
    # ── Terminal ──
    ghostty

    # ── Dev ──
    git
    jq
    opencode

    # ── Ranger preview deps ──
    atool
    poppler
    exiftool

    # ── System ──
    bibata-cursors
    swww
    fastfetch
    htop
  ];
}
