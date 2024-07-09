# wsl
Ansible playbook to setup my WSL

## Assumptions

* Only works on my machine!
* Recent Windows 11 23H2 / 24/H2
* WSL 2.2.4
* Force installes [Oh My Posh](https://ohmyposh.dev/), which requires
  * [Windows Terminal](https://github.com/microsoft/terminal) 
  * Font eg. [CaskaydiaCove](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip)
* Standard installation
  * Git for Windows
  * Visual Studio Code
* Your work is in `~/work` and personal stuff is in `~/personal`, `gitconfigs` for both are created with different username/email see `config.yaml`

## Installation

### 1. Install WSL
```shell
# install wsl and ubuntu
wsl --install Ubuntu-24.04

# after the installation / reboots, shut wsl down and update it to the latest version
wsl --shutdown
wsl --update
```

```shell
# %USERPROFILE%\.wslconfig
[wsl2]
networkingMode=mirrored
dnsTunneling=true

[experimental]
autoMemoryReclaim=dropcache
sparseVhd=true
```

### 2. Prepare base WSL
```bash
# update everything
sudo apt -y update
sudo apt -y upgrade

# install minimal required packages
sudo apt -y install git python3-pip python3-dev python3-venv sshpass wget ca-certificates

# install homebrew and activate it for the current shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Add git-credential-manager
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"

# Create VENV for ansible under `.ansible`
python3 -m venv .ansible

# Activate VENV
source ~/.ansible/bin/activate

# install ansible
pip3 install --upgrade wheel
pip3 install -U ansible
```

### 3. Rename and edit `config.example.yaml` to `config.yaml`

### 4. Run `playbook_wsl2.yaml`
```bash
# run as a normal user, the playbook will ask for the root password and elevate when needed!
# probably needs to run twice the first time, with a shell reload in between
ansible-playbook playbook_wsl2.yaml
```
