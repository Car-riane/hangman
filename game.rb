# encoding: utf-8
require "yaml"

DICT_PATH = "google-10000-english-no-swears.txt"
SAVE_DIR = "saves"

# -------------------------
# STEP 1: Load words
# -------------------------
def load_words
  unless File.exist?(DICT_PATH)
    abort "Dictionary not found at #{DICT_PATH}. Put it next to game.rb"
  end

  words = File.readlines(DICT_PATH, chomp: true)
  words.select { |w| w.match?(/\A[a-zA-Z]+\z/) && w.length.between?(5, 12) }
end

# -------------------------
# STEP 2: Display the game state
# -------------------------
def display_game_state(secret_word, guessed_letters, remaining_attempts)
  display_word = secret_word.chars.map { |ch| guessed_letters.include?(ch) ? ch : "_" }.join(" ")
  correct_guesses = guessed_letters.select { |ch| secret_word.include?(ch) }
  incorrect_guesses = guessed_letters.reject { |ch| secret_word.include?(ch) }

  puts "\nWord: #{display_word}"
  puts "Incorrect guesses: #{incorrect_guesses.join(', ')}"
  puts "Remaining attempts: #{remaining_attempts}"
end

# -------------------------
# STEP 3: Save and load functionality
# -------------------------
def save_game(secret_word, guessed_letters, remaining_attempts)
  Dir.mkdir(SAVE_DIR) unless Dir.exist?(SAVE_DIR)

  print "Enter a name for your save file (no extension): "
  filename = gets.chomp.strip
  filename = "save_#{Time.now.to_i}" if filename.empty?
  filepath = File.join(SAVE_DIR, "#{filename}.yaml")

  game_data = {
    "secret_word" => secret_word,
    "guessed_letters" => guessed_letters,
    "remaining_attempts" => remaining_attempts
  }

  File.open(filepath, "w") { |file| file.puts YAML.dump(game_data) }

  puts "💾 Game saved as '#{filename}.yaml'!"
end

def load_game
  unless Dir.exist?(SAVE_DIR)
    puts "No saved games found."
    return nil
  end

  saves = Dir.glob(File.join(SAVE_DIR, "*.yaml")).sort
  if saves.empty?
    puts "No saved games found."
    return nil
  end

  puts "\nAvailable saves:"
  saves.each_with_index { |path, i| puts "#{i + 1}. #{File.basename(path)}" }

  print "\nEnter the number of the game you want to load: "
  choice = gets.chomp.to_i
  selected_path = saves[choice - 1]

  unless selected_path && File.exist?(selected_path)
    puts "Invalid choice."
    return nil
  end

  data = YAML.load_file(selected_path)

  # Normalize keys (support symbol or string keys)
  if data.is_a?(Hash)
    secret = data["secret_word"] || data[:secret_word]
    guesses = data["guessed_letters"] || data[:guessed_letters]
    attempts = data["remaining_attempts"] || data[:remaining_attempts]

    if secret && guesses && attempts
      puts "🔁 Loaded '#{File.basename(selected_path)}'!"
      return { secret_word: secret, guessed_letters: Array(guesses), remaining_attempts: attempts.to_i }
    end
  end

  puts "Save file appears corrupt or incompatible."
  nil
end

# -------------------------
# STEP 4: Main game setup
# -------------------------
puts "Welcome to Hangman!"
puts "1. New Game"
puts "2. Load Game"
print "Choose an option (1 or 2): "
choice = gets.chomp.to_i

if choice == 2
  data = load_game
  if data
    secret_word = data[:secret_word].to_s.downcase
    guessed_letters = data[:guessed_letters].map(&:to_s)
    remaining_attempts = data[:remaining_attempts].to_i
  else
    puts "Starting a new game..."
    secret_word = load_words.sample.downcase
    guessed_letters = []
    remaining_attempts = 6
  end
else
  secret_word = load_words.sample.downcase
  guessed_letters = []
  remaining_attempts = 6
end

# -------------------------
# STEP 5: Game loop
# -------------------------
puts "\nLet's begin!"
display_game_state(secret_word, guessed_letters, remaining_attempts)

until remaining_attempts == 0
  print "\nEnter a letter or type 'save' to save your game: "
  input = gets.chomp.to_s.downcase.strip

  if input == "save"
    save_game(secret_word, guessed_letters, remaining_attempts)
    puts "Exiting game after save..."
    exit
  end

  guess = input
  until guess.match?(/\A[a-z]\z/) && !guessed_letters.include?(guess)
    if guessed_letters.include?(guess)
      print "You already guessed that letter. Try again: "
    else
      print "Invalid input. Please enter a single letter: "
    end
    guess = gets.chomp.to_s.downcase.strip
  end

  guessed_letters << guess

  if secret_word.include?(guess)
    puts "✅ Good guess!"
  else
    puts "❌ Nope, that letter isn't in the word."
    remaining_attempts -= 1
  end

  display_game_state(secret_word, guessed_letters, remaining_attempts)

  # Check win condition
  if secret_word.chars.all? { |ch| guessed_letters.include?(ch) }
    puts "\n🎉 You win! The word was '#{secret_word}'."
    exit
  end
end

# -------------------------
# STEP 6: Game over
# -------------------------
puts "\n💀 Game over! The word was '#{secret_word}'."
