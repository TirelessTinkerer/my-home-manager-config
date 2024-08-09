# Manage my linux system with Nix and home-manager

## How to use
1. Follow https://zero-to-nix.com/start/install to install nix.
2. git clone this repo to ~/.config/home-manager.
3. Edit the rough edges listed below.
4. Run `nix run home-manager/master -- init --switch`
5. After the initial installation, we can run `home-manager switch --impure`. The `impure` flag is due to we are calling getEnv.

## Rough Edges:
1. In `flake.nix`, edit `YOUR_USER_NAME` in line `homeConfigurations."YOUR_USER_NAME" = home-manager.lib.homeManagerConfiguration {`. (Update 2024-07-28 this is not needed any more since I use getEnv, which is also why we need to use the impure flag.)
2. In `home.nix`, edit `home.username = "YOUR_USER_NAME";` and `home.homeDirectory = "/home/YOUR_USER_NAME";`. (no need any more)
3. In `home.nix`, edit PROMPT to put your computer nick name or hostname
4. In `tmux.conf`, edit
```
set-option -ga status-right " #[fg=default,bold]#S #[fg=brightblue]computer_name@#(ip addr show dev ens7 | grep "inet[^6]" | awk '{print $2}')"
```
replace with your computer name (Update: this is not needed since I use $HOST), and proper network interface `ens7`.

### If you want to use zsh
3. sudo vim /etc/shells, and add `/home/YOUR_USER_NAME/.nix-profile/bin/zsh` to the end.
4. chsh
5. Enter `/home/YOUR_USER_NAME/.nix-profile/bin/zsh`, and log out.

### TODO
1. VSCode. Put some settings in `/home/YOUR_USER_NAME/.vscode-server/data/Machine/settings.json`
