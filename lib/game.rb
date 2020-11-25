class Game 
    attr_accessor :board, :player_1, :player_2
    
    WIN_COMBINATIONS = [
        [0, 1, 2], #Top Row
        [3, 4, 5], #Middle Row
        [6, 7, 8], #Bottom Row
        [0, 3, 6], #Left Column
        [1, 4, 7], #Middle Column
        [2, 5, 8], #Right Column
        [0, 4, 8], #Top Left to Bottom Right Diagonal
        [2, 4, 6] #Top Right to Bottom Left Diagonal
    ]

    def initialize(player_1 = Players::Human.new('X'), player_2 = Players::Human.new('O'), board = Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board 
    end 

    def current_player 
        self.board.turn_count % 2 == 0 ? self.player_1 : self.player_2
    end 

    def won? 
        WIN_COMBINATIONS.each do |combination|
            board_combination = combination.map {|index| self.board.cells[index]}
            
            if board_combination.include?(" ") || board_combination.uniq.size != 1
                next
            else 
                return combination
            end
        end
        false
    end 

    def draw? 
        !(self.won? || !self.board.full?)
    end 

    def over? 
        self.draw? || self.won?
    end 

    def winner 
        if self.won?
            self.board.cells.count {|t| t == 'X'} > self.board.cells.count {|t| t == 'O'} ? 'X' : 'O'
        end 
    end 

    def turn 
        #current_player.move will evoke a gets call in Players::Human
        self.board.display
        move = self.current_player.move(self.board)
        self.board.valid_move?(move) ? self.board.update(move, self.current_player) : self.turn
    end 

    def play 
        while !self.over?
            self.turn 
        end 
        self.board.display
        self.won? ? puts("Congratulations #{self.winner}!") : puts("Cat's Game!")
        
    end 

    def self.start 
        puts 'Hello, and welcome to Tic-Tac-Toe'
        puts "What kind of game would you like to play? \n1. CPU vs CPU \n2. Player vs CPU\n3. Player vs Player\n"
        game_type = gets.strip
        self.start unless '123'.include?(game_type)

        if game_type == '1' 
            game = self.new(Players::Computer.new('X'), Players::Computer.new('O'))
        
        elsif game_type == '2'
            puts "Who should go first?\n1. Player\n2. CPU"
          
            p1 = gets.strip
            while !'12'.include?(p1)
                p1 = gets.strip
            end 

            p1 == '1' ? game = self.new(Players::Human.new('X'), Players::Computer.new('O')) : game = self.new(Players::Computer.new('X'))
        else 
            game = self.new
        end 

        game.play
    end 

end



