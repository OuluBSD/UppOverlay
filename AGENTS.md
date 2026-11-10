# AGENTS - UppOverlay Guide

**For**: All AI agents and developers interacting with `OuluBSD/UppOverlay`.

---

## 1. Purpose & Responsibilities

`UppOverlay` is the central catalog and profile registry for all decoupled repositories in the OuluBSD ecosystem.

### Rules for Visiting Agents
1. **CapitalCase Naming**:
   - Categories use `CapitalCase` (`DevCpp`, `DevUtil`, `MediaSound`, `Virtual`, `AiAgents`, etc.).
   - Packages use `CapitalCase` (`BazaarCore`, `UppBuilder`, `SoftAudio`, `Sqlite`, etc.).
   - Ebuild files follow `<Package>-<Version>.ebuild` (e.g. `BazaarCore-0.1.0.ebuild`).
2. **Esc Syntax Only**:
   - All `.ebuild` files must be valid U++ Esc scripting syntax.
   - Never write Bash/sh Unix-only syntax inside `.ebuild` functions. Use Esc standard library and platform-neutral helper methods (`HostOs()`, `HostHas()`, `GitCheckout()`, `VcpkgInstall()`, `AptInstall()`, `BrewInstall()`).
3. **Registering Decoupled Packages**:
   - Whenever an agent decouples a new package from `ai-upp` or introduces a new repository, an ebuild MUST be registered under `UppOverlay/<Category>/<Package>/`.
   - Ensure `ACCEPTFLAGS` and `IUSE` match the audited declarations in `.upp` files.
4. **Keeping 192.168.1.169 Synced**:
   - After any commit and push, run `ssh 192.168.1.169 "cd ~/Dev/UppOverlay && git pull"`.
