DESCRIPTION = "Virtual capability provider for zlib";
HOMEPAGE = "https://www.zlib.net/";

PROVIDERS = {
	"posix-apt": "zlib1g-dev",
	"posix-brew": "zlib",
	"windows-vcpkg": "zlib:x64-windows",
	"upp-plugin": "plugin/z"
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
