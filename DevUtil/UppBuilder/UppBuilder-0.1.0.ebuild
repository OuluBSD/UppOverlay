DESCRIPTION = "Advanced U++ Meta-Builder with Portage-style USE flags and multi-assembly resolution";
HOMEPAGE = "https://github.com/OuluBSD/UppBuilder";
GIT_REPO = "https://github.com/OuluBSD/UppBuilder.git";
GIT_BRANCH = "main";
DEFAULT_PACKAGE = "UppBuilder";

IUSE = [ "blitz", "debug" ];
ACCEPTFLAGS = [ "BLITZ", "DEBUG" ];

src_unpack() {
	GitCheckout(GIT_REPO, GIT_BRANCH);
}

src_compile() {
	if (HostOs() == "windows")
		Exec("bootstrap.bat");
	else
		Exec("./bootstrap.sh");
}
