require "jeudevie/cell"

module Jeudevie
  class Grid
    @grid = nil

    def initialize(*args)
      if args.length == 1
        @grid = args[0]
      elsif args.length == 2
        @grid = Array.new(args[0]) {Array.new(args[0], Jeudevie::Cell::DEAD)}
      else
        raise ArgumentError, "No definition based of #{args.length} args"
      end
    end

    def cols()
      return @grid.length
    end

    def rows()
      return @grid[0].length
    end

    def get_cell(col, row)
      return @grid[col][row]
    end

    def println()
      for cols in @grid do
        for row in cols do
          Jeudevie::Cell::print_cell(row)
        end

        print "\n"
      end
    end

    def set_cell(col, row, cell)
      @grid[col][row] = cell
    end

    def each_neighbors(col, row, &block)
      for i in 0...3 do
        _row = ((row - 1) + i) % rows
        _col = (col - 1) % cols

        yield @grid[_col][_row], _col, _row
      end

      _row = (row - 1) % rows
      yield @grid[col][_row], col, _row

      _row = (row + 1) % rows
      yield @grid[col][_row], col, _row

      for i in 0...3 do
        _row = ((row - 1) + i) % rows
        _col = (col + 1) % cols

        yield @grid[_col][_row], _col, _row
      end
    end

    def alive_neighbors_count(col, row)
      count = 0

      each_neighbors(col, row) { |neighbor, col, row|
        if neighbor == Jeudevie::Cell::ALIVE
          count += 1
        end
      }

      return count
    end
  end
end
