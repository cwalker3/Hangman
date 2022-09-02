#frozen_string_literal: true

require 'yaml'
require_relative 'display'
require_relative 'save_load'

#class for Hangman game
class Hangman
  include Display
  include SaveLoad
  attr_accessor :word, :word_progress, :guesses, :wrong_guesses_left, :possible_guesses

  def start_game
    unless load_game?
      load_dictionary
      choose_word
      @word_progress = Array.new(@word.length, '_')
      @guesses = []
      @wrong_guesses_left = 6
      @possible_guesses = ('a'..'z').to_a
      @save = false
      play_game
    end
  end

  def load_game?
    prompt_load
    input = gets.chomp
    if input == '1'
      load_save
      return true
    else
      false
    end
  end

  def load_dictionary
    @dictionary = []
    File.open('google-10000-english-no-swears.txt', 'r') do |words|
      words.readlines.each { |word| @dictionary << word.chomp if word.length in (6..13) }
    end
  end

  def choose_word
    @word = @dictionary.sample
    @dictionary = []
    word_chosen
  end

  def play_game
    until game_over? || @save
      display_board
      player_input
    end
    end_game
  end

  def player_input
    prompt_input
    input = gets.chomp.downcase
    if input == 'save'
      name_save
      @save = true
    elsif valid_guess?(input)
      check_guess(input)
    else
      invalid_guess
      player_input
    end
  end

  def valid_guess?(guess)
    if @possible_guesses.include?(guess)
      true
    else
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
    if @save
      save_message
    elsif !@word_progress.include?('_')
      display_win
    else
      display_lose
    end
    ask_play_again
    Hangman.new.start_game if gets.chomp.downcase == 'y' 
  end

  def to_yaml
    YAML.dump ({
      :word => @word,
      :word_progress => @word_progress,
      :guesses => @guesses,
      :wrong_guesses_left => @wrong_guesses_left,
      :possible_guesses => @possible_guesses
    })
  end

  def from_yaml(string)
    data = YAML.load(string)
    game = Hangman.new
    game.word = data[:word]
    game.word_progress = data[:word_progress]
    game.guesses = data[:guesses]
    game.wrong_guesses_left = data[:wrong_guesses_left]
    game.possible_guesses = data[:possible_guesses]
    game.play_game
  end
end
