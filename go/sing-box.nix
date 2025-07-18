{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "sing-box";
  version = "1.11.14";

  src = fetchFromGitHub {
    owner = "SagerNet";
    repo = "sing-box";
    rev = "v${version}";
    hash = "sha256-GgFsTLMyrNsYT9GUlnXnSzynIa2D2ECtcYvKMfvndkA=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-ULfPmVQ2Ngr1ujeCmUPOOaqxyQmbgqH1w6P9TwvjhSo=";

  tags = [
    "with_gvisor"
    "with_quic"
    "with_wireguard"
    "with_grpc"
    "with_ech"
    "with_utls"
    "with_reality_server"
    "with_acme"
    "with_clash_api"
    "with_v2ray_api"
    "with_dhcp"
    # "with_embedded_tor" # needs cgo and depends on libs
    # "with_lwip" # needs cgo and depends on libs
  ];
  ldflags = [
    "-s"
    "-w"
    "-X github.com/sagernet/sing-box/constant.Version=${version}"
  ];
  subPackages = [ "cmd/sing-box" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/SagerNet/sing-box";
    license = lib.licenses.gpl3Plus;
  };
}
