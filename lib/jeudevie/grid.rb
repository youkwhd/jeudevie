require "jeudevie/cell"

module Jeudevie
  class Grid
    @grid = nil
    @rows = 0
    @cols = 0

    def initialize(cols, rows)
      @rows = rows
      @cols = cols
      @grid = Array.new(@cols) {Array.new(@rows, Jeudevie::Cell::DEAD)}
    end

    def cols()
      return @cols
    end

    def rows()
      return @rows
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
        _row = ((row - 1) + i) % @rows
        _col = (col - 1) % @cols

        yield @grid[_col][_row], _col, _row
      end

      yield @grid[col][(row - 1) % @rows], col, (row - 1) % @rows
      yield @grid[col][(row + 1) % @rows], col, (row + 1) % @rows 

      for i in 0...3 do
        _row = ((row - 1) + i) % @rows
        _col = (col + 1) % @cols

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
