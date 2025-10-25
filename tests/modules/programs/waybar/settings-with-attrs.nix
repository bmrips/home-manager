args:

{
  home.stateVersion = "21.11";

  programs.waybar = {
    enable = true;
    settings =
      let
        settingsComplex = (import ./settings-complex.nix args).programs.waybar.settings;
      in
      {
        mainBar = builtins.head settingsComplex;
        secondaryBar = builtins.elemAt settingsComplex 1;
      };
  };

  nmt.script = ''
    assertPathNotExists home-files/.config/waybar/style.css
    assertFileContent \
      home-files/.config/waybar/config \
      ${./settings-complex-expected.json}
  '';
}
