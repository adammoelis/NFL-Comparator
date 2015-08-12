# Function 

The Fantasy Football ranking app allows users to vote for their favorite players in a given position.

These votes will go towards ranking the top 5 players at each position, with the eventual goal of crowd-sourcing the most "popular" players to inform fantasy football drafting. 


# Gems

This app requires the following gems:

* require 'rest-client'
* require 'pry'
* require 'json'
* require 'PStore'
* require 'smart_colored/extend'
* require 'asciiart'

Pry is optional, but useful for debugging.

To retrieve player data, we used the [Fantasy Football Nerd API](http://www.fantasyfootballnerd.com/fantasy-football-api).

Data persistence is managed through [PStore](http://ruby-doc.org/stdlib-2.2.2/libdoc/pstore/rdoc/PStore.html).

[For information on converting images to ASCII art and running in Ruby](https://www.ruby-forum.com/topic/4418595) 

# Acknowledgements

Thanks to PStore, Fantasy Football Nerd, and also to the NFL for the sweet logo. 

