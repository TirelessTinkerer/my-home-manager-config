{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "zhiyuan-li";
  home.homeDirectory = "/home/zhiyuan-li";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.ripgrep
    pkgs.fd
    pkgs.emacs
    pkgs.tmux
    pkgs.tree
  ];

  home.file.".tmux.conf".source = ./tmux.conf;
  # home.file.".bashrc".source = ./my_bash_rc;
  # home.file.".config/nvim/init.vim".source = ./init.vim;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/zhiyuan-li/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
    " Enable filetype plugins
    filetype plugin on
    filetype indent on

    " Set to auto read when a file is changed from the outside
    set autoread
    au FocusGained,BufEnter * checktime

    " Configure backspace so it acts as it should act
    set backspace=eol,start,indent
    "set whichwrap+=<,>,h,l

    " Ignore case when searching
    "set ignorecase

    " When searching try to be smart about cases
    "set smartcase

    " Makes search act like search in modern browsers
    set incsearch

    " For regular expressions turn magic on
    "set magic

    " Show matching brackets when text indicator is over them
    set showmatch
    " How many tenths of a second to blink when matching brackets
    set mat=2

    " Enable syntax highlighting
    syntax enable

    " Set utf8 as standard encoding and en_US as the standard language
    set encoding=utf8

    " Use Unix as the standard file type
    set ffs=unix,dos,mac

    " Turn backup off, since most stuff is in SVN, git etc. anyway...
    set nobackup
    set nowritebackup
    set noswapfile

    " Use spaces instead of tabs
    set expandtab

    " Be smart when using tabs ;)
    "set smarttab

    " 1 tab == 4 spaces
    set shiftwidth=2
    set tabstop=2
    set softtabstop=2

    set autoindent "Auto indent
    set smartindent "Smart indent
    set wrap "Wrap lines

    " Return to last edit position when opening files (You want this!)
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    set number
    '';
  };
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    defaultKeymap = "emacs";
    initExtra = ''
    ### (work) Use shared storage to try and download pre-compiled object
    export DRIVING_BAZEL_REMOTE_CACHE=s3

    ### Prompt with color with git branch
    function git_branch_name()
    {
      branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
      if [[ $branch == "" ]];
      then
        :
      else
        echo ' %F{226}['$branch']%f'
      fi
    }
    setopt prompt_subst
    prompt='%F{39}Puget: %F{120}%~%f$(git_branch_name) \$ '

    ### ssh into tmux
    if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
      tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
    fi
    '';
    shellAliases = {
      ".."="cd ..";
      "..."="cd ../..";
      "...."="cd ../../..";
      ".2"="cd ../..";
      ".3"="cd ../../..";
      ".4"="cd ../../../..";
      ".5"="cd ../../../../..";
      ".6"="cd ../../../../../..";
      ls="ls --color=auto -F"
      ll="ls -lh --color=auto -F"  # Long format with human-readable file sizes
      la="ls -lha --color=auto -F" # Show all files, including hidden, in long format
      g="git";
      gs="git status";
      gls="git log --stat --full-diff";
      gd="git diff";
      vim="nvim";
      vi="nvim";
      xvsim="~/driving/bin/x_view --high-rate-ino-map";
      runsim="~/driving/src/tools/simian/local_cli_run.py";
      lazyvim="NVIM_APPNAME=lazyvim nvim";
    };
  };
}
