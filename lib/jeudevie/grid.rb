require "jeudevie/cell"

module Jeudevie
  class Grid
    @grid = nil
    @rows = 0
    @cols = 0

    def initialize(rows, cols)
      @rows = rows
      @cols = cols
      @grid = Array.new(@cols) {Array.new(@rows, Jeudevie::Cell::DEAD)}
    end

    def print()
      for cols in @grid do
        for row in cols do
          Jeudevie::Cell::print_cell(row)
        end

        puts ""
      end
    end

    def set_cell(row, col, cell)
      @grid[col][row] = cell
    end

    def each_neighbors(row, col, &block)
      for i in 0...3 do
        _row = (row - 1) + i
        _col = col - 1

        if (_row >= 0 and _row < @rows) and _col >= 0
          yield @grid[_col][_row]
        end
      end

      if (row - 1) >= 0
        yield @grid[col][row - 1]
      end

      if (row + 1) < @rows
        yield @grid[col][row + 1]
      end

      for i in 0...3 do
        _row = (row - 1) + i
        _col = col + 1

        if (_row >= 0 and _row < @rows) and _col < @cols
          yield @grid[_col][_row]
        end
      end
    end

    def alive_neighbors_count(row, col)
      count = 0

      each_neighbors(row, col) { |neighbor|
        if neighbor == Jeudevie::Cell::ALIVE
          count += 1
        end
      }

      return count
    end
  end
end
