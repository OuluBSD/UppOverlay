DESCRIPTION = "Virtual capability provider for OpenSSL / TLS";
HOMEPAGE = "https://www.openssl.org/";

PROVIDERS = {
	"posix-apt": "libssl-dev",
	"posix-brew": "openssl",
	"windows-vcpkg": "openssl:x64-windows"
};

src_install() {
	if (HostOs() == "windows")
		VcpkgInstall(PROVIDERS["windows-vcpkg"]);
	else if (HostHas("apt-get"))
		AptInstall(PROVIDERS["posix-apt"]);
	else if (HostHas("brew"))
		BrewInstall(PROVIDERS["posix-brew"]);
}
