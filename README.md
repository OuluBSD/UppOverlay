# UppOverlay

**UppOverlay** is the central package overlay, profile registry, and Portage-style metadata repository for the Ultimate++ (`U++`) ecosystem and `OuluBSD` decoupled repositories.

---

## 1. Overview & Philosophy

Following the repository splitting of the monolithic `ai-upp` into focused autonomous repositories, `UppOverlay` provides:
1. **Centralized Discovery & Catalog**: Single source of truth mapping all ecosystem packages to their owning Git repositories, assemblies, and dependencies.
2. **Esc-Powered Escbuilds**: Package declarations and recipes written in U++'s native **Esc** scripting language, providing clean C/JS-like syntax, safe evaluation, and cross-platform flexibility without shell dependencies.
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
│       └── BazaarCore-0.1.0.escbuild
├── DevUtil/
│   ├── UppBuilder/
│   │   └── UppBuilder-0.1.0.escbuild
│   └── UppBootstrap/
│       └── UppBootstrap-0.1.0.escbuild
├── MediaSound/
├── MediaVideo/
├── MediaGfx/
├── AiAgents/
├── X11Wm/
└── Virtual/
    ├── Sqlite/Sqlite-3.escbuild
    ├── Ssl/Ssl-1.escbuild
    ├── Png/Png-1.escbuild
    └── Zlib/Zlib-1.escbuild
```

---

## 3. Esc Escbuild Format Example

Every `.escbuild` file is valid **Esc** code:

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

## 5. Current Registered Packages (28)

| Atom | Description | Upstream Repository |
|---|---|---|
| `AiAgents/Aria-0.1.0` | Browser automation, stealth CDP/Marionette scraping | [OuluBSD/Aria](https://github.com/OuluBSD/Aria) |
| `AiAgents/ArtificialIntelligence-0.1.0` | Cognitive reasoning, neural search, knowledge graphs | [OuluBSD/ArtificialIntelligence](https://github.com/OuluBSD/ArtificialIntelligence) |
| `AiAgents/CommandCenter-0.1.0` | Dropdown developer terminal (DropTerm) and runner | [OuluBSD/CommandCenter](https://github.com/OuluBSD/CommandCenter) |
| `AiAgents/SuperIntelligence-0.1.0` | Autonomous AI agent framework, MCP, and Playground | [OuluBSD/SuperIntelligence](https://github.com/OuluBSD/SuperIntelligence) |
| `DevCpp/AgentIPC-0.1.0` | Cross-platform inter-process communication for AI agents | [OuluLinux/AgentIPC](https://github.com/OuluLinux/AgentIPC) |
| `DevCpp/BasicHtmlRenderer-0.1.0` | Native HTML/DOM rendering, virtual widgets, and bridge | [OuluBSD/BasicHtmlRenderer](https://github.com/OuluBSD/BasicHtmlRenderer) |
| `DevCpp/BazaarCore-0.1.0` | Foundation assembly, Core/Ext, and Tier 3 packages | [OuluBSD/BazaarCore](https://github.com/OuluBSD/BazaarCore) |
| `DevCpp/Eon-0.1.0` | Eon Dataflow, ECS Engine, Node Scripting, and Workbench | [OuluBSD/Eon](https://github.com/OuluBSD/Eon) |
| `DevCpp/UppGeometry-0.1.0` | 3D geometry engine, vector math, spatial transforms | [OuluBSD/UppGeometry](https://github.com/OuluBSD/UppGeometry) |
| `DevCpp/VFS-0.1.0` | Virtual File System, Component Extensions, and Shell | [OuluBSD/VFS](https://github.com/OuluBSD/VFS) |
| `DevLang/SoftScript-0.1.0` | Multi-language bytecode VM, Python dialect, transpilers | [OuluBSD/SoftScript](https://github.com/OuluBSD/SoftScript) |
| `DevLang/VisualScript-0.1.0` | Visual Script form designer, UI editor, and script IDE | [OuluBSD/VisualScript](https://github.com/OuluBSD/VisualScript) |
| `DevUtil/Gubo-0.1.0` | Voxel, procedural 3D block engine, and OpenGL controls | [OuluBSD/Gubo](https://github.com/OuluBSD/Gubo) |
| `DevUtil/IDE-0.1.0` | Modular TheIDE architecture and DevEnv environment | [OuluBSD/IDE](https://github.com/OuluBSD/IDE) |
| `DevUtil/UppBootstrap-0.1.0` | Bootstrap compiler for U++ umk meta-builder | [OuluBSD/UppBootstrap](https://github.com/OuluBSD/UppBootstrap) |
| `DevUtil/UppBuilder-0.1.0` | Advanced U++ Meta-Builder with Portage-style USE flags | [OuluBSD/UppBuilder](https://github.com/OuluBSD/UppBuilder) |
| `Games/UppGame-0.1.0` | 2D/3D game engines, card games, and adventure runtime | [OuluBSD/UppGame](https://github.com/OuluBSD/UppGame) |
| `MediaGfx/ComputerVision-0.1.0` | Computer vision, camera calibration, stereo disparity | [OuluBSD/ComputerVision](https://github.com/OuluBSD/ComputerVision) |
| `MediaGfx/Scene3D-0.1.0` | 3D scene graph, SoftRend rasterizer, and ModelerApp | [OuluBSD/Scene3D](https://github.com/OuluBSD/Scene3D) |
| `MediaGfx/Shaders-0.1.0` | GPU shader pipeline, ShaderToy player, and GraphLib | [OuluBSD/Shaders](https://github.com/OuluBSD/Shaders) |
| `MediaGfx/UppXR-0.1.0` | XR, VR, HMD tracking, stereo vision, SoftVR | [OuluBSD/UppXR](https://github.com/OuluBSD/UppXR) |
| `MediaSound/SoftAudio-0.1.0` | Audio synthesis, MIDI sequencing, and SoundCtrl | [OuluBSD/SoftAudio](https://github.com/OuluBSD/SoftAudio) |
| `MediaVideo/SoftVideo-0.1.0` | Video streaming, decoding, playback, and RasterPlayer | [OuluBSD/SoftVideo](https://github.com/OuluBSD/SoftVideo) |
| `Virtual/Png-1` | Virtual capability provider for libpng | [libpng](https://www.libpng.org/) |
| `Virtual/Sqlite-3` | Virtual capability provider for SQLite3 | [SQLite](https://www.sqlite.org/) |
| `Virtual/Ssl-1` | Virtual capability provider for OpenSSL / TLS | [OpenSSL](https://www.openssl.org/) |
| `Virtual/Zlib-1` | Virtual capability provider for zlib | [zlib](https://www.zlib.net/) |
| `X11Wm/UppDesktop-0.1.0` | Modular X11 desktop environment, TaskBar, DisplayManager | [OuluBSD/UppDesktop](https://github.com/OuluBSD/UppDesktop) |

---

## 6. License
BSD 2-Clause License.
