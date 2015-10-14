class TicTacToe

	@@board = [[" "," "," "],[" "," "," "],[" "," "," "]]
	@@players = []

	#init game with two players, X and O
	def initialize(player_x = "Player 1", player_o = "Player 2")
		@@players << @player_x = Player.new(player_x, "X")
		@@players << @player_o = Player.new(player_o, "O")
		play
	end

	#draw the board grid
	def draw_board
		puts "    1   2   3"
		puts "  |-----------|"
		puts "1 | #{@@board[0][0]} | #{@@board[0][1]} | #{@@board[0][2]} |"
		puts "  |-----------|"
		puts "2 | #{@@board[1][0]} | #{@@board[1][1]} | #{@@board[1][2]} |"
		puts "  |-----------|"
		puts "3 | #{@@board[2][0]} | #{@@board[2][1]} | #{@@board[2][2]} |"
		puts "  |-----------|"
	end

	def row_winner
		winner = nil
		@@board.each do |row| 
			@@players.each do |player|
				winner = player if row.all? { |m| m == player.mark }
				break if !winner.nil?
			end
		end
		winner
	end

	# def column_winner
	# 	winner = nil
	# 	@@board.each do |row|
	# 		row.each do |col| 
	# 			@@players.each do |player|
	# 				winner = player if row.all? { |m| m == player.mark }
	# 				break if !winner.nil?
	# 			end
	# 		end
	# 	end
	# 	winner
	# end

	# def diag_right_winner
	# 	[@@board[0][0], @@board[1][1], @@board[2][2]]
	# end

	# def diag_left_winner
	# 	[@@board[0][2], @@board[1][1], @@board[2][0]]
	# end

	#check if board is filled
	 def game_over?
	 	!@@board.any? { |row| row.include?(" ") } || !row_winner.nil?
	 end

	#get moves from players until game is done
	def play
		puts row_winner
		until game_over? do
			@@players.each do |player|

				draw_board
				break if game_over?

				puts "#{player.name}'s turn:"
				move = gets.chomp

				until valid_entry?(move) && valid_move?(move) do			
					puts "Invalid coordinates. Try again:" if !valid_entry?(move)
					puts "You can't move there. Try again:" if valid_entry?(move) && !valid_move?(move)
					move = gets.chomp
				end

				move = move.split(",").collect! { |i| i.to_i-1 }
				@@board[move[0]][move[1]] = player.mark
				
			end
		end
		puts "Game Over!"
		@@board.each { |row| puts row_winner.name if !row_winner.nil? }
	end

	#check if input is valid coordinates
	def valid_entry?(move)
		move.match('^[1-3],[1-3]$')
	end

	#check if coordinates are open
	def valid_move?(move)
		move = move.split(",").collect! { |i| i.to_i-1 }
		@@board[move[0]][move[1]] == " "
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