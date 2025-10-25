{
  services.pass-secret-service = {
    enable = true;
    storePath = "/mnt/password-store";
  };

  test.stubs.pass-secret-service = {
    name = "pass_secret_service";
    outPath = null;
  };

  nmt.script = ''
    serviceFile=home-files/.config/systemd/user/pass-secret-service.service

    assertFileExists $serviceFile
    assertFileRegex $serviceFile 'ExecStart=.*/bin/pass_secret_service'
    assertFileRegex $serviceFile '/mnt/password-store'
  '';
}
