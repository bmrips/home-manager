{
  programs.zsh = {
    enable = true;
    zprof.enable = true;
  };

  nmt.script = ''
    assertFileRegex home-files/.zshrc 'zmodload zsh/zprof'
    assertFileRegex home-files/.zshrc '^zprof$'
  '';
}
