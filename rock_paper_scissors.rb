VALID_CHOICES = ["r", "p", "sc", "l", "sp"]

WINNING_CONDITIONS = { "scissors" => ["paper", "lizard"],
                       "paper" => ["rock", "spock"],
                       "rock" => ["lizard", "scissors"],
                       "lizard" => ["spock", "paper"],
                       "spock" => ["scissors", "rock"] }

NUMBER_OF_WINS = 5

def prompt(message)
  Kernel.puts("=> #{message}")
end

def player_won?(player, computer)
  WINNING_CONDITIONS[player].include?(computer)
end

def computer_won?(player, computer)
  WINNING_CONDITIONS[computer].include?(player)
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

def final_score(player, computer)
  prompt("Final score is you: #{player}, Computer: #{computer}")
  if player == NUMBER_OF_WINS
    prompt("Congratulations, you are the Grand Winner!")
  else prompt("Unlucky, the Computer is the Grand Winner!")
  end
end

def display_player_won
  prompt("You won!")
end

def display_computer_won
  prompt("You lost")
end

def display_choices(player, computer)
  prompt("You chose #{player}; Computer chose #{computer}")
end

def match_over?(player, computer)
  player == NUMBER_OF_WINS || computer == NUMBER_OF_WINS
end

def valid_move_choice?(input)
  VALID_CHOICES.include?(input)
end

def current_score(player, computer)
  prompt("Current score is you: #{player}, Computer: #{computer}")
end

def display_goodbye_message
  prompt("Thank you for playing!")
end

def clear_system
  system('clear') || system('cls')
end

prompt("Welcome! We're going to play Rock, Paper, Scissors, Lizard, Spock")

loop do
  player_score = 0
  computer_score = 0
  prompt("First person to win 5 matches is the Grand Winner")

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

      choice = Kernel.gets().chomp().downcase()

      if valid_move_choice?(choice)
        break
      else
        prompt("That's not a valid choice")
      end
    end

    clear_system

    computer_choice = VALID_CHOICES.sample

    choice = convert_user_input(choice)
    computer_choice = convert_user_input(computer_choice)

    display_choices(choice, computer_choice)

    if player_won?(choice, computer_choice)
      display_player_won
      player_score += 1
    elsif computer_won?(choice, computer_choice)
      display_computer_won
      computer_score += 1
    else prompt("It's a tie.")
    end

    break if match_over?(player_score, computer_score)
    current_score(player_score, computer_score)
  end

  final_score(player_score, computer_score)

  prompt("Do you want to play again?(Y/N)")
  answer = Kernel.gets().chomp().downcase
  break unless answer.downcase().start_with?('y')
  clear_system
end

display_goodbye_message
