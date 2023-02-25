{
    projectName     ? "cpp-template",
    environ         ? import ./nixpkgs
}:

let

customOverlays      = [];
env                 = environ { inherit customOverlays; };

pkgs                = env.pkgs;
gcc                 = pkgs.gcc12;

macOsSpecificTools  = [];
devEnv              = pkgs.mkShellNoCC {
     # Sets the build inputs, i.e. what will be available in our
     # local environment.
     nativeBuildInputs = with pkgs; [
        gcc
        cmake
        cmakeCurses

     ] ++ macOsSpecificTools;
     buildInputs = with pkgs; [
        openssl
     ];
     shellHook = ''
         export PROJECT_PLATFORM="${builtins.currentSystem}"
         export PROJECT_NAME="${projectName}"
         export LANG=en_GB.UTF-8
         # for no apparent reason, this prevents `ld: library not found for -liconv` errors on recent MacOS versions
         unset NIX_LDFLAGS

         export CXX="${gcc}/bin/gcc"
     '';
};

in
{
    inherit devEnv;
}