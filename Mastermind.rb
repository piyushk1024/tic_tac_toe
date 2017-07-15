# CCCC
# ABCD
# OOXO
# X
class Mastermind
  def initialize
    puts "Welcome to Mastermind"
    puts "Guess 4 letter secret code made up of letter ABCDEF"
    puts "You get 10 tries"
    puts "Correct guess @ correct position shows up as X"
    puts "Correct guess shows up as O"
    @ints = "ABCDEF".split("")
    @entry = []
    #generate secret code
    @code = []
    @results = ""
    (0..3).each do
      choice = @ints.sample
      @code.push(choice)
      #@ints.delete(choice)
    end
    #puts @code.join
    master #call up controller code
  end
  def input_validator
    valid_entry = false

    until valid_entry #make sure user has made correct entry
      @entry = gets.chomp.upcase.split("") #split up, capitalize and store input in an array
      if @entry.length != 4
        puts "Please enter 4 letter guess using ABCDEF" #show error message
      else
        valid_entry = true
        (0..3).each do |x|
          unless "ABCDEF".include?(@entry[x])
            valid_entry = false
            puts "Please use valid characters only"
            break
          end
        end
      end
    end

  end

  def master
    #setup game
    moves_left = 10
    score = 0 #declare outside so available throughout the master method
    until  moves_left == 0 || score == 4 #loop through till correct guess or all moves used
      score = 0 #reset score
      @entry = [] # reset user's entry
      #input validation
      input_validator

      entry_c = "#{@entry[0]}|#{@entry[1]}|#{@entry[2]}|#{@entry[3]}" #make a string copy of original entry
      puts entry_c #Shows user input to the user
      #score = 0
      exes = "" #store the all correct and partially correct guesses as X n o
      oos = "" #this makes sure that player x always appear first in the result display
      code_copy = @code.dup
      (0..3).each do |x|

        #puts "#{code_copy.join},#{@code.join}"
        if code_copy.include?(@entry[x])
          #clean_entry = @entry[x]
          index = 0
          (0..3).each {|y| index =  y if code_copy[y] == @entry[x] }

          if @entry[index] == code_copy[index]
            exes += "X"
            score += 1
            code_copy[index] = " "
          else
            oos += "O"
            code_copy[index] = " "
          end

          #(0..3).each {|z| @entry[z] = " " if @entry[z] == clean_entry} #to prevent duplicate matching, remove identical element
        end
      end

      @results = exes + oos #store x and o's and clear them
      exes = ""
      oos =""
      (1..(4-@results.length)).each {@results += " "} #make sure @results is of length 4 by padding spaces
      puts "#{entry_c} --> #{@results[0]}|#{@results[1]}|#{@results[2]}|#{@results[3]}" #display result of current move
      @results = "" #clear current result
      moves_left -= 1 #reduce moves_left and inform the player
      puts "Guesses left #{moves_left}"

    end

    if score == 4 #check for victory
      puts "You won"
    else
      puts "You lost, correct code was #{@code.join}"
    end

    exit

  end
end

t = Mastermind.new
