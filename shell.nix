{ pkgs ? import<nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    gnumake
    crystal
    shards
  ];
}
