{
  description = ''read & write subtitle files with sbttl'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."sbttl-main".dir   = "main";
  inputs."sbttl-main".owner = "nim-nix-pkgs";
  inputs."sbttl-main".ref   = "master";
  inputs."sbttl-main".repo  = "sbttl";
  inputs."sbttl-main".type  = "github";
  inputs."sbttl-main".inputs.nixpkgs.follows = "nixpkgs";
  inputs."sbttl-main".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}