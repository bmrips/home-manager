{ config, ... }:

{
  xsession = {
    enable = true;
    windowManager.command = "";
  };

  services.sxhkd = {
    enable = true;
    extraOptions = [ "-m 1" ];
  };

  test.stubs.sxhkd.name = "sxhkd";

  nmt.script = ''
    xsessionFile=home-files/.xsession

    assertFileExists $xsessionFile

    assertFileContains $xsessionFile \
      'systemctl --user stop sxhkd.scope 2> /dev/null || true'

    assertFileContains $xsessionFile \
      'systemd-cat -t sxhkd systemd-run --user --scope --property=OOMPolicy=continue -u sxhkd @sxhkd@/bin/sxhkd -m 1 &'
  '';
}
