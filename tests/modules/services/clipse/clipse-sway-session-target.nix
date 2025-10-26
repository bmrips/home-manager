{
  services.clipse = {
    enable = true;
    systemdTarget = "sway-session.target";
  };

  nmt.script = ''
    assertFileExists home-files/.config/systemd/user/clipse.service
  '';
}
