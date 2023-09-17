import UIKit

class PVEViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var aiLabel: UILabel!
    @IBOutlet weak var playersTurnLabel: UILabel!
    
    // MARK: Constants
    var backgroundImageName = UIImage(named: "background")
    
    // MARK: Variables
    var playerName: String?
    var aiName: String?
    var playerScore = 0
    var aiScore = 0
    var isGameOver = false
    var gameLogic = TicTacToeGameLogic()
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        gameLogic.resetGame()
    }
    
    // MARK: UI Setup
    func setupUI(){
        if let name = playerName{
            playerLabel.text = name
            playersTurnLabel.text = name
        }
        
        if let name = aiName{
            aiLabel.text = name
        }
        setBackgroundImage()
        updateScoreLabel()
    }
    
    func setBackgroundImage() {
        if let imageView = view.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
            imageView.image = backgroundImageName
        }
    }
    
    //MARK: Game Logic
    
    func resetGameUI() {
        for tag in 1...9 {
            if let imageView = view.viewWithTag(tag) as? UIImageView {
                imageView.image = backgroundImageName
            }
        }
        resetPlayerTurnLabel()
    }
    
    func showMainMenu() {
        if let mainMenuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainMenuViewController") as? ViewController {
            present(mainMenuViewController, animated: true, completion: nil)
        } else {
            print("Error: Unable to instantiate MainMenuViewController")
        }
    }
    
    func showResult(_ result: String) {
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
        }
        
        let exitAction = UIAlertAction(title: "Exit", style: .default) { [weak self] _ in
            self?.showMainMenu()
        }
        
        alertController.addAction(restartAction)
        alertController.addAction(exitAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "\(playerName ?? "Player") = \(playerScore)  \(aiName ?? "AI") = \(aiScore)"
    }
    
    func resetPlayerTurnLabel() {
        if let player1Name = playerName {
            playersTurnLabel.text = "\(player1Name) Turn"
        }
    }
    
    //MARK: Actions
    @IBAction func handleCellTap(_ sender: UITapGestureRecognizer) {
        if gameLogic.isGameOver {
            return
        }
        if let imageView = sender.view as? UIImageView {
            let imageViewTag = imageView.tag
            if gameLogic.gameBoard[imageViewTag] == nil {
                gameLogic.makeMove(at: imageViewTag)
                imageView.image = UIImage(named: "Player1")
                playersTurnLabel.text = "AI Turn"
                if gameLogic.isGameOver {
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
    
    func performAIPlayerMove() {
        // Get the list of empty positions on the game board
        let emptyPositions = gameLogic.getEmptyPositions()
        
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
                imageView.image = UIImage(named: "Player2")
                self.playersTurnLabel.text = "\(self.playerName ?? "AI")'s Turn"
            }
            
            if self.gameLogic.isGameOver {
                if self.gameLogic.checkForWin() {
                    self.showResult("AI won!")
                } else if self.gameLogic.checkForDraw() {
                    self.showResult("It's a draw")
                }
            }
        }
    }
}
