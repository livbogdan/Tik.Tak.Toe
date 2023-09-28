
The provided code represents a Tic-Tac-Toe game built using the Model-View-Controller (MVC) architectural pattern in Swift with UIKit. I'll provide a detailed description of the game structure and functionality based on the code you've provided.

### MVC Structure

The code is organized into three components:

1. **Model (TicTacToeGameLogic)**: This class encapsulates the game's logic and data. It maintains the game board, tracks the current player's turn, checks for a win or draw, and provides methods for making moves, resetting the game, and getting empty positions.

2. **View (ViewController)**: This class manages the user interface elements of the game. It includes player labels, text fields for entering player names, buttons for starting the game, and handlers for user interactions. The view controller also handles navigation between different game modes.

3. **View Controllers for Different Game Modes (PVPGameViewController and PVEViewController)**: These view controllers are responsible for managing the gameplay of Player vs. Player (PVP) and Player vs. Environment (PVE) modes, respectively. They utilize the game logic provided by the `TicTacToeGameLogic` class and update the UI accordingly. The PVE mode also includes logic for simulating the AI's moves.

### Player vs. Player (PVP) Mode (PVPGameViewController)

This mode allows two human players to take turns playing Tic-Tac-Toe against each other. Here's a breakdown of its functionality:

- Players' names and scores are displayed at the top of the screen.
- The game board consists of 9 cells represented by image views, and players can tap on a cell to make their move.
- The game checks for a win or a draw after each move and displays a result in an alert.
- The alert allows players to restart the game or return to the main menu.
- The UI is updated to show the current player's turn.
- Players' scores are updated based on the game outcome.

### Player vs. Environment (PVE) Mode (PVEViewController)

This mode allows a human player to play against an AI opponent. Here's a breakdown of its functionality:

- The human player's name and score are displayed at the top of the screen.
- The AI's name and score are also displayed.
- The game board and player labels are styled with borders and background colors.
- The player can tap on a cell to make their move.
- The AI's move is simulated (randomly) after the player's move.
- The game checks for a win or a draw after each move and displays a result in an alert.
- The alert allows the player to restart the game or return to the main menu.
- The UI is updated to show the current player's turn.
- Scores are updated based on the game outcome.

### Shared Functionality

- The code uses `UIAlertController` to display game results and provide options to restart or exit the game.
- The game logic is implemented in the `TicTacToeGameLogic` class, which handles moves, win/draw checks, and resetting the game board.

### Main Menu

The main menu, accessible from both PVP and PVE modes, allows players to set their names and choose the game mode they want to play. It uses segues to transition between different view controllers.

### User Interface (UI)

The UI elements are styled with borders and background colors to enhance the visual experience. Players can edit their names using text fields, and buttons allow them to start games in different modes.

### Flow

1. Players enter their names or use default names.
2. They can start a PVP or PVE game.
3. During gameplay, players take turns making moves.
4. The game checks for a win or draw.
5. An alert is displayed with options to restart or return to the main menu.
6. Scores are updated based on the game outcome.
7. Players can continue or start a new game.

This is a comprehensive breakdown of the provided code for a Tic-Tac-Toe game implemented using Swift and UIKit's MVC architecture.


Original Story board with drag and drop.

<img width="1792" alt="Skärmavbild 2023-09-28 kl  18 56 22" src="https://github.com/livbogdan/Tik.Tak.Toe/assets/33436357/59dc1019-b590-4a4f-ad6d-54cecfeaac4b">

Through meticulous manual visual styling, I meticulously tailored the user interface for the view controller within our application. The goal was to create an immersive and visually captivating experience, particularly within the context of the PVE (Player vs. Environment) view

<img width="1371" alt="Skärmavbild 2023-09-28 kl  19 00 04" src="https://github.com/livbogdan/Tik.Tak.Toe/assets/33436357/37f056f4-e4dd-4f8a-b48d-c30656377b26">
