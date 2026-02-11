{ config, lib, pkgs, ... }:

{
  home.file.".local/bin/yoctoctl" = {
    source = pkgs.fetchurl {
      url = "https://github.com/anaskalt/yoctoctl/releases/download/v1.0.1/yoctoctl";
      sha256 = "3288e7f04b1c363a0d29f5f3cc9414d57576e805a9217618d58997ceac56675a";
    };
    executable = true;
  };  
}
