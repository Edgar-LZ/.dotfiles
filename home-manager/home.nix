{ lib, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "inx01";
  home.homeDirectory = "/home/inx01";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
  	pkgs.zathura
	pkgs.texlive.combined.scheme-medium
	pkgs.gruvbox-dark-gtk
  ];

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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/inx01/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
     EDITOR = "nvim";
  };


  programs.neovim = 
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
      enable = true;
      defaultEditor = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraLuaConfig = ''
      -- Write lua code here:

      -- or interpolate files like this:
      ${builtins.readFile ./nvim/options.lua}
      ${builtins.readFile ./nvim/remaps.lua}
      ${builtins.readFile ./nvim/plugin/telescope.lua}
      ${builtins.readFile ./nvim/plugin/treesitter.lua}
      ${builtins.readFile ./nvim/plugin/vimtex.lua}
      '';

     plugins = with pkgs.vimPlugins; [
	telescope-nvim
	telescope-fzf-native-nvim
	vimtex
	gruvbox-nvim

	# tree-sitter
	(nvim-treesitter.withPlugins (p: [
	  p.tree-sitter-nix
	  p.tree-sitter-vim
	  p.tree-sitter-bash
	  p.tree-sitter-lua
	  p.tree-sitter-python
	  p.tree-sitter-cpp
	  p.tree-sitter-c
	  p.tree-sitter-vimdoc
	]))
     ];
    };

    programs.kitty.enable = true;

    gtk = {
	enable = true;
	theme = {
		name = "gruvbox-dark";
		package = pkgs.gruvbox-dark-gtk;
	};
    };

    home.file.".config/gtk-3.0/gtk.css".source = "${pkgs.gruvbox-dark-gtk}/share/themes/gruvbox-dark/gtk-3.0/gtk.css";

    programs.kitty.settings = {
    	
	confirm_os_window_close  = 0;

	cursor = "#928374";
	cursor_text_color = "background";
	url_color = "#83a598";
	visual_bell_color = "#8ec07c";
	bell_border_color = "#8ec07c";

	active_border_color = "#d3869b";
	inactive_border_color = "#665c54";

	foreground = "#ebdbb2";
	background = "#282828";
	selection_foreground = "#928374";
	selection_background = "#ebdbb2";

	active_tab_foreground = "#fbf1c7";
	active_tab_background = "#665c54";
	inactive_tab_foreground = "#a89984";
	inactive_tab_background = "#3c3836";

	# black  (bg3/bg4)
	color0 = "#665c54";
	color8 = "#7c6f64";

	# red
	color1 = "#cc241d";
	color9 = "#fb4934";

	#: green
	color2 = "#98971a";
	color10 = "#b8bb26";

	# yellow
	color3 = "#d79921";
	color11 = "#fabd2f";

	# blue
	color4 = "#458588";
	color12 = "#83a598";

	# purple
	color5 = "#b16286";
	color13 = "#d3869b";

	# aqua
	color6 = "#689d6a";
	color14 = "#8ec07c";

	# white (fg4/fg3)
	color7 = "#a89984";
	color15 = "#bdae93";
    };

    programs.git = {
      enable = true;
      userName = "USER";
      userEmail = "MAIL";
    };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
