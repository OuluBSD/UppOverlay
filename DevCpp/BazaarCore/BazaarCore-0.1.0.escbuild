DESCRIPTION = "BazaarCore: Foundation assembly, Core/Ext, and Tier 3 packages";
HOMEPAGE = "https://github.com/OuluBSD/BazaarCore";
GIT_REPO = "https://github.com/OuluBSD/BazaarCore.git";
GIT_BRANCH = "main";
UPP_ASSEMBLY = "patched-uppsrc,uppsrc";
DEFAULT_PACKAGE = "uppsrc/Manager";

IUSE = [ "blitz", "debug", "gui", "shared", "usemalloc", "tui" ];
ACCEPTFLAGS = [ "BLITZ", "DEBUG", "GUI", "SHARED", "USEMALLOC", "TUI", "POSIX", "LINUX", "WIN32" ];

RDEPEND = [
	"DevUtil/UppBuilder",
	"DevUtil/UppBootstrap"
];

src_unpack() {
	GitCheckout(GIT_REPO, GIT_BRANCH);
}

src_compile() {
	UppBuild(DEFAULT_PACKAGE);
}
