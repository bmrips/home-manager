{
  programs.keepassxc = {
    enable = true;
  };

  nmt.script = ''
    assertPathNotExists home-files/.config/keepassxc/keepassxc.ini
  '';
}
