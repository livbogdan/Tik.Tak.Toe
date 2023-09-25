import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    //Bool for Edit Button
    var isEditingPlayer = false
    
    // Segue Identifiers
    let playerVsPlayerSegue = "PlayerVsPlayerSegue"
    let playerVsAISegue = "PlayerVsAISegue"
    
    //Players labels
    @IBOutlet weak var PlayerNameView: UIView!
    @IBOutlet weak var player1_Label: UILabel!
    @IBOutlet weak var player2_Label: UILabel!
    @IBOutlet weak var Titel: UILabel!
    
    //Send Players name to another View
    var player1TextToPass = "Player 1"
    var player2TextToPass = "Player 2"
    
    //PLayers Text Field
    @IBOutlet weak var player1_TextField: UITextField!
    @IBOutlet weak var player2_TextField: UITextField!
    
    //Player Edit Button
    @IBOutlet weak var player1_EditButton: UIButton!
    @IBOutlet weak var player2_EditButton: UIButton!
    
    //Navigation Button
    @IBOutlet weak var playVsPlayerButton: UIButton!
    @IBOutlet weak var playVsAIButtonplayVsAIButton: UIButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    func setupUI(){
        view.backgroundColor = .lightGray
        
        player1_Label.textColor = .black
        player1_Label.backgroundColor = .clear
        player1_Label.layer.cornerRadius = 5
        player1_Label.layer.borderWidth = 1
        player1_Label.layer.borderColor = UIColor(ciColor: .black).cgColor
        
        player2_Label.textColor = .black
        player2_Label.backgroundColor = .clear
        player2_Label.layer.cornerRadius = 5
        player2_Label.layer.borderWidth = 1
        player2_Label.layer.borderColor = UIColor(ciColor: .black).cgColor
        
        
        // Hide the text fields initially and set their delegates.
        player1_TextField.isHidden = true
        player1_TextField.delegate = self
        player2_TextField.isHidden = true
        player2_TextField.delegate = self
    }
    
    private func editPlayerName(playerLabel: UILabel, textField: UITextField, editButton: UIButton) {
		if textField.isHidden {
			// Entering edit mode
			textField.text = playerLabel.text
			textField.isHidden = false
			playerLabel.isHidden = true
			editButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
			textField.becomeFirstResponder()
		} else {
			// Exiting edit mode
			if let editedName = textField.text {
				playerLabel.text = editedName
			}
			textField.isHidden = true
			playerLabel.isHidden = false
			editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
			textField.resignFirstResponder()
		}
    }
    
    // MARK: - Actions
    
    @IBAction func editNamePlayer1(_ sender: UIButton) {
        editPlayerName(playerLabel: player1_Label, textField: player1_TextField, editButton: player1_EditButton)
        
    }

    @IBAction func editNamePlayer2(_ sender: UIButton) {
        
        editPlayerName(playerLabel: player2_Label, textField: player2_TextField, editButton: player2_EditButton)
    }
    
    // Action to start a player vs. player game.
    @IBAction func startGamePVP(_ sender: UIButton) {
        performSegue(withIdentifier: playerVsPlayerSegue, sender: self)
    }
    
    // Action to start a player vs. environment (PVE) game.
    @IBAction func startGamePVE(_ sender: UIButton) {
        performSegue(withIdentifier: playerVsAISegue, sender: self)
    }
    
    
    // Prepare for segue to pass player names to the destination view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == playerVsPlayerSegue {
            if let destinationVC = segue.destination as? PVPGameViewController {
                destinationVC.player1Name = player1_Label.text
                destinationVC.player2Name = player2_Label.text
            }
        }
        
        if segue.identifier == playerVsAISegue {
            if segue.destination is PVEViewController {
                if let destinationVC = segue.destination as? PVEViewController {
                    destinationVC.playerName = player1_Label.text
                }
            }
        }
    }
}
