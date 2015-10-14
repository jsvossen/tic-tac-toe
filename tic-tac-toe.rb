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

	#row winning condition
	def row_winner
		win = nil
		@@board.each do |row| 
			@@players.each do |player|
				winner = player if row.all? { |m| m == player.mark }
				break if win
			end
		end
		win
	end

	#column winning condition
	def column_winner
		win = nil
		@@board.size.times do |col|
			column = []
			@@board.size.times do |row|
				column << @@board[row][col].to_s
			end
			@@players.each do |player|
				win = player if column.all? { |m| m == player.mark }
				break if win
			end
		end
		win
	end

	#diag right (1,1 2,2 3,3) condition
	def diag_right_winner
		win = nil
		# @@board.size.times do |col|
		# 	diag = []
		# 	@@board.size.times do |row|
		# 		diag << @@board[row+col][col].to_s if row+col < @@board.size
		# 	end
		# 	@@players.each do |player|
		# 		win = player if diag.all? { |m| m == player.mark }
		# 		break if win
		# 	end
		# end
		@@players.each do |player|
			win = player if [@@board[0][0],@@board[1][1],@@board[2][2]].all? { |m| m == player.mark }
			break if win
		end
		win
	end

	def diag_left_winner
		win = nil
		@@players.each do |player|
			win = player if [@@board[0][2], @@board[1][1], @@board[2][0]].all? { |m| m == player.mark }
			break if win
		end
		win
	end

	def winner
		row_winner || column_winner || diag_left_winner || diag_right_winner
	end

	def is_draw?
		board_full? && !winner
	end

	#check if board is filled
	def board_full?
		!@@board.any? { |row| row.include?(" ") }
	end

	def game_over?
		board_full? || winner
	end

	#get moves from players until game is done
	def play
		until game_over? do
			@@players.each do |player|

				break if game_over?
				draw_board

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
		draw_board
		puts is_draw? ? "It's a draw!" : "The winner is: #{winner.name}!"
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