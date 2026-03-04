# Hangman

A terminal-based Hangman game written in Ruby. Guess the secret word one letter at a time — but watch out, you only get 6 wrong guesses before it's game over. Save your progress mid-game and come back to it later.

---

## Features

- 🎲 **Random word selection** — picks from a filtered dictionary of 10,000 common English words (5–12 letters, no swears)
- 💾 **Save & load system** — save your game state to a YAML file at any time and resume later
- 🔁 **Multiple save slots** — name your saves and choose from a list when loading
- ✅ **Input validation** — handles duplicate guesses, invalid characters, and corrupt save files gracefully
- 🖥️ **Clean terminal UI** — displays word progress, incorrect guesses, and remaining attempts on each turn

---

## How to Play

**Prerequisites:** Ruby must be installed on your system. Verify with:

```bash
ruby -v
```

**Run the game:**

```bash
ruby game.rb
```

**On startup, choose:**
- `1` — Start a new game
- `2` — Load a previously saved game

**During the game:**
- Type a single letter and press Enter to guess
- Type `save` instead of a letter to save your progress and exit
- You have **6 incorrect guesses** before the game ends

---

## Project Structure

```
hangman/
├── game.rb                            # Main game logic and loop
├── player.rb                          # Player input handling
├── google-10000-english-no-swears.txt # Word dictionary
├── Gemfile                            # Ruby dependencies
└── saves/                             # Auto-created when you save a game
    └── your_save.yaml
```

---

## How Save/Load Works

Game state is serialized to YAML and stored in a `saves/` directory. Each save captures:
- The secret word
- All guessed letters so far
- Remaining attempts

On load, the game reads the YAML file and resumes exactly where you left off.

---

## What I Learned

- Structuring a Ruby program with clearly separated responsibilities (word loading, display, save/load, game loop)
- Reading and writing files with Ruby's `File` and `Dir` classes
- Serializing game state with the `yaml` library
- Handling edge cases like missing files, empty input, duplicate guesses, and corrupt saves

---

## Built With

- Ruby
- YAML (standard library)

---

## Future Improvements

- Add RSpec test coverage for game logic
- Add a visual ASCII hangman drawing
- Allow the player to choose difficulty (word length or guess limit)
- Refactor into a class-based OOP structure

