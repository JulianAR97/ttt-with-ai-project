module Players 

    class Computer < Player 
        
        def move(board)
            try_move = (1..9).to_a.sample
            board.valid_move?(try_move) ? try_move.to_s : self.move(board)
        end   
    end
end 
# require './config/environment'
# b1 = Board.new
# b1.cells = ['O', 'X', 'O', ' ', 'X', 'O', 'X', 'O', ' ']
# cpu = Players::Computer.new('O')