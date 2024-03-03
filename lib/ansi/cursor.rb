module ANSI
  module Cursor
    def self.go_up(n)
      print "\x1b[#{n}A"
    end

    def self.go_down(n)
      print "\x1b[#{n}B"
    end

    def self.go_right(n)
      print "\x1b[#{n}C"
    end

    def self.go_left(n)
      print "\x1b[#{n}D"
    end

    def self.hide()
      print "\x1b[?25l"
    end

    def self.show()
      print "\x1b[?25h"
    end
  end
end
