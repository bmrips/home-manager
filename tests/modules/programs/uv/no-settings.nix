{
  programs.uv = {
    enable = true;
  };

  nmt.script =
    let
      expectedConfigPath = "home-files/.config/uv/uv.toml";
    in
    ''
      assertPathNotExists "${expectedConfigPath}"
    '';
}
