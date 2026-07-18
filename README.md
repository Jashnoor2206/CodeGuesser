# CodeBreaker 🎯

A SwiftUI + SwiftData iOS app implementation of the classic **Mastermind** code-breaking board game. Guess the hidden color sequence within limited attempts using black and white pin feedback.

## 🎮 How to Play

1. The **Game Master** secretly generates a random sequence of 4 pegs from a chosen color palette.
2. The **Player** guesses a 4-peg combination.
3. After each guess, feedback pins are shown:
   - ⚫ **Black pin** — correct color in the correct position (exact match)
   - ⚪ **White pin** — correct color but wrong position (inexact match)
4. The player has a limited number of attempts to crack the code before the game ends.
5. Win by matching the master code exactly!

## ✨ Features

- **Multiple game boards** — create, edit, and manage several CodeBreaker games at once
- **Custom peg palettes** — choose your own set of colors (2+ unique pegs required) per game via a built-in color picker
- **Persistent storage** — game state, attempt history, and progress saved locally using **SwiftData**
- **Sorting** — browse saved games alphabetically or by most recently played
- **Swipe actions** — edit or delete games directly from the list
- **Smooth animations** — animated transitions for guesses, restarts, and attempt history
- **Adaptive layout** — built with `NavigationSplitView` for a responsive iPad/iPhone experience

## 🏗️ Project Structure

| File | Description |
|---|---|
| `codeBreaker.swift` | Core `CodeBreaker` SwiftData model — manages master code, guesses, attempts, and game logic |
| `Code.swift` | `Code` SwiftData model representing a set of 4 pegs (master code, guess, or an attempt) with match-scoring logic |
| `Pins.swift` | Renders black/white feedback pins for an attempt |
| `PegView.swift` | Renders a single colored peg |
| `Pegchooser.swift` | Bottom peg-selection palette used to build a guess |
| `Choices.swift` | Displays the peg color palette available for a game |
| `CodeView.swift` | Renders a row of 4 pegs (used for master code, guess, and attempts) |
| `CodeBreakerView.swift` | Main game screen — combines master code, current guess, attempt history, and controls |
| `GameChooser.swift` | Root split view for selecting and playing a game |
| `GameList.swift` | List of all saved games with create/edit/delete/sort support |
| `GameEditor.swift` | Form for editing a game's name and peg choices |
| `GameEditorPegChooser.swift` | Color picker list for customizing a game's peg palette |
| `Color+String.swift` | Utilities to encode/decode `Color` as a string for SwiftData persistence, plus color comparison helpers |

## 🛠️ Tech Stack

- **Swift**
- **SwiftUI** — declarative UI
- **SwiftData** — local persistence for games, codes, and attempts

## 📋 Requirements

- Xcode 15+
- iOS 17+
- Swift 5.9+

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/codebreaker.git
   ```
2. Open the project in Xcode.
3. Build and run on a simulator or device (⌘R).

## 🧠 How Matching Works

Each guess is scored against the master code using a two-pass algorithm:
1. **Exact match pass** — pegs in the same position and same color are marked as exact matches and removed from consideration.
2. **Inexact match pass** — remaining pegs are checked for color matches in any other position and marked as inexact matches.

This mirrors traditional Mastermind scoring rules.

## 📌 Roadmap Ideas

- [ ] Add difficulty levels (varying code length / attempt limits)
- [ ] Add sound effects and haptics
- [ ] iCloud sync across devices
- [ ] Dark mode-specific peg styling
- [ ] Unit tests for match-scoring logic

## 👤 Author

**Jashnoor Singh**

## 📄 License

This project is available under the MIT License. See `LICENSE` for details.
