=begin
class Game
end
class Player
end
class Board
end

Game class will create a new board instance and player instance
Most logic will be as far down as possible, smart node style
=end

=begin
Game starts with welcome message
player selects where the ships should go
computer does the same in the background using random
the visual interface puts out what things look like
the player selects a place to hit
the looping code looks in the hash to see if the computer has a ship there
if so, that spot becomes a H for hit, if not it is a M for miss
#it would be cool if I could make an explosion using different letters in that spot
#it would be cool if there was different weapons
#theme?  Something with music?  Star Wars.  Night at the Roxbery.
when your ships are sunk the loop is over and the game ends

=end

#random number generator for shots
#hashes within arrays or hashes within hashes?  Nodes?
#start with a 2 x 2 board and ship size 1 to test
#make an algorithm to change board size based on user input
#ships with 2 or more spots must match letter or number of last placement
#multi class
