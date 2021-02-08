.PHONY: bash vim packages 

all: init bash vim packages end

####################################################################################################

init:

	@echo ------------------------------------------------------------------------------------------
	@echo - Starting the setup ---------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------

	# Cleaning Vim...
	@rm -f -r ~/.vim

####################################################################################################

bash:

	@echo ------------------------------------------------------------------------------------------
	@echo - Bash -----------------------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------
	
	# Runcom file...
	@cp bash/.bashrc ~/.bashrc

####################################################################################################

vim:

	@echo ------------------------------------------------------------------------------------------
	@echo - Vim ------------------------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------
		
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

packages:

	@echo ------------------------------------------------------------------------------------------
	@echo - Packages -------------------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------

	# Nothing for now.

####################################################################################################

end:

	@echo ------------------------------------------------------------------------------------------
	@echo - Setup finished -------------------------------------------------------------------------
	@echo ------------------------------------------------------------------------------------------