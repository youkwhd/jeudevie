module Jeudevie
  module Cell
    DEAD = 0
    ALIVE = 1

    def Cell.print_cell(cell)
      print (cell == ALIVE ? "#" : ".")
    end
  end
end
