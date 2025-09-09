# wsl
Ansible playbook to setup my WSL

## Assumptions

* Only works on my machine!
* Recent Windows 11 24H2
* Required WSL 2.5.10 or newer
* Required Ubuntu 24.04
* Requires `bash`
* Force installes [Oh My Posh](https://ohmyposh.dev/), which requires
  * [Windows Terminal](https://github.com/microsoft/terminal) 
  * Font eg. [CaskaydiaCove](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaCode.zip)
* Standard installation
  * Git for Windows
  * Visual Studio Code
* Your work is in `~/work` and personal stuff is in `~/personal`, `gitconfigs` for both are created with different username/email see `config.yaml`
* You understand that `ansible` can't reload/source the `bash` session that's it's started from, so especially on first installs it might be needed to rerun the play and restart `bash`.

## Installation

### 1. Install WSL
```shell
# install wsl and ubuntu
wsl --install Ubuntu-24.04

# after the installation / reboots, shut wsl down and update it to the latest version
wsl --shutdown
wsl --update
```

### 2. Prepare base WSL
```bash
# update everything
sudo apt -y update
sudo apt -y upgrade

# install minimal required packages
sudo apt -y install python3-pip

# install homebrew and activate it for the current shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew completions link

# Add git-credential-manager
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"

# exports
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

python3 -m venv ~/.ansible
source ~/.ansible/bin/activate
pip install ansible argcomplete python-debian
```

### 3. Rename and edit `config.example.yaml` to `config.yaml`

### 4. Run `playbook_wsl.yaml`
```bash
# run as a normal user, the playbook will ask for the root password and elevate when needed!
# probably needs to run twice the first time, with a shell reload in between
ansible-playbook playbook_wsl.yaml
```
