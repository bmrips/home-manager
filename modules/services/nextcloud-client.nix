{
  config,
  lib,
  pkgs,
  ...
}:
let

  cfg = config.services.nextcloud-client;

in
{
  options = {
    services.nextcloud-client = {
      enable = lib.mkEnableOption "Nextcloud Client";

      package = lib.mkPackageOption pkgs "nextcloud-client" { };

      startInBackground = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to start the Nextcloud client in the background.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      (lib.hm.assertions.assertPlatform "services.nextcloud-client" pkgs lib.platforms.linux)
    ];

    systemd.user.services.nextcloud-client = {
      Unit = {
        Description = "Nextcloud Client";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Environment = [ "PATH=${config.home.profileDirectory}/bin" ];
        ExecStart = lib.getExe cfg.package + lib.optionalString cfg.startInBackground " --background";
        ExecStop = "${lib.getExe cfg.package} --quit";
        KillMode = "process";
        Restart = "on-failure";
        RestartSec = "5s";
        NoNewPrivileges = true;
        RestrictRealtime = true;
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
