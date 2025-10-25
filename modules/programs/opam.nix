{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.opam;
in
{
  meta.maintainers = [ ];

  options.programs.opam = {
    enable = lib.mkEnableOption "Opam";

    package = lib.mkPackageOption pkgs "opam" { };

    enableBashIntegration = lib.hm.shell.mkBashIntegrationOption { inherit config; };

    enableFishIntegration = lib.hm.shell.mkFishIntegrationOption { inherit config; };

    enableZshIntegration = lib.hm.shell.mkZshIntegrationOption { inherit config; };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    programs.bash.initExtra = lib.mkIf cfg.enableBashIntegration ''
      eval "$(${lib.getExe cfg.package} env --shell=bash)"
    '';

    programs.zsh.initContent = lib.mkIf cfg.enableZshIntegration ''
      eval "$(${lib.getExe cfg.package} env --shell=zsh)"
    '';

    programs.fish.shellInit = lib.mkIf cfg.enableFishIntegration ''
      eval (${lib.getExe cfg.package} env --shell=fish)
    '';
  };
}
