class RouletteGame
  RED_NUMBERS = [1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36]
  BLACK_NUMBERS = [2,4,6,8,10,11,13,15,17,20,22,24,26,28,29,31,33,35]
  attr_accessor :balance

  def initialize
    @balance = 0
    puts "🎰 Welcome to Full Ruby Roulette!"
  end

  def play
    loop do
      puts "\n💰 Balance: $#{@balance}"
      puts "Choose your bet type:"
      puts "1. Straight Number (35:1)"
      puts "2. Split (17:1)"
      puts "3. Street (11:1)"
      puts "4. Corner (8:1)"
      puts "5. Line (5:1)"
      puts "6. Dozen (2:1)"
      puts "7. Column (2:1)"
      puts "8. Red/Black (1:1)"
      puts "9. Odd/Even (1:1)"
      puts "10. Low/High (1:1)"
      puts "11. Quit"
      print "Your choice: "
      begin
        case Integer(gets.chomp)
        when 1 then straight
        when 2 then split
        when 3 then street
        when 4 then corner
        when 5 then line
        when 6 then dozen
        when 7 then column
        when 8 then red_black
        when 9 then odd_even
        when 10 then low_high
        when 11 then break
        else puts "❌ Invalid choice"
        end
      rescue
        puts "❌ Invalid input, please enter a number."
      end
    end
    puts "👋 Thanks for playing!"
  end

  def get_amount
    print "💵 Bet amount: $"
    begin
      amount = Integer(gets.chomp)
      return nil unless amount > 0 && amount <= @balance
      amount
    rescue
      puts "❌ Invalid amount."
      nil
    end
  end

  def spin
    rand(0..36)
  end

  def update_balance(won, amount, multiplier)
    if won
      win = amount * multiplier
      @balance += win
      puts "🎉 You won $#{win}!"
    else
      @balance -= amount
      puts "💸 You lost!"
    end
  end

  def straight
    print "🎯 Pick a number (0–36): "
    begin
      num = Integer(gets.chomp)
      amount = get_amount
      return unless amount
      result = spin
      puts "🎡 Result: #{result}"
      update_balance(result == num, amount, 35)
    rescue
      puts "❌ Invalid number."
    end
  end

  def split
    print "🎯 Enter two numbers (space-separated): "
    begin
      a, b = gets.chomp.split.map { |n| Integer(n) }
      amount = get_amount
      return unless amount
      result = spin
      puts "🎡 Result: #{result}"
      update_balance([a, b].include?(result), amount, 17)
    rescue
      puts "❌ Invalid input. Please enter two numbers."
    end
  end

  def street
    print "🏠 Enter starting number of street (e.g. 1,4,...34): "
    begin
      start = Integer(gets.chomp)
      street = [start, start + 1, start + 2]
      amount = get_amount
      return unless amount
      result = spin
      puts "🎡 Result: #{result}"
      update_balance(street.include?(result), amount, 11)
    rescue
      puts "❌ Invalid input."
    end
  end

  def corner
    print "🧱 Enter top-left number of 2x2 block: "
    begin
      start = Integer(gets.chomp)
      corner = [start, start + 1, start + 3, start + 4]
      amount = get_amount
      return unless amount
      result = spin
      puts "🎡 Result: #{result}"
      update_balance(corner.include?(result), amount, 8)
    rescue
      puts "❌ Invalid input."
    end
  end

  def line
    print "📏 Enter starting number of first row: "
    begin
      start = Integer(gets.chomp)
      line = [start, start + 1, start + 2, start + 3, start + 4, start + 5]
      amount = get_amount
      return unless amount
      result = spin
      puts "🎡 Result: #{result}"
      update_balance(line.include?(result), amount, 5)
    rescue
      puts "❌ Invalid input."
    end
  end

  def dozen
    print "📦 Choose Dozen: 1 (1–12), 2 (13–24), 3 (25–36): "
    begin
      choice = Integer(gets.chomp)
      range = case choice
              when 1 then 1..12
              when 2 then 13..24
              when 3 then 25..36
              else []
              end
      amount = get_amount
      return unless amount
      result = spin
      puts "🎡 Result: #{result}"
      update_balance(range.include?(result), amount, 2)
    rescue
      puts "❌ Invalid input."
    end
  end

  def column
    print "🧮 Pick column: 1, 2, or 3: "
    begin
      col = Integer(gets.chomp)
      numbers = (1..36).select { |n| (n - col) % 3 == 0 }
      amount = get_amount
      return unless amount
      result = spin
      puts "🎡 Result: #{result}"
      update_balance(numbers.include?(result), amount, 2)
    rescue
      puts "❌ Invalid input."
    end
  end

  def red_black
    print "🔴⚫ Choose color (r/b): "
    color = gets.chomp.downcase
    amount = get_amount
    return unless amount
    result = spin
    actual = RED_NUMBERS.include?(result) ? "r" : BLACK_NUMBERS.include?(result) ? "b" : "g"
    puts "🎡 Result: #{result} (#{actual == 'r' ? 'Red' : actual == 'b' ? 'Black' : 'Green'})"
    update_balance(color == actual, amount, 1)
  end

  def odd_even
    print "🧮 Choose (o)dd or (e)ven: "
    choice = gets.chomp.downcase
    amount = get_amount
    return unless amount
    result = spin
    match = result != 0 && ((result.odd? && choice == "o") || (result.even? && choice == "e"))
    puts "🎡 Result: #{result}"
    update_balance(match, amount, 1)
  end

  def low_high
    print "📉📈 Choose (l)ow (1–18) or (h)igh (19–36): "
    choice = gets.chomp.downcase
    amount = get_amount
    return unless amount
    result = spin
    match = (choice == "l" && result.between?(1,18)) || (choice == "h" && result.between?(19,36))
    puts "🎡 Result: #{result}"
    update_balance(match, amount, 1)
  end
end
