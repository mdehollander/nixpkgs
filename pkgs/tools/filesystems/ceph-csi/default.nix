{ stdenv, lib, go, ceph, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "ceph-csi";
  version = "3.10.0";

  nativeBuildInputs = [ go ];
  buildInputs = [ ceph ];

  src = fetchFromGitHub {
    owner = "ceph";
    repo = "ceph-csi";
    rev = "v${version}";
    sha256 = "sha256-k7eipiBcr/a2V62tEtiQrduk5Cj8KGxbmiVo4x6BVwE=";
  };

  preConfigure = ''
    export GOCACHE=$(pwd)/.cache
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ./_output/* $out/bin
  '';

  meta = with lib; {
    homepage = "https://ceph.com/";
    description = "Container Storage Interface (CSI) driver for Ceph RBD and CephFS";
    license = [ licenses.asl20 ];
    maintainers = with maintainers; [ johanot ];
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}
