import UIKit

class PVEViewController: UIViewController {
    
    // Define an enumeration to represent players in the game.
    enum Player {
        case X
        case O
    }
    
    // MARK: UI elements as outlets
    @IBOutlet weak var lblScore: UILabel!
    
    @IBOutlet weak var lblPlayer1: UILabel!
    @IBOutlet weak var lblPlayer2: UILabel!
    
    // MARK: Variables
    
    //player names, background image, and scores.
    var p1receivedText: String?
    var p2receivedText: String?
    
    //Background image
    var backgroundImage = UIImage(named: "background")
    
    //Score
    var p1Score = 0
    var p2Score = 0
    
    //Track the current Player and AI player.
    var currentPlayer: Player = .X
    var aiPlayer: Player = .O
    
    //Track the game board, and game status.
    var gameBoard: [Player?] = Array(repeating: nil, count: 9)
    var gameOver = false
    
    // Define winning combinations on the game board.
    let winCombination: [[Int]] = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
        [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
        [0, 4, 8], [2, 4, 6] // Diagonals
    ]
    
    // Initialize the game, set player names, and reset the game board.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set player names if provided.
        if let text = p1receivedText {
            lblPlayer1.text = text
        }
        
        if let text = p2receivedText {
            lblPlayer2.text = text
        }
        
        resetGameBoard()

        // Reset the background image of the game board.
        if let imageView = view.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
            imageView.image = backgroundImage
        }
    }
    
    //MARK: Functions
    
    // Function to check if a player has won based on the current game state.
    func checkForWin(player: Player) -> Bool {
        // Check all winning combinations for the given player.
        for combination in winCombination {
            if gameBoard[combination[0]] == player &&
                gameBoard[combination[1]] == player &&
                gameBoard[combination[2]] == player {
                return true
            }
        }
        return false
    }
    
    // Function to check if the game is a draw (no more moves possible).
    func checkForDraw() -> Bool {
        return gameBoard.allSatisfy { $0 != nil }
    }
    
    // Reset the game board to its initial state.
    func resetGameBoard() {
        // Reset each cell on the game board and initialize game variables.
        for i in 0..<9 {
            if let imageView = view.viewWithTag(i + 1) as? UIImageView {
                imageView.image = backgroundImage
                imageView.isUserInteractionEnabled = true
            }
        }
        
        gameBoard = Array(repeating: nil, count: 9)
        gameOver = false
        currentPlayer = .X
    }
    
    // Display a result message and handle score updates when the game ends.
    func showResult(_ result: String) {
        let alertController = UIAlertController(title: "Game Over", message: result, preferredStyle: .alert)
        // Add a "Restart" option to reset the game.
        let restartAction = UIAlertAction(title: "Restart", style: .default) { _ in
            self.resetGameBoard()
        }
        let exitAction = UIAlertAction(title: "Exit", style: .default) { _ in self.showMainMenu()
        }
        
        alertController.addAction(restartAction)
        alertController.addAction(exitAction)
        
        // Update scores based on the game result.
        if result.contains("Player X is won!") {
            p1Score += 1
        } else if result.contains("Player O is won!") {
            p2Score += 1
        }
        
        lblScore.text = "Score: \(p1Score)-\(p2Score)"
        
        // Present the result alert.
        present(alertController, animated: true, completion: nil)
    }
    
    func showMainMenu(){
    // Assuming you're using a storyboard named "Main" and your MainMenuViewController has the storyboard identifier "MainMenuViewController"
    if let mainMenuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainMenuViewController") as? ViewController {
    // Present the MainMenuViewController
        self.present(mainMenuViewController, animated: true, completion: nil)
        } else {
    // Handle the case where the view controller couldn't be instantiated
        print("Error: Unable to instantiate MainMenuViewController")
        }
    }
    
    // Present the result alert.
    func performAIPlayerMove() {
        // Determine the AI player's best move and update the game board.
        let bestMove = getBestAIMove()
        
        if let imageView = view.viewWithTag(bestMove + 1) as? UIImageView {
            // Assuming Player2 represents AI
            imageView.image = UIImage(named: "Player2")
            gameBoard[bestMove] = .O
            
            // Check if the AI player has won or if the game is a draw.
            if checkForWin(player: .O) {
                gameOver = true
                showResult("Player O is won!")
            } else if checkForDraw() {
                gameOver = true
                showResult("It's a draw")
            } else {
                currentPlayer = .X
            }
            
            imageView.isUserInteractionEnabled = false
        }
    }
    
    // Determine the AI player's best move using the minimax algorithm.
    func getBestAIMove() -> Int {
        var bestMove = -1
        var bestScore = Int.min

        // Iterate through available moves and evaluate the best one.
        for move in 0..<9 where gameBoard[move] == nil {
            gameBoard[move] = .O
            let score = minimax(board: gameBoard, depth: 0, isMaximizing: false)
            gameBoard[move] = nil

            if score > bestScore {
                bestScore = score
                bestMove = move
            }
        }

        return bestMove
    }
    
    
    // Implement the minimax algorithm for AI move calculation.
    func minimax(board: [Player?], depth: Int, isMaximizing: Bool) -> Int {
        let result = evaluate(board: board)

        // If the game has a result (win, lose, or draw), return the result.
        if result != 0 {
            return result
        }

        if isMaximizing {
            var bestScore = Int.min

            // Find the best move for the AI player.
            for move in 0..<9 where board[move] == nil {
                var newBoard = board // Make a copy of the board
                newBoard[move] = .O // Simulate AI's move
                let score = minimax(board: newBoard, depth: depth + 1, isMaximizing: false)
                bestScore = max(score, bestScore)
            }

            return bestScore
        } else {
            var bestScore = Int.max

            // Find the best move for the human player.
            for move in 0..<9 where board[move] == nil {
                var newBoard = board // Make a copy of the board
                newBoard[move] = .X // Simulate the player's move
                let score = minimax(board: newBoard, depth: depth + 1, isMaximizing: true)
                bestScore = min(score, bestScore)
            }

            return bestScore
        }
    }

    // Evaluate the current game state and return a score.
    func evaluate(board: [Player?]) -> Int {
        // Check all winning combinations for both players.
        for combination in winCombination {
            if let player = board[combination[0]],
               player == board[combination[1]] &&
               player == board[combination[2]] {
                if player == .X {
                    return -1 // Player X wins
                } else if player == .O {
                    return 1 // Player O wins
                }
            }
        }
        
        return 0 // It's a draw or the game is ongoing
    }
    
    //MARK: UI elements as action
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        // Check if the game is already over; if so, do nothing.
        if gameOver {
            return
        }

        // Check if the tapped view is an image view and if the corresponding cell on the game board is empty.
        if let imageView = sender.view as? UIImageView,
           gameBoard[imageView.tag - 1] == nil {
            // Set the image for the current player (assuming Player1 represents the human player).
            imageView.image = UIImage(named: "Player1")
            gameBoard[imageView.tag - 1] = .X

            // Check if the human player has won or if the game is a draw.
            if checkForWin(player: .X) {
                gameOver = true
                showResult("Player X is won!")
            } else if checkForDraw() {
                gameOver = true
                showResult("It's a draw")
            } else {
                // Switch to the AI player's turn (Player O).
                currentPlayer = .O
            }

            // Disable user interaction for the tapped cell to prevent further moves.
            imageView.isUserInteractionEnabled = false

            // If the game is not over, let the AI player make its move.
            if !gameOver {
                performAIPlayerMove()
            }
        }
    }
}
