{
  services.parcellite = {
    enable = true;
    extraOptions = [ "--no-icon" ];
  };

  nmt.script = ''
    assertFileContent \
        "home-files/.config/systemd/user/parcellite.service" \
        ${./parcellite-expected.service}
  '';
}
