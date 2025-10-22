# Hangman

A classic game of Hangman that runs in your terminal. This Ruby script lets you play, save your progress, and load previous games.

## Features

  * **Save/Load Game:** Don't lose your progress\! You can save your game at any time and load it back up from the main menu.
  * **Simple UI:** A clean, text-based interface shows your guessed letters, the word-in-progress, and your remaining attempts.
  * **Word Dictionary:** Pulls a random 5-12 letter word from the included `google-10000-english-no-swears.txt` dictionary.
  * **Classic Rules:** You have 6 incorrect attempts to guess the secret word before the man is... well, you know.

## Prerequisites

1.  **Ruby:** You must have Ruby installed on your system.
2.  **Word List:** This game requires the `google-10000-english-no-swears.txt` file. It **must** be in the same folder as `game.rb` to work.
3.  **Gems (if any):** This script uses the `yaml` gem, which is part of the standard Ruby library, so no special installation is usually needed. If a `Gemfile` is present, you may need to run:
    ```sh
    bundle install
    ```

## How to Play

1.  **Run the game** from your terminal:

    ```sh
    ruby game.rb
    ```

2.  **Choose an option:**

      * Type `1` for a **New Game**.
      * Type `2` to **Load a previous game**. This will show you a list of your saved files from the `saves/` directory.

3.  **Start guessing\!**

      * Enter a single letter and press Enter.
      * The game will show your progress, your incorrect guesses, and your remaining attempts.

4.  **Save your game (optional):**

      * At any time when prompted for a guess, type `save` instead of a letter.
      * You will be asked to name your save file (e.g., `my_game`).
      * Your game state is saved as `my_game.yaml` in the `saves/` directory, and the game will exit. You can load this file next time.
