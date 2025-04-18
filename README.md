# wsl
Ansible playbook to setup my WSL

## Assumptions

* Only works on my machine!
* Recent Windows 11 24H2
* Required WSL 2.4.13 or newer
* Required Fedora 42
* Requires `bash`
* Force installes [Oh My Posh](https://ohmyposh.dev/), which requires
  * [Windows Terminal](https://github.com/microsoft/terminal) 
  * Font eg. [CaskaydiaCove](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/CascadiaCode.zip)
* Standard installation
  * Git for Windows
  * Visual Studio Code
* Your work is in `~/work` and personal stuff is in `~/personal`, `gitconfigs` for both are created with different username/email see `config.yaml`
* You understand that `ansible` can't reload/source the `bash` session that's it's started from, so especially on first installs it might be needed to rerun the play and restart `bash`.

## Installation

### 1. Install WSL
```shell
# install wsl and Fedora
wsl --install FedoraLinux-42

# after the installation / reboots, shut wsl down and update it to the latest version
wsl --shutdown
wsl --update
```

### 2. Prepare base WSL
```bash
sudo dnf update --refresh
sudo dnf install git python3-libdnf5 pipx

# Add git-credential-manager
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"

# install homebrew and activate it for the current shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew completions link

# exports
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

pipx install --include-deps ansible
```

### 3. Rename and edit `config.example.yaml` to `config.yaml`

### 4. Run `playbook_wsl.yaml`
```bash
# run as a normal user, the playbook will ask for the root password and elevate when needed!
# probably needs to run twice the first time, with a shell reload in between
ansible-playbook playbook_wsl.yaml
```

