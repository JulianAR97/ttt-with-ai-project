class Board
    attr_accessor :cells 

    def initialize 
        @cells = Array.new(9, ' ')
    end 

    def reset!
        @cells = Array.new(9, ' ')
    end

    def display
        rep_w_pos = []
        self.cells.each_with_index do |e, i|
            e == ' '? rep_w_pos << i + 1 : rep_w_pos << e 
        end 

        puts " #{rep_w_pos[0]} | #{rep_w_pos[1]} | #{rep_w_pos[2]} "
        puts "------------"
        puts " #{rep_w_pos[3]} | #{rep_w_pos[4]} | #{rep_w_pos[5]} "
        puts "------------"
        puts " #{rep_w_pos[6]} | #{rep_w_pos[7]} | #{rep_w_pos[8]} "
        puts ""
    end

    def position(num)
        self.cells[num.to_i - 1]
    end 

    def full? 
        !self.cells.include?(' ')
    end 

    def turn_count 
        self.cells.select {|ele| ele != ' '}.size
    end 

    # num_to_i - 1 bc num argument is a string, and board position 1 is array position 0.  Semantics, funny, huh?
    def taken?(num)
        self.cells[num.to_i - 1] != ' '
    end 

    def valid_move?(input)
        int = input.to_i
        1 <= int && int <= 9 && !taken?(int)
    end 

    def update(position, player)
        self.cells[position.to_i - 1] = player.token
    end 
end 