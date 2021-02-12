####################################################################################################
# "sudo" is used for each line requiring it, because:	                                           #
# - using "sudo -E make" will interfere with the "dconf" settings (i.e we can't execute the entire #
#   makefile in super user mode, because these command can't be run as root),                      #
# - and using "sudo -u <user>" before the "dcond" commands to force the normal user mode will not  #
#   work (because some specific settings will not be overwritten).                                 #
# If you still want to use "sudo -E make", "dconf" warnings could appear but the gnome extensions  #
# and themes will be at least installed. In this case you will have to enable them manually with   #
# the gnome tweak tool, or inside the shell as a normal user.                                      #
# Also executing "sudo make" without the "-E" option will install the set-up for the super user    #
# mode because of the environment variables used in these script.                                  #
####################################################################################################

.PHONY: bash vim package gnome theme 

all: init bash vim package gnome theme end

####################################################################################################

init:

	@echo ------------------------------------------------------------------------------------------
	@echo - Starting the setup ---------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------

	# Enabling universe repo setting...
	@sudo add-apt-repository universe
	
	# Cleaning Vim...
	@sudo rm -f -r ~/.vim

	# CLeaning themes...
	@sudo rm -f -r ~/.themes

	# Cleanin Gnome...
	@sudo rm -f -r ~/.local/share/gnome-shell/extensions

####################################################################################################

bash:

	@echo ------------------------------------------------------------------------------------------
	@echo - Bash -----------------------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------
	
	# Runcom file...
	@sudo cp bash/.bashrc ~/.bashrc
	@sudo cp bash/.bash_aliases ~/.bash_aliases
	@sudo cp bash/.bash_colors ~/.bash_colors
	@sudo cp bash/.bash_xserver ~/.bash_xserver

####################################################################################################

vim:

	@echo ------------------------------------------------------------------------------------------
	@echo - Vim ------------------------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------

	# Runcom file...
	@sudo cp vim/.vimrc ~/.vimrc

	# Xclip...
	@sudo apt install xclip
	
	# Plugins:	
	# - Pathogen...
	@mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
	# -- Nerdtree...
	@git clone https://github.com/preservim/nerdtree.git ~/.vim/bundle/nerdtree
	# -- Airline...
	@git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
	# -- Syntastic...
	@git clone https://github.com/vim-syntastic/syntastic.git ~/.vim/bundle/syntastic
	# -- Neocomplete...
	@git clone https://github.com/shougo/neocomplete.vim ~/.vim/bundle/neocomplete.vim
	# -- Gruvbox (theme)...
	@git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox
	
####################################################################################################

gnome:

	@echo ------------------------------------------------------------------------------------------
	@echo - Gnome extension ------------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------

	# Installing the gnome extensions:
	# - User themes...
	@./utils.sh extract_gnome_extension \
		gnome/user-themegnome-shell-extensions.gcampax.github.com.v42.shell-extension
	# - Battery circular indicator...
	@./utils.sh extract_gnome_extension \
		gnome/circular-battery-indicator@tannick.io.v1.shell-extension 
	# - Net speed...
	@./utils.sh extract_gnome_extension \
		gnome/simplenetspeedbiji.extension.v20.shell-extension
	# - No annoyance...
	@./utils.sh extract_gnome_extension \
		gnome/noannoyancesindex.com.v4.shell-extension
	# - Night light slider...
	@./utils.sh extract_gnome_extension \
		gnome/night-light-slider.timurlinux.com.v18.shell-extension
	# - Coverflow alt-tab...
	@./utils.sh extract_gnome_extension \
		gnome/CoverflowAltTabpalatis.blogspot.com.v44.shell-extension

	# Add user theme schema for gnome shell theme...
	@sudo cp ~/.local/share/gnome-shell/extensions/user-theme@gnome-shell-extensions\
	.gcampax.github.com/schemas/org.gnome.shell.extensions.user-theme.gschema.xml \
		/usr/share/glib-2.0/schemas
	@sudo glib-compile-schemas /usr/share/glib-2.0/schemas

####################################################################################################

theme:

	@echo ------------------------------------------------------------------------------------------
	@echo - Theme ----------------------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------

	# OSX-Arc app theme:
	# - Creating the directory...
	@sudo mkdir -p ~/.themes
	# - Gnome standard themes (necessary)...
	@sudo apt install gnome-themes-standard
	# - Murrine engine (necessary)...
	@sudo apt install gtk2-engines-murrine
	# - Get the theme...
	@wget https://github.com/thiagolucio/OSX-Arc-Shadow/archive/master.zip 
	@unzip master.zip 
	@sudo mv OSX-Arc-Shadow-master ~/.themes/OSX-Arc-Shadow
	@rm master.zip
	# - Enable it...
	@gsettings set org.gnome.desktop.interface gtk-theme OSX-Arc-Shadow

	# Numix cirles icones:
	# - Add the repo...
	@sudo add-apt-repository ppa:numix/ppa
	@sudo apt update
	# - Install the package...
	@sudo apt install numix-icon-theme-circle
	# - Enable it...
	@gsettings set org.gnome.desktop.interface icon-theme Numix-Circle

	# Gnome shell...
	@gsettings set org.gnome.shell.extensions.user-theme name OSX-Arc-Shadow 

####################################################################################################

packages:

	@echo ------------------------------------------------------------------------------------------
	@echo - Packages -------------------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------

	# Vim...
	@sudo apt install vim

	# Gnome tweak tool...
	@sudo apt install gnome-tweak-tool

####################################################################################################

end:

	@echo ------------------------------------------------------------------------------------------
	@echo - Setup finished -------------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------

	# Clean...
	@sudo apt autoremove
