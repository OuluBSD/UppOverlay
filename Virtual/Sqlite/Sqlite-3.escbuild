DESCRIPTION = "Virtual capability provider for SQLite3";
HOMEPAGE = "https://www.sqlite.org/";

PROVIDERS = {
	"posix-apt": "libsqlite3-dev",
	"posix-brew": "sqlite",
	"windows-vcpkg": "sqlite3:x64-windows",
	"upp-plugin": "plugin/sqlite"
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
