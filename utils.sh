#!/bin/bash

function extract_gnome_extension()
{
	# Get the UUID.
	UUID=$(unzip -c $1 metadata.json | grep uuid | cut -d \" -f4)
	# Create the extension directory.
	DIR=~/.local/share/gnome-shell/extensions/$UUID
	mkdir -p $DIR 
	# Unzip and move in this directory.
	unzip -q $1 -d $DIR	
	# Enable the "metadata.json".
	chmod 664 $DIR/metadata.json
	# Enable it.
	gnome-extensions enable $UUID
}

$*
