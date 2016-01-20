# game-of-life
Conway's Game of Life in ncurses

## Summary

Given, a _rule_ and a _grid_:

1.  apply the rule to the grid to produce a new grid,
2.  use ncurses to display the new grid, and
3.  then wait a short period of time (e.g. 1/2 a second)

## Copyright

© 2016 [Powershop](http://www.powershop.co.nz/)

## Stack

The game will be written in Ruby, and will use the `ncurses-ruby` gem to
display the game in `ncurses` in a terminal window.

## Assumptions and limitations

1.  The _neighbourhood_ will be the Moore neighbourhood of a _cell_.
2.  The grid will not resize if the terminal window changes mid-game.
3.  The initial grid will be all off-pixels with one on-pixel in the centre.

## Glossary

* _cell_: a single pixel of the Game of Life, either on or off
* _grid_: a 2D matrix of cells, fit to the size of the terminal window
* _neighbourhood_: a 2D matrix around a cell, containing all cells which
  _might_ be able to influence the centre cell.
* _rule_: a set of transformations from neighbourhoods into cells for the next
  step of the game
