DESCRIPTION = "Virtual capability provider for libpng";
HOMEPAGE = "http://www.libpng.org/";

PROVIDERS = {
	"posix-apt": "libpng-dev",
	"posix-brew": "libpng",
	"windows-vcpkg": "libpng:x64-windows",
	"upp-plugin": "plugin/png"
};

src_install() {
	if (HostOs() == "windows")
		VcpkgInstall(PROVIDERS["windows-vcpkg"]);
	else if (HostHas("apt-get"))
		AptInstall(PROVIDERS["posix-apt"]);
	else if (HostHas("brew"))
		BrewInstall(PROVIDERS["posix-brew"]);
	else
		UseUppPlugin(PROVIDERS["upp-plugin"]);
}
