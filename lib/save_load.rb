# frozen_string_literal: true

# module for saving and loading Hangman games
module SaveLoad
  def load_save
    display_saves
    prompt_choose_save
    input = gets.chomp until valid_save?(input)
    save = File.open("saves/#{input}", 'r')
    contents = save.read
    from_yaml(contents)
  end

  def valid_save?(input)
    if Dir.children('saves').include?(input)
      true
    else
      invalid_input
      false
    end
  end

  def name_save
    prompt_save_name
    input = gets.chomp
    play_game if input == 'cancel'
    if valid_name?(input)
      save_game(input)
    else
      save_game
    end
  end

  def valid_name?(save_name)
    if save_name == ''
      invalid_input
      false
    elsif File.exist?("saves/#{save_name}")
      save_exists
      false
    else
      true
    end
  end

  def save_game(save_name)
    File.open("saves/#{save_name}", 'w') { |save| save.puts to_yaml }
  end
end