{ ... }:

{
  programs.git = {
    enable = true;
    userEmail = "spencervess@protonmail.com";
    userName = "Spencer Vess";
    signing.key = "0EFA2F78096BDE48";
    signing.signByDefault = true;

    extraConfig = ''
      [init]
        defaultBranch = main
    '';
  };
}
