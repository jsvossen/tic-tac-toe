class TicTacToe

	attr_reader :players, :board

	#init game with two players, X and O
	def initialize(player_1 = "Player 1", player_2 = "Player 2")
		@board = []
		@players = []
		@players << Player.new(player_1, "X")
		@players << Player.new(player_2, "O")
		play
	end

	def clean_board
		@board = [[" "," "," "],[" "," "," "],[" "," "," "]]
	end

	#draw the board grid
	def draw_board
		puts "    1   2   3"
		puts "  |-----------|"
		puts "1 | #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} |"
		puts "  |-----------|"
		puts "2 | #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} |"
		puts "  |-----------|"
		puts "3 | #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |"
		puts "  |-----------|"
	end

	#row winning condition
	def row_winner
		win = nil
		@board.each do |row| 
			@players.each do |player|
				win = player if row.all? { |m| m == player.mark }
				break if win
			end
		end
		win
	end

	#column winning condition
	def column_winner
		win = nil
		@board.size.times do |col|
			column = []
			@board.size.times do |row|
				column << @board[row][col].to_s
			end
			@players.each do |player|
				win = player if column.all? { |m| m == player.mark }
				break if win
			end
		end
		win
	end

	#diag right (1,1 2,2 3,3) condition
	def diag_right_winner
		win = nil
		@players.each do |player|
			win = player if [@board[0][0],@board[1][1],@board[2][2]].all? { |m| m == player.mark }
			break if win
		end
		win
	end

	#diag left (1,3 2,2 3,1) condition
	def diag_left_winner
		win = nil
		@players.each do |player|
			win = player if [@board[0][2], @board[1][1], @board[2][0]].all? { |m| m == player.mark }
			break if win
		end
		win
	end

	#check possible winning conditions
	def winner
		row_winner || column_winner || diag_left_winner || diag_right_winner
	end

	#is the board full but no winner?
	def is_draw?
		board_full? && !winner
	end

	#check if board is filled
	def board_full?
		!@board.any? { |row| row.include?(" ") }
	end

	#game ends if the board is full or if someone wins
	def game_over?
		board_full? || winner
	end

	#get moves from players until game is done
	def play
		clean_board
		until game_over? do
			@players.each do |player|

				break if game_over?
				draw_board

				puts "#{player.name}'s turn:"
				move = gets.chomp

				#validate input
				until valid_entry?(move) && valid_move?(move) do			
					puts "Invalid coordinates. Try again:" if !valid_entry?(move)
					puts "You can't move there. Try again:" if valid_entry?(move) && !valid_move?(move)
					move = gets.chomp
				end

				move = move.split(",").collect! { |i| i.to_i-1 }
				@board[move[0]][move[1]] = player.mark
				
			end
		end
		draw_board
		puts is_draw? ? "It's a draw!" : "The winner is: #{winner.name}!"
		play_again_check
	end

	#check if input is valid coordinates
	def valid_entry?(move)
		move.match('^[1-3],[1-3]$')
	end

	#check if coordinates are open
	def valid_move?(move)
		move = move.split(",").collect! { |i| i.to_i-1 }
		@board[move[0]][move[1]] == " "
	end

	#option to swap players and play again
	def play_again_check
		puts "Would you like to play again?"
		input = gets.chomp.downcase
		if input != "no" && input != "n"
			if input == "yes" || input == "y"
				@players.reverse!
				play
			else
				puts "Respond yes or no"
				play_again_check
			end
		end
	end

	#player object
	class Player
		attr_accessor :name
		attr_reader :mark
		def initialize(name,mark)
			@name = name
			@mark = mark
		end
	end

end