import UIKit

class PVEViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var playerScoreLabel: UILabel! // Player's score label
    @IBOutlet weak var playerLabel: UILabel! // Player's name label
    @IBOutlet weak var aiLabel: UILabel! // AI's name label
    @IBOutlet weak var playersTurnLabel: UILabel! // Label indicating whose turn it is
	@IBOutlet weak var aiScoreLabel: UILabel! // AI's score label
    @IBOutlet weak var gameBoardView: UIView! // View containing the game board
    
    // MARK: Constants
    var backgroundImageName = UIImage(named: "background") // Background image
    
    // MARK: Variables
    var playerName: String? // Player's name
    var aiName: String? // AI's name
    var playerScore = 0 // Player's score
    var aiScore = 0 // AI's score
    var isGameOver = false // Flag indicating if the game is over
    var isAlertActive = false // Flag indicating if an alert is active
    var gameLogic = TicTacToeGameLogic() // Game logic
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGameBoard() // Set up the game board
        setupUI() // Set up the user interface
        isGameOver = false // Initialize game state
        gameLogic.resetGame() // Reset the game logic
    }
    
    // MARK: UI Setup
    func setupUI() {
        view.backgroundColor = .lightGray // Set the background color of the view
        // Configure styling for the game board view
        gameBoardView.backgroundColor = .brown
        gameBoardView.layer.borderWidth = 1
        gameBoardView.layer.borderColor = UIColor(ciColor: .black).cgColor
        gameBoardView.layer.cornerRadius = 5
        gameBoardView.layer.shadowOffset = CGSize(width: 5, height: 5)
        gameBoardView.layer.shadowColor = UIColor(ciColor: .black).cgColor
        gameBoardView.layer.shadowRadius = 0.8
        gameBoardView.layer.shadowOpacity = 0.3
        
        // Configure styling for player and AI labels
        playerLabel.backgroundColor = .clear
        playerLabel.textColor = .black
        playerLabel.layer.borderWidth = 1
        playerLabel.layer.borderColor = UIColor(ciColor: .black).cgColor
        playerLabel.layer.cornerRadius = 5

        aiLabel.backgroundColor = .clear
        aiLabel.textColor = .black
        aiLabel.layer.borderWidth = 1
        aiLabel.layer.borderColor = UIColor(ciColor: .black).cgColor
        aiLabel.layer.cornerRadius = 5
        
        // Set player and AI names
        if let name = playerName {
            playerLabel.text = name
            playersTurnLabel.text = name
        }
        
        if let name = aiName {
            aiLabel.text = name
        }
        
        setBackgroundImage() // Set the background image
        updateScoreLabel() // Update the score labels
    }
    
    // Function to set the background image of the view
    func setBackgroundImage() {
        if let imageView = view.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
            imageView.image = backgroundImageName
        }
    }
    
    // MARK: Game Logic
    func setupGameBoard() {
        // Add tap gesture recognizers to each cell of the game board
        for tag in 1...9 {
            if let imageView = gameBoardView.viewWithTag(tag) as? UIImageView {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCellTap(_:)))
                imageView.addGestureRecognizer(tapGesture)
                imageView.isUserInteractionEnabled = true
            }
        }
    }
    
    // Function to reset the game's UI
    func resetGameUI() {
        for tag in 1...9 {
            if let imageView = view.viewWithTag(tag) as? UIImageView {
                imageView.image = backgroundImageName
            }
        }
        resetPlayerTurnLabel() // Reset the label indicating the player's turn
    }
    
    // Function to show the main menu
    func showMainMenu() {
        if let mainMenuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainMenuViewController") as? ViewController {
            present(mainMenuViewController, animated: true, completion: nil)
        } else {
            print("Error: Unable to instantiate MainMenuViewController")
        }
    }
    
    // Function to show the game result in an alert
    func showResult(_ result: String) {
        isAlertActive = true // Set the flag to true when the alert is displayed
        
        let alertController = UIAlertController(title: "Game Over", message: result, preferredStyle: .alert)
        
        let restartAction = UIAlertAction(title: "Restart", style: .default) { [weak self] _ in
            if self?.gameLogic.checkForWin() == true {
                if self?.gameLogic.currentPlayer == .X {
                    self?.playerScore += 1
                } else {
                    self?.aiScore += 1 // Increment AI's score when it wins
                }
            }
            
            self?.gameLogic.resetGame()
            self?.resetGameUI()
            self?.updateScoreLabel()
            self?.resetPlayerTurnLabel()
            self?.isGameOver = false
            
            // Re-enable user interaction on the game board view after the alert is dismissed
            self?.isAlertActive = false // Set the flag to false when the alert is dismissed
        }
        
        let exitAction = UIAlertAction(title: "Exit", style: .default) { [weak self] _ in
            self?.showMainMenu()
            
            // Re-enable user interaction on the game board view after the alert is dismissed
            self?.isAlertActive = false // Set the flag to false when the alert is dismissed
        }
        
        alertController.addAction(restartAction)
        alertController.addAction(exitAction)
        
        present(alertController, animated: true, completion: nil)
        
        isGameOver = true
    }

    // Function to update the player and AI score labels
    func updateScoreLabel() {
        playerScoreLabel.text = "Score: \(playerScore)"
        aiScoreLabel.text = "Score: \(aiScore)"
    }
    
    // Function to reset the label indicating the player's turn
    func resetPlayerTurnLabel() {
        if let player1Name = playerName {
            playersTurnLabel.text = "\(player1Name) Turn"
        }
    }
    
    // Function to simulate the AI player's move
    @objc func performAIPlayerMove() {
        // Get the list of empty positions on the game board
        let emptyPositions = gameLogic.getEmptyPositions()

        if isAlertActive {
            return
        }
        
        if emptyPositions.isEmpty {
            // No empty positions left; the game is a draw
            showResult("It's a draw")
            return
        }

        // Simulate AI's move (for example, random move)
        let randomIndex = Int.random(in: 0..<emptyPositions.count)
        let aiMove = emptyPositions[randomIndex]
        gameLogic.makeMove(at: aiMove)

        DispatchQueue.main.async {
            if let imageView = self.view.viewWithTag(aiMove) as? UIImageView {
                // Add animation to the AI's move
                UIView.animate(withDuration: 0.2, animations: {
                    imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5) // Scale down
                }) { _ in
                    UIView.animate(withDuration: 0.2) {
                        imageView.transform = CGAffineTransform.identity // Reset to normal scale
                    }
                }

                imageView.image = UIImage(named: "Player2")
                self.playersTurnLabel.text = "\(self.playerName ?? "AI")'s Turn"
            }

            if self.gameLogic.isGameOver == true {
                if self.gameLogic.checkForWin() {
                    self.showResult("AI won!")
                } else if self.gameLogic.checkForDraw() {
                    self.showResult("It's a draw")
                }
            }
        }
    }

    // MARK: Actions
    @objc func handleCellTap(_ sender: UITapGestureRecognizer) {
        if gameLogic.isGameOver {
            return
        }
        if let imageView = sender.view as? UIImageView {
            let imageViewTag = imageView.tag
            if gameLogic.gameBoard[imageViewTag] == nil {
                gameLogic.makeMove(at: imageViewTag)
                
                UIView.animate(withDuration: 0.2, animations: {
                    imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5) // Scale down
                }) { _ in
                    UIView.animate(withDuration: 0.2) {
                        imageView.transform = CGAffineTransform.identity // Reset to normal scale
                    }
                }
                
                imageView.image = UIImage(named: "Player1")
                playersTurnLabel.text = "\(playerName ?? "Player")'s Turn"
                if gameLogic.isGameOver == true {
                    if gameLogic.checkForWin() {
                        showResult("\(playerName ?? "Player") is won!")
                    } else if gameLogic.checkForDraw() {
                        showResult("It's a draw")
                    }
                }
                
                // Let the AI make its move
                DispatchQueue.global(qos: .background).async {
                    self.performAIPlayerMove()
                }
            }
        }
    }
}
