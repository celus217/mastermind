class Game
  attr_reader :code

  def initialize
    @code = [rand(1..9), rand(1..9), rand(1..9), rand(1..9)].join
  end

  def play
    puts 'Welcome to Mastermind! A 4 digit code will be generated, with numbers 1-9, both included. Inputting a 0 or text will terminate the program. You have 12 tries to guess the code. Good luck!'
    tries = 12
    loop do
      guess = gets.chomp
      break if guess.to_i.zero?

      result = check(guess)
      break if result == 'Win'

      unless result
        puts 'Incorrect input!'
        next
      end
      tries -= 1
      puts "You have #{result[0]} correct digits in the correct place, and #{result[1]} correct digits in an incorrect place. You have #{tries} tries left."
      if tries <= 0
        puts 'You ran out of tries. You lose!'
        break
      end
    end
  end

  def check(player_guess)
    return false unless valid?(player_guess)

    if player_guess == @code
      puts 'You win!'
      return 'Win'
    end
    guess_array = player_guess.split('')
    code_array = @code.split('')
    red = [0, 1, 2, 3].reduce(0) do |in_common, i|
      in_common += 1 if guess_array[i] == code_array[i]
      in_common
    end
    white = (guess_array & code_array).length - red
    [red, white]
  end

  def valid?(input)
    input_array = input.split('')
    input_array.all? { |value| integer?(value) } && input_array.length == 4
  end

  def integer?(value)
    value.to_i.to_s == value
  end
end

Game.new.play
