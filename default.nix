with (import <nixpkgs> {});
let
  LLP = with pkgs; [
    gcc-unwrapped
    cudatoolkit_11.out
    cudatoolkit_11.lib
    linuxPackages.nvidia_x11
    gperftools
    libGL
    glib
    zlib
    python310
    python310Packages.tkinter
  ];
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath LLP;
in  
stdenv.mkDerivation {
  name = "python-ai-env";
  buildInputs = LLP;
  src = null;
  shellHook = ''
    SOURCE_DATE_EPOCH=$(date +%s)
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}
    export XLA_FLAGS=--xla_gpu_cuda_data_dir=${pkgs.cudatoolkit_11}
  '';
}
