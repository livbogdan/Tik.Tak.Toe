import UIKit

class PVPGameViewController: UIViewController {
    
    // Enum to represent the players in the game (X and O).
    enum Player {
        case X
        case O
    }
    
    // MARK: UI elements as outlets
    @IBOutlet weak var lblScore: UILabel!
    
    @IBOutlet weak var lblPlayer1: UILabel!
    @IBOutlet weak var lblPlayer2: UILabel!
    
    // MARK: Variables
    
    // Initialize a background image for the game board
    var backgroundImage = UIImage(named: "background")
    
    // Variables to store player name.
    var p1receivedText: String?
    var p2receivedText: String?
    
    // Variables to store player score.
    var p1Score = 0
    var p2Score = 0
    
    // Store the current player (X or O)
    var currentPlayer: Player = .X
    
    // Create a dictionary to represent the game board, with cell tags as keys and players as values
    var gameBoard: [Int: Player] = [:]
    
    // Track the game's status (whether it's over or still ongoing).
    var gameOver = false
    
    // Define winning combinations for rows, columns, and diagonals.
    let winCombination:[[Int]] = [
        [1, 2, 3], [4, 5, 6], [7, 8, 9],    // Rows
        [1, 4, 7], [2, 5, 8], [3, 6, 9],    // Columns
        [1, 5, 9], [3, 5, 7]]               // Diagonals
    
    //Initialize the game, set player names, and reset the game board.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set player names if provided.
        if let text = p1receivedText {
            lblPlayer1.text = text
        }
        
        if let text = p2receivedText {
            lblPlayer2.text = text
        }
        
        // Initialize the game board dictionary with empty cells.
        for i in 1...9 {
            gameBoard[i] = nil
        }
        
        // Reset the game board UI and status.
        resetGameBoard()
        
        // Reset the image to a default or empty image when the game ends
        if let imageView = view.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
            
            imageView.image = backgroundImage
        }
    }
    
    //MARK: Functions
    
    // Function to check if a player has won the game.
    func checkForWin() -> Bool {
        for combination in winCombination {
            if let player = gameBoard[combination[0]],  // Row combination
                player == gameBoard[combination[1]],    // Columns combination
                player == gameBoard[combination[2]]     // Diagonal combination
            {
                return true
            }
        }
        return false
    }
    
    // Function to check if the game is a draw (all cells filled).
    func checkForDraw() -> Bool {
        return gameBoard.values.compactMap { $0 }.count == 9
    }
    
    // Function to reset the game board to its initial state.
    func resetGameBoard() {
            for i in 1...9 {
                gameBoard[i] = nil
                if let imageView = view.viewWithTag(i) as? UIImageView {
                    imageView.image = backgroundImage
                    imageView.isUserInteractionEnabled = true
                    print("Image with tag \(imageView.tag) is reset.")
                }
            }
            
        // Reset the game status and switch to player X's turn.
        gameOver = false
        print("Game is Restarted")
        currentPlayer = .X
    }
    
    // Function to display the game result and handle score updates.
    func showResult(_ result: String) {
        let alertController = UIAlertController(title: "Game Over", message: result, preferredStyle: .alert)
            
        let restartAction = UIAlertAction(title: "Restart", style: .default) { _ in
            self.resetGameBoard()
        }
        let exitAction = UIAlertAction(title: "Exit", style: .default) { _ in self.showMainMenu()
            
        }
            
        alertController.addAction(restartAction)
        alertController.addAction(exitAction)
            
        // Update scores based on the result
        if result.contains("Player X is won!") {
            p1Score += 1
        } else if result.contains("Player O is won!") {
            p2Score += 1
        }
            
        // Update the score label with the current scores.
        lblScore.text = "Score: \(p1Score) - \(p2Score)"
        
        // Present the result alert to the user.
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
    
    // MARK: UI elements as action
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        // Check if the game is already over; if so, do nothing.
        if gameOver {
            return
        }
        
        // Identify which UIImageView was tapped
        if let imageView = sender.view as? UIImageView {
            let imageViewTag = imageView.tag
            print("Empty Cell with tag \(imageViewTag) was tapped.")
            
            // Check if the cell is empty
            if gameBoard[imageViewTag] == nil {
                
                // Set the current player's symbol in the cell
                if currentPlayer == .X {
                    imageView.image = UIImage(named: "Player1")
                    gameBoard[imageViewTag] = .X
                    print("X Cell with tag \(imageViewTag) was tapped.")
                    
                    // Change the background color of Player 1's label to green
                    lblPlayer2.backgroundColor = UIColor.green
                    lblPlayer1.backgroundColor = UIColor.clear
                    print("Player 1 green")
                    
                } else {
                    imageView.image = UIImage(named: "Player2")
                    gameBoard[imageViewTag] = .O
                    print("0 Cell with tag \(imageViewTag) was tapped.")
                    
                    // Change the background color of Player 2's label to green
                    lblPlayer1.backgroundColor = UIColor.green
                    lblPlayer2.backgroundColor = UIColor.clear
                    print("Player 2 green")
                }
                
                // Check if the current player has won or if the game is a draw.
                if checkForWin() {
                    gameOver = true
                    showResult("Player \(currentPlayer) is won!")
                    print("\(currentPlayer) Win!!!")
                }
                else if checkForDraw()
                {
                    gameOver = true
                    showResult("It Draw")
                    print("Its Draw")
                }
                else
                {
                    // Switch to the other player
                    currentPlayer = (currentPlayer == .X) ? .O : .X
                }
                // Disable the gesture recognizer for this cell
                imageView.isUserInteractionEnabled = false
            }
        }
        
    }
    
}
