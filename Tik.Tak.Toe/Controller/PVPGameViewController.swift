import UIKit

class PVPGameViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var player1ScoreLabel: UILabel! // Player 1's score label
	@IBOutlet weak var player2ScoreLabel: UILabel! // Player 2's score label
    @IBOutlet weak var Player1Label: UILabel! // Player 1's name label
    @IBOutlet weak var Player2Label: UILabel! // Player 2's name label
    @IBOutlet weak var PlayerTurnLabel: UILabel! // Label indicating whose turn it is
	
	// MARK: - Constants
    let backgroundImageName = UIImage(named: "background") // Background image
        
    // MARK: - Variables
    var player1Name: String? // Player 1's name
    var player2Name: String? // Player 2's name
    var player1Score = 0 // Player 1's score
    var player2Score = 0 // Player 2's score
    var isGameOver = false // Flag indicating if the game is over
    var gameLogic = TicTacToeGameLogic() // Game logic
    var currentPlayer: TicTacToeGameLogic.Player = .X // Current player
        
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI() // Set up the user interface
        gameLogic.resetGame() // Reset the game logic
    }
        
    // MARK: - UI Setup
    func setupUI() {
        view.backgroundColor = .lightGray // Set the background color of the view
        
        // Set player names and background color for Player 1 label
        if let name = player1Name {
            Player1Label.text = name
            PlayerTurnLabel.text = "\(name)'s Turn"
        }
        
        // Set Player 2 name
        if let name = player2Name {
            Player2Label.text = name
        }
        
        // Set background image
        setBackgroundImage()
        
        updateScoreLabel()
        
        }
        
    func setBackgroundImage() {
        // Set the background image for the game board
            if let imageView = view.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
                imageView.image = backgroundImageName
            }
        }
        
    // MARK: - Game Logic
    func resetGameUI() {
    // Reset the UI by clearing the game board cells
        for tag in 1...9 {
            if let imageView = view.viewWithTag(tag) as? UIImageView {
                imageView.image = backgroundImageName
            }
        }
        
        // Reset the player turn label
        resetPlayerTurnLabel()
    }
        
    func showMainMenu() {
        // Navigate to the main menu
            if let mainMenuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainMenuViewController") as? ViewController {
                present(mainMenuViewController, animated: true, completion: nil)
            } else {
                print("Error: Unable to instantiate MainMenuViewController")
            }
        }
        
    func showResult(_ result: String) {
        // Display a game result in an alert
        let alertController = UIAlertController(title: "Game Over", message: result, preferredStyle: .alert)
        
        // Define actions for the alert
        let restartAction = UIAlertAction(title: "Restart", style: .default) { [weak self] _ in
            // Increment scores if there was a winner
            if self?.gameLogic.checkForWin() == true {
                if self?.currentPlayer == .X {
                    self?.player1Score += 1
                } else {
                    self?.player2Score += 1
                }
            }
            self?.gameLogic.resetGame()
            self?.resetGameUI()
            self?.updateScoreLabel()
            self?.resetPlayerTurnLabel()
            
        }
        
        let exitAction = UIAlertAction(title: "Exit", style: .default) { [weak self] _ in
            self?.showMainMenu()
        }
        
        // Add actions to the alert controller
        alertController.addAction(restartAction)
        alertController.addAction(exitAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
    
    func updateScoreLabel(){
        player1ScoreLabel.text = "Score: \(player1Score)"
		player2ScoreLabel.text = "Score: \(player2Score)"
    }
    
    func resetPlayerTurnLabel() {
        if let player1Name = player1Name {
            PlayerTurnLabel.text = "\(player1Name)'s Turn"
        }
    }

    // MARK: - Actions

    @IBAction func handleCellTap(_ sender: UITapGestureRecognizer) {
        
        // Check if the game is over, and return if it is
        if gameLogic.isGameOver {
            return
        }

        if let imageView = sender.view as? UIImageView {
            let imageViewTag = imageView.tag
            print("Empty Cell with tag \(imageViewTag) was tapped.")

            if gameLogic.gameBoard[imageViewTag] == nil {
                gameLogic.makeMove(at: imageViewTag)

                if currentPlayer == .X {
                    imageView.image = UIImage(named: "Player1")
                    PlayerTurnLabel.text = "\(player2Name ?? "Player 2")'s Turn"
                    print("Player 1 \(imageView) was tapped.")
                } else {
                    imageView.image = UIImage(named: "Player2")
                    gameLogic.gameBoard[imageViewTag] = .O
                    PlayerTurnLabel.text = "\(player1Name ?? "Player 1")'s Turn"
                    print("Player 2 \(imageView) was tapped.")
                }

                if gameLogic.isGameOver {
                    if gameLogic.checkForWin() {
                        print("Player \(currentPlayer) won!")
                        showResult("Player \(currentPlayer) won!")
                    } else if gameLogic.checkForDraw() {
                        print("It's a draw")
                        showResult("It's a Draw!")
                    }
                }
                
                currentPlayer = gameLogic.currentPlayer
            }
        }
    }
    
}
