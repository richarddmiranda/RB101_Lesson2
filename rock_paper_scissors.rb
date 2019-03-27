VALID_CHOICES = ["r", "p", "sc", "l", "sp"]

WINNING_CONDITIONS = { "scissors" => ["paper", "lizard"],
                       "paper" => ["rock", "spock"],
                       "rock" => ["lizard", "scissors"],
                       "lizard" => ["spock", "paper"],
                       "spock" => ["scissors", "rock"] }

@player_score = 0
@computer_score = 0

def display_result(player, computer)
  if WINNING_CONDITIONS[player].include?(computer)
    prompt("You won!")
  elsif WINNING_CONDITIONS[computer].include?(player)
    prompt("You lost.")
  else
    prompt("It's a tie.")
  end
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def convert_user_input(input)
  case input
  when 'r'
    'rock'
  when 'p'
    'paper'
  when 'sc'
    'scissors'
  when 'l'
    'lizard'
  when 'sp'
    'spock'
  end
end

def continue_playing?
  prompt("Final score is you: #{@player_score}, Computer: #{@computer_score}")
  prompt("Do you want to play again?(Y/N)")
  answer = Kernel.gets().chomp()

  if answer.downcase().start_with?('y')
    system('clear') || system('cls')
    @player_score = 0
    @computer_score = 0
  end
end

prompt("Welcome! We're going to play Rock, Paper, Scissors, Lizard, Spock")

loop do
  choice = ''

  loop do
    pick = <<-MSG
      Pick one of the following:
      1) Enter 'r' to choose Rock
      2) enter 'p' to choose Paper
      3) enter 'sc' to choose Scissors
      4) enter 'l' to choose Lizard
      5) enter 'sp' to choose Spock
    MSG

    prompt(pick)

    choice = Kernel.gets().chomp()

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice")
    end
  end

  computer_choice = VALID_CHOICES.sample

  choice = convert_user_input(choice)
  computer_choice = convert_user_input(computer_choice)

  prompt("You chose #{choice}; Computer chose #{computer_choice}")

  display_result(choice, computer_choice)

  if WINNING_CONDITIONS[choice].include?(computer_choice)
    @player_score += 1
  elsif WINNING_CONDITIONS[computer_choice].include?(choice)
    @computer_score += 1
  end

  if @player_score == 5
    prompt("Congratulations, you are the Grand Winner!")
    continue_playing?
  elsif @computer_score == 5
    prompt("Unlucky, the Computer is the Grand Winner!")
    continue_playing?
  end

  break unless @player_score < 5 && @computer_score < 5

  prompt("Current score is you: #{@player_score}, Computer: #{@computer_score}")
end

prompt("Thank you for playing!")
