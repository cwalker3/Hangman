#frozen_string_literal: true

#display module for Hangman game
module Display

  def word_chosen
    puts "\nA random word has been chosen, it has #{@word.length} letters."
  end
  def prompt_guess
    puts 'Guess one letter: '
  end

  def display_board
    print 'Your guesses: '
    @guesses.each { |guess| print "#{guess} " }
    puts ''
    @word_progress.each { |letter| print "#{letter} " }
    puts ''
    puts "You have #{@wrong_guesses_left} wrong guesses left."
  end

  def invalid_guess
    puts 'Invalid guess'
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
    puts "You lose! Word was #{@secret_word}."
  end

  def ask_play_again
    puts "Enter 'y' to play again."
  end
end