# frozen_string_literal: true

require_relative 'roulette'
class Game
  attr_reader :error_count, :result, :wager

  def initialize
    @error_count = 0
    @result = 0
    @randomizer = 0

    @game = RouletteGame.new
  end

  def deposit
    message = <<-STRING
        Minimum deposit to play this game
        is $10
    STRING
    puts message
    begin
      puts 'Enter an amount to deposit'
      input = Integer(gets.chomp)
      raise 'Invalid input ' if input.negative?
      raise 'A minimum deposit of $10 ' if input < 10 && @game.balance.zero?

      @game.balance += input
    rescue StandardError => e
      puts e.message
    end
  end

  def launch
    puts 'It will cost you  to play this game'
    unless @game.balance.positive?
      puts 'Insufficient balance'
      return
    end
    @game.play
    puts "Final result: #{@game.balance}"
  end

  def withdraw
    puts "Your current balance is #{result}"
    return if @result.zero?

    begin
      puts 'Withdrawal amount:'
      input = Integer(gets.chomp)

      if input > @result || (@result - input).negative?
        puts 'insufficient balance'
      else
        @game.balance -= input
        puts "Your current balance  is $#{@game.balance}"
        puts "Wait for the cash at the machine $#{input}"
      end
    rescue StandardError
      puts 'Invalid Input  your will be returned to the main menu'
    end
  end

  def reset
    @game.balance = 0
    @error_count = 0
    puts 'The result and error count have been reset.'
  end

  def results
    puts "Your errors made #{error_count} "
    puts "Your earnings made $#{@game.balance}"
  end

  def show_intro
    system('clear') || system('cls')
    puts <<~WELCOME
        #{'-' * 60}
        🎰  WELCOME TO...COUGAR ROULETTE
      #{' '}


       ░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓███████▓▒░░▒▓███████▓▒░#{'  '}
      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░#{' '}
      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░#{' '}
      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒▒▓███▓▒░▒▓████████▓▒░▒▓███████▓▒░ ░▒▓██████▓▒░#{'  '}
      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░#{'        '}
      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░#{'        '}
       ░▒▓██████▓▒░ ░▒▓██████▓▒░ ░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░#{' '}
      #{'                                                                                             '}
      #{'                                                                                             '}












        #{'-' * 60}
        💰 Bet smart. 🎯 Play hard. 🎡 Spin lucky.
        🔢 Numbers, colors, and odds are your weapons.

        📌 Minimum deposit: $10
      #{'  '}

        🎮 Good luck, player!
        #{'-' * 60}
    WELCOME
    sleep 1.5
  end
end

my_string = <<~STRING
  1. Play Game#{' '}
  2. Reset Results
  3. Display current results
  4. Withdraw Earnings
  5. Deposit#{' '}
  6. Quit#{' '}
STRING

game = Game.new
game.show_intro
game_running = ''
while game_running != 'q'
  puts my_string
  input = ''
  begin
    input = gets.chomp
    break if input == 'q'

    Integer(input)
  rescue ArgumentError => e
    puts "Invalid Input #{e.message}"
    next
  end

  case input
  when '1'
    game.launch

  when '2'
    game.reset
  when '3'
    game.results

    next
  when '6'
    puts 'Thank you  ...Best of luck '
    break
  when '4'
    game.withdraw
  when '5'
    game.deposit
  else
    puts 'Invalid input'
    next
  end

end
