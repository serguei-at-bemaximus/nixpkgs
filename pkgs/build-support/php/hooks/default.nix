{ lib
, makeSetupHook
, jq
, moreutils
, makeBinaryWrapper
, cacert
, buildPackages
}:

{
  composerRepositoryHook = makeSetupHook
    {
      name = "composer-repository-hook.sh";
      propagatedBuildInputs = [ jq moreutils cacert ];
      substitutions = { };
    } ./composer-repository-hook.sh;

  composerInstallHook = makeSetupHook
    {
      name = "composer-install-hook.sh";
      propagatedBuildInputs = [ jq makeBinaryWrapper moreutils cacert ];
      substitutions = {
        # Specify the stdenv's `diff` by abspath to ensure that the user's build
        # inputs do not cause us to find the wrong `diff`.
        diff = "${lib.getBin buildPackages.diffutils}/bin/diff";
      };
    } ./composer-install-hook.sh;
}
