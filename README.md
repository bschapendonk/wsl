# wsl
Ansible playbook to setup my WSL

## Assumptions

* Only works on my machine!
* Required Windows 11 25H2 or newer
* Required WSL 2.6.1 or newer
* Required Ubuntu 25.10 or newer
  * Download https://releases.ubuntu.com/questing/ubuntu-25.10-wsl-amd64.wsl
* Requires `bash` as the default shell
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
wsl --install --from-file ubuntu-25.10-wsl-amd64.wsl

# after the installation / reboots, shut wsl down and update it to the latest version
wsl --shutdown
wsl --update
```

### 2. Prepare base WSL
```bash
# as long as ansible become is broken, add you user to the sudoers.d with NOPASSWD
# https://github.com/ansible/ansible/issues/85837
sudo sh -c "echo \"$USER  ALL=(ALL)       NOPASSWD: ALL\" >/etc/sudoers.d/$USER"

# update everything
sudo apt -y update
sudo apt -y upgrade

# install minimal required packages
sudo apt -y install python3-pip python3-venv unzip

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
python3 -m pip install ansible argcomplete python-debian
```

### 3. Rename and edit `config.example.yaml` to `config.yaml`

### 4. Run `playbook_wsl.yaml`
```bash
# run as a normal user, the playbook will ask for the root password and elevate when needed!
# probably needs to run twice the first time, with a shell reload in between
ansible-playbook playbook_wsl.yaml
```
