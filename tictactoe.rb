#Things left to do
# Better opponent
# Better prediction of draws and wins
# Better formatting
class TicTacToe #contains all the methods and definitions for the gam
  def initialize #startup the game
    puts "Welcome to TicTacToe"
    puts "h - for 2P game"
    puts "c - for cpu"
    puts "q to quit, r to reset game"

    @x = [0,0,0,0,0,0,0,0,0] #index for marking which entries have been filled up, X -> 1, O ->-1, vacant ->0
    @table = ["1","2","3","4","5","6","7","8","9"] #string array for display purposes
    @status = -1 #-1 for startup 0 for ongoing, 1 for a win, 2 for a draw
    @gmode = 0 #1 for against cpu, 0 for 2 player
    master
  end
  #master controller of the whole game
  # => check which game mode has been selected
  # => cycles through steps and display of table till match ends/draws
  # => can also reset/quit game
  def master
    while @status == -1 #implies game mode not selected yet
      pl_choice = gets.chomp.downcase
      case pl_choice
      when "q"
        exit
      when "r"
        initialize
      when "c"
        @status = 0
        @gmode = 1
      when "h"
        @status = 0
        @gmode = 0
      else
        puts "Invalid entry"
      end
    end

    display

    move_no = 0 #this will help in keeping track of who is making the current turn

    while @status == 0 #implies ongoing game
      if move_no % 2 == 0
        puts "X moves, enter no. between 1-9"
        step(1)
        status(1)
      else
        puts "O moves, enter no. between 1-9" if @gmode == 0 #for O's move, choose between CPU or human input
        step(-1)
        status(-1)
      end
      display
      move_no += 1
    end

    if @status == 1 #depending of status output send appropriate message
      puts move_no%2 == 0 ? "O wins" : "X wins"
    elsif @status == 2
      puts "Match is a Draw"
    end
    puts ""
    initialize
  end

  def display #draws the table on the terminal
    puts ""
    puts "#{@table[0]}|#{@table[1]}|#{@table[2]}".center(50)
    puts "------".center(50)
    puts "#{@table[3]}|#{@table[4]}|#{@table[5]}".center(50)
    puts "------".center(50)
    puts "#{@table[6]}|#{@table[7]}|#{@table[8]}".center(50)
    puts ""
  end

  def naive_op #naive approach for cpu player. randomly selects an open slot on the table
    unfilled = false
    until unfilled
      x = Random.rand(1..9)
      if @x[x-1] == 0
        return x
        unfilled = true
      end
    end
  end

  def step(token) # transferes the move of the cpu/player to the table
    move_made = false #check to see if valid move has been made
    until move_made
      if @gmode*token == -1 #cryptic way to determine if in CPU mode AND o's turn
        move = naive_op
        puts "CPU chose slot #{move}"
        @table[move-1] = "O" #sets the appropriate slot to O
        @x[move-1] = token #sets the the @x array element to -1
        move_made = true
      else
        move = gets.chomp #gets Human player's move
        exit if move == "q" #see if the player decided to quit or restart
        initialize if move == "r"
        move = move.to_i
        if move > 9 || move < 1 #tell the player to choose between 1 and 9
          puts "Enter no. between 1 and 9"
        elsif @table[move-1] != move.to_s
          puts "slot already occupied"
        else
          @table[move-1] = (token == 1 ? "X" : "O") #sets the appropriate slot to X or O
          puts "Player chose slot #{move}"
          @x[move-1] = token
          move_made = true #valid move made, so exit the loop and step method
        end
      end
    end
  end

  def status(xno) #check the state of the game, determines if the match has been won or drawn yet
    #checking for rows,columns and diagonals. for O victory sum should be -3, hence 3*xno
    rows = [0,3,6]
    rows.each do |x|
      @status = 1 if @x[x]+@x[x+1]+@x[x+2] == 3*xno
    end
    columns = [0,1,2]
    columns.each do |x|
      @status = 1 if @x[x]+@x[x+3]+@x[x+6] == 3*xno
    end
    @status = 1 if @x[0]+@x[4]+@x[8] == 3*xno || @x[2]+@x[4]+@x[6] == 3*xno
    #check for draw
    @status = 2 if @status == 0 && @x.count(0) == 0
  end
end

t = TicTacToe.new #startup the game
