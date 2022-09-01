#fronzen_string_literal: true

require_relative 'display'

#class for Hangman game
class Hangman
  include Display
  def start_game
    @dictionary = load_dictionary
    @word = @dictionary.sample
    @word_progress = Array.new(@word.length, '_')
    @guesses = []
    @wrong_guesses_left = 6
    @possible_guesses = ('a'..'z').to_a
    play_game
  end

  def load_dictionary
    dictionary = []
    File.open('google-10000-english-no-swears.txt', 'r') do |words|
      words.readlines.each { |word| dictionary << word.chomp if word.length in (6..13) }
    end
    dictionary
  end

  def play_game
    word_chosen
    until game_over?
      player_guess
      display_board
    end
    end_game
  end

  def player_guess
    prompt_guess
    guess = gets.chomp.downcase
    if valid_guess?(guess)
      check_guess(guess)
    else
      invalid_guess
      player_guess
    end
  end

  def valid_guess?(guess)
    if @possible_guesses.include?(guess)
      true
    else
      invalid_guess
      false
    end
  end

  def check_guess(guess)
    if @word.include?(guess)
      correct_guess
      update_word_progress(guess)
    else
      incorrect_guess
      @wrong_guesses_left -= 1
    end
    @possible_guesses.delete(guess)
    @guesses << guess
  end

  def update_word_progress(guess)
    word_copy = @word
    while word_copy.include?(guess)
      index = word_copy.index(guess)
      @word_progress[index] = guess
      word_copy[index] = '_'
    end
  end

  def game_over?
    true if !@word_progress.include?('_') || @wrong_guesses_left == 0
  end
  def end_game
    if !@word_progress.include?('_')
      display_win
    else
      display_lose
    end
    ask_play_again
    Hangman.new.start_game if gets.chomp.downcase == 'y' 
  end
end
