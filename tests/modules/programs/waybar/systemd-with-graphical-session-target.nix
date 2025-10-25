{
  home.stateVersion = "21.11";

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "sway-session.target";
  };

  test.stubs.waybar.name = "waybar";

  nmt.script = ''
    assertPathNotExists home-files/.config/waybar/config
    assertPathNotExists home-files/.config/waybar/style.css

    serviceFile=$(normalizeStorePaths home-files/.config/systemd/user/waybar.service)
    assertFileContent "$serviceFile" ${./systemd-with-graphical-session-target.service}
  '';
}
