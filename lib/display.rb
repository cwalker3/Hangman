# frozen_string_literal: true

# display module for Hangman game
module Display
  def prompt_load
    puts 'Enter 1 if you would like to load a game, or any other key to start a new game'
  end

  def word_chosen
    puts "\nA random word has been chosen, it has #{@word.length} letters."
  end

  def prompt_input
    puts "Enter a letter to guess, or enter 'save' to save your progress to resume later"
  end

  def display_board
    unless @guesses == []
      print 'Your guesses: '
      @guesses.each { |guess| print "#{guess} " }
      puts ''
    end
    @word_progress.each { |letter| print "#{letter} " }
    puts ''
    puts "You have #{@wrong_guesses_left} wrong guesses left."
  end

  def invalid_input
    puts 'Invalid input'
  end

  def correct_guess
    puts "\n\nCorrect guess."
  end

  def incorrect_guess
    puts "\n\nIncorrect guess."
  end

  def display_win
    puts 'You win!'
  end

  def display_lose
    puts "You lose! Word was #{@word}."
  end

  def ask_play_again
    puts "Enter 'y' to play again."
  end

  def prompt_save_name
    puts 'Enter a name for your save, or enter \'cancel\' to continue playing'
  end

  def save_exists
    puts 'A save with that name already exists.'
  end

  def display_saves
    puts 'Saves:'
    Dir.children('saves').each { |file| puts file }
  end

  def prompt_choose_save
    puts 'Choose a save to load'
  end

  def save_message
    puts "\n\nYour game has been saved"
  end
end
