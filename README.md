# UppOverlay

**UppOverlay** is the central package overlay, profile registry, and Portage-style metadata repository for the Ultimate++ (`U++`) ecosystem and `OuluBSD` decoupled repositories.

---

## 1. Overview & Philosophy

Following the repository splitting of the monolithic `ai-upp` into focused autonomous repositories, `UppOverlay` provides:
1. **Centralized Discovery & Catalog**: Single source of truth mapping all ecosystem packages to their owning Git repositories, assemblies, and dependencies.
2. **Esc-Powered Ebuilds**: Package declarations and recipes written in U++'s native **Esc** scripting language, providing clean C/JS-like syntax, safe evaluation, and cross-platform flexibility without shell dependencies.
3. **Multi-Profile Simultaneous Realization**: Unlike Gentoo's single-system installation, `UppOverlay` supports simultaneous active profiles (`NativeClang`, `NativeGcc`, `MsvcX64`, `WasmBrowser`, etc.).
4. **Build Deduplication via `acceptflags`**: Projects share build artifacts in a central global cache (`~/.cache/upp.out`) because packages declare explicit `ACCEPTFLAGS`, preventing unrelated application flags from triggering unnecessary rebuilds.
5. **Cross-Platform Virtual Providers (`Virtual/*`)**: External dependencies (`Virtual/Sqlite`, `Virtual/Ssl`, `Virtual/Png`, `Virtual/Zlib`) cleanly map to native host managers (`apt-get`, `brew`, `vcpkg`) or fallback to bundled U++ plugins (`plugin/sqlite`, `plugin/png`).

---

## 2. Directory Hierarchy (CapitalCase)

```
UppOverlay/
├── metadata/
│   └── layout.conf
├── profiles/
│   ├── repo_name
│   ├── categories
│   ├── base/
│   │   └── make.conf
│   └── targets/
│       ├── NativeClang/make.conf
│       ├── NativeGcc/make.conf
│       ├── MsvcX64/make.conf
│       └── WasmBrowser/make.conf
├── DevCpp/
│   └── BazaarCore/
│       └── BazaarCore-0.1.0.ebuild
├── DevUtil/
│   ├── UppBuilder/
│   │   └── UppBuilder-0.1.0.ebuild
│   └── UppBootstrap/
│       └── UppBootstrap-0.1.0.ebuild
├── MediaSound/
├── MediaVideo/
├── MediaGfx/
├── AiAgents/
├── X11Wm/
└── Virtual/
    ├── Sqlite/Sqlite-3.ebuild
    ├── Ssl/Ssl-1.ebuild
    ├── Png/Png-1.ebuild
    └── Zlib/Zlib-1.ebuild
```

---

## 3. Esc Ebuild Format Example

Every `.ebuild` file is valid **Esc** code:

```esc
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
```

---

## 4. Virtual Capability Provider Example

```esc
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
```

---

## 5. License
BSD 2-Clause License.
