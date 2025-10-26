{
  programs.kitty = {
    enable = true;

    shellIntegration.mode = null;
  };

  nmt.script = ''
    assertFileExists home-files/.config/kitty/kitty.conf
    assertFileContent \
      home-files/.config/kitty/kitty.conf \
      ${./null-shellIntegration-expected.conf}
  '';
}
