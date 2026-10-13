# Set up this PC to mirror my laptop's WSL2 environment

You are Claude Code running on Windows on my desktop PC. Rebuild my laptop's
WSL2 setup here. Everything config-related is in the public repo
https://github.com/lemkei/wsl2_setup (clone it, read the files, don't guess).
My data then arrives through `hubsync` (rclone bisync to an encrypted Google
Drive remote), which my laptop has already uploaded.

Rules:
- Run Linux commands as `wsl -d Ubuntu-24.04 -u lemkei -- bash -lc '...'`.
  For anything needing root use `-u root` instead of sudo (no password needed).
- Anything interactive (logins, passwords, OAuth, choosing a password) I do
  myself: stop, tell me exactly what to type and where, and wait.
- Never print, copy or write tokens or passwords. Never commit or push.
- Before each phase, say in one line what you're about to do. At the end, give
  me a checklist of what's done and what's left for me.

## Phase 1 — Windows side
1. Record: Windows username (`$env:USERNAME`), total RAM, logical CPU count,
   GPU(s).
2. `wsl --status` and `wsl -l -v`. If Ubuntu-24.04 is missing: tell me to run
   `wsl --install -d Ubuntu-24.04` and create the Linux user **lemkei** when it
   asks. Wait until I confirm. If the user exists under another name, stop and
   tell me: Claude session folders depend on the path `/home/lemkei`.
3. Install WezTerm: `winget install --id wez.wezterm -e`.

## Phase 2 — WSL base
4. As root: write `/etc/wsl.conf` from the repo's `wsl.conf` (systemd on,
   default user lemkei).
5. Write `C:\Users\<username>\.wslconfig` from the repo's `windows/.wslconfig`,
   but set `memory` to about 75% of this PC's RAM and `processors` to its
   logical CPU count. Then `wsl --shutdown` and start the distro again; verify
   `ps -p 1 -o comm=` prints `systemd`.
6. As root: `apt update && apt upgrade -y`, then install:
   `build-essential cmake ninja-build git curl unzip jq openssh-server
   latexmk biber texlive-latex-base texlive-latex-recommended
   texlive-latex-extra texlive-fonts-extra texlive-bibtex-extra
   octave octave-control octave-io octave-optim octave-statistics
   octave-struct dynare tesseract-ocr`
7. As root: install current rclone with `curl https://rclone.org/install.sh | bash`
   (the apt version is too old for bisync). Check `rclone version` ≥ 1.66.

## Phase 3 — user environment (as lemkei)
8. `git clone https://github.com/lemkei/wsl2_setup ~/wsl2_setup`.
9. Back up the existing `~/.bashrc` to `~/.bashrc.orig`, then copy the repo's
   `.bashrc` into `~`. Copy `.config/nvim` to `~/.config/nvim`. `mkdir -p ~/bin`
   and symlink `~/wsl2_setup/bin/hubsync` and `~/wsl2_setup/bin/block` into it.
   Create an empty `~/.secrets.sh` with mode 600 (I fill it later).
10. Toolchain, each with its official installer:
    - uv: `curl -LsSf https://astral.sh/uv/install.sh | sh`
    - nvm into `~/.config/nvm` (`NVM_DIR` is set in .bashrc), then
      `nvm install 20` and `npm i -g @doist/todoist-cli`
    - Rust: rustup (default profile)
    - Julia: juliaup
    - Neovim: latest stable release tarball, unpacked into `~/.local`, with
      `nvim` on PATH. First launch installs plugins via packer.
    - `uv tool install git-filter-repo`
11. `git config --global user.name Lemkei` and
    `git config --global user.email p3rukt@gmail.com`.
12. Claude Code inside WSL: `curl -fsSL https://claude.ai/install.sh | bash`.
    Don't log in. That's for me.

## Phase 4 — WezTerm
13. Copy the repo's `windows/.wezterm.lua` to `C:\Users\<username>\.wezterm.lua`.
    Two adjustments:
    - The GPU loop picks an integrated Dx12 adapter. If this PC has a discrete
      GPU, change it to prefer `device_type == "DiscreteGpu"` with Dx12.
    - The background image path points to a missing file. Leave it unless I
      say otherwise.
    Check: WezTerm opens straight into Ubuntu-24.04.

## Phase 5 — sync (needs me)
14. Tell me to open WezTerm and run `rclone config` to create:
    - `gdrive`: type `drive`, scope `drive`, auto config **yes**. The auth URL
      opens in my Windows browser, and localhost forwarding carries the
      callback into WSL.
    - `gcrypt`: type `crypt`, remote `gdrive:hub-sync`, filename encryption
      `standard`, directory name encryption `true`, and the **same two
      passwords as on the laptop** (from my password manager).
    Wait for me. Verify with `rclone lsd gcrypt:home`: it should list
      `hub`, `classes` and `.claude` as readable names.
15. If `~/.claude/settings.json` exists, move it to
    `~/.claude/settings.json.pc-orig`. Then the first sync, preferring the
    cloud copy: `hubsync --resync --resync-mode path2`. It's ~2.3 GB.
16. Verify: `~/hub`, `~/classes`, `~/CLAUDE.md` and
    `~/.claude/projects/-home-lemkei-hub/` exist, and
    `git -C ~/hub status` works.

## Phase 6 — hand back to me (don't do these, list them)
- `claude` → log in to the personal account. Then `claude --resume` inside
  `~/hub` should list the laptop's sessions.
- `claude work` → log in to the work account (`~/.claude-work` is not synced).
- Secrets to copy by hand: Kaggle token into `~/.secrets.sh`, Todoist token
  (`td` login or `~/.todoist.config.json`), `~/hub/.fitbit_tokens.json`
  (if missing).
- New SSH key (`ssh-keygen -t ed25519`), added to GitHub.
- Google Drive MCP: `git clone https://github.com/michaelpine25/googleDriveMCP
  ~/googleDriveMCP`, `npm install && npm run build`, copy `credentials.json`,
  run `npm run tokenGenerator`, then register it with `claude mcp add`.
- Optional: miniconda, MATLAB, Gemini CLI.

Daily rule from now on: run `hubsync` before closing a machine and right after
opening the other.
