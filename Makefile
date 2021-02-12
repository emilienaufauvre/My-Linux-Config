.PHONY: bash vim theme gnome packages 

all: init bash vim theme gnome packages end

####################################################################################################

init:

	@echo ------------------------------------------------------------------------------------------
	@echo - Starting the setup ---------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------

	# Enabling universe repo setting...
	@add-apt-repository universe
	
	# Cleaning Vim...
	@rm -f -r ~/.vim

	# CLeaning themes...
	@rm -f -r ~/.themes

	# Cleanin Gnome...
	@rm -f -r ~/.local/share/gnome-shell/extensions

####################################################################################################

bash:

	@echo ------------------------------------------------------------------------------------------
	@echo - Bash -----------------------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------
	
	# Runcom file...
	@cp bash/.bashrc ~/.bashrc
	@cp bash/.bash_aliases ~/.bash_aliases
	@cp bash/.bash_colors ~/.bash_colors
	@cp bash/.bash_xserver ~/.bash_xserver

####################################################################################################

vim:

	@echo ------------------------------------------------------------------------------------------
	@echo - Vim ------------------------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------

	# Vim.
	@apt install vim
		
	# Runcom file...
	@cp vim/.vimrc ~/.vimrc

	# Xclip...
	@apt install xclip
	
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

theme:

	@echo ------------------------------------------------------------------------------------------
	@echo - Theme ----------------------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------

	# OSX-Arc app theme:
	@mkdir -p ~/.themes
	# - Gnome standard themes...
	@apt install gnome-themes-standard
	# - Murrine engine...
	@apt install gtk2-engines-murrine
	# - Get the theme...
	@wget https://github.com/thiagolucio/OSX-Arc-Shadow/archive/master.zip 
	@unzip master.zip 
	@mv OSX-Arc-Shadow-master ~/.themes/OSX-Arc-Shadow
	@rm master.zip
	
	# Numix cirles icones:
	# - Add the repo...
	@add-apt-repository ppa:numix/ppa
	@apt update
	# - Install the package...
	@apt install numix-icon-theme-circle

	# Gnome shell...
	# @cp -r themes/arc-mod ~/.themes/
	# @cp -r themes/arc-dark-mod ~/.themes/
	
####################################################################################################

gnome:

	@echo ------------------------------------------------------------------------------------------
	@echo - Gnome extension ------------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------

	# Installing the gnome extensions:
	# - User themes...
	./utils.sh extract_gnome_extension \
		gnome/user-themegnome-shell-extensions.gcampax.github.com.v42.shell-extension
	# - Battery circular indicator...
	./utils.sh extract_gnome_extension \
		gnome/circular-battery-indicator@tannick.io.v1.shell-extension 
	# - Dynamic panel transparency...
	./utils.sh extract_gnome_extension \
		gnome/dynamic-panel-transparencyrockon999.github.io.v34.shell-extension
	# - No annoyance...
	./utils.sh extract_gnome_extension \
		gnome/noannoyancesindex.com.v4.shell-extension
	# - Net speed...
	./utils.sh extract_gnome_extension \
		gnome/simplenetspeedbiji.extension.v20.shell-extension
	# - Night light slider...
	./utils.sh extract_gnome_extension \
		gnome/night-light-slider.timurlinux.com.v18.shell-extension
	# - Coverflow alt-tab...
	./utils.sh extract_gnome_extension \
		gnome/CoverflowAltTabpalatis.blogspot.com.v44.shell-extension

####################################################################################################

packages:

	@echo ------------------------------------------------------------------------------------------
	@echo - Packages -------------------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------

	# Gnome tweak tool...
	@apt install gnome-tweak-tool

####################################################################################################

end:

	@echo ------------------------------------------------------------------------------------------
	@echo - Setup finished -------------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------

	# Clean...
	@apt autoremove
