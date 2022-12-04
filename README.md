# What is it?
Another one game made as test task for job vacancy.
This one is Match 3 game.

# How to launch
## On Linux
```
# lua ./main.lua [-c]
```
## On other systems
Move to directory with main.lua file and run lua interpreter with main.lua as
argument.

## -c option
This option tested on Linux and Window 7 (not works). Enables color mode.  
Try to use it if your system is Linux.

# How to play
Game rules same as in any Match3 game

# Ingame commands
Game uses commands input. There is 2 commands:  
## Swap 2 crystals
Choose first crystal with coords and second crystal with direction relative 
first crystal
```
> m <col> <row> <direction>
```
col - Column number. Valid values - 0..9  
row - Row number. Valid values - 0..9  
direction - Direction that choosed crystal must swap. Valid values - 'l', 'r', 
'u' and 'd'

* l - left
* r - right
* u - up
* d - down

## Quit game
```
> q
```  

# Copying
License - CC0