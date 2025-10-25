{
  services.pantalaimon = {
    enable = true;
    settings = {
      Default = {
        LogLevel = "Debug";
        SSL = true;
      };
      local-matrix = {
        Homeserver = "https://matrix.org";
        ListenAddress = "127.0.0.1";
        ListenPort = 8008;
      };
    };
  };

  nmt.script = ''
    serviceFile=home-files/.config/systemd/user/pantalaimon.service
    assertFileExists $serviceFile
    assertFileRegex $serviceFile 'ExecStart=@pantalaimon@/bin/pantalaimon -c /nix/store/.*-pantalaimon.conf'
  '';
}
