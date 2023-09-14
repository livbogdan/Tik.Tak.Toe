import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    //Bool for Edit Button
    var isEditingPlayer = false
    
    // Segue Identifiers
    let playerVsPlayerSegue = "PlayerVsPlayerSegue"
    let playerVsAISegue = "PlayerVsAISegue"
    
    //Players labels
    @IBOutlet weak var player1_Label: UILabel!
    @IBOutlet weak var player2_Label: UILabel!
    
    //Send Players name to another View
    var player1TextToPass: String?
    var player2TextToPass: String?
    
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
        
        // Hide the text fields initially and set their delegates.
        player1_TextField.isHidden = true
        player1_TextField.delegate = self
        player2_TextField.isHidden = true
        player2_TextField.delegate = self
    }
    
    // MARK: - Actions
    
    @IBAction func editNamePlayer1(_ sender: UIButton) {
        if isEditingPlayer {
            
            // Save the edited name and update the label
            if let editedName = player1_TextField.text {
                player1_Label.text = editedName
            }
            
            // Hide the text field and show the label
            player1_TextField.isHidden = true
            player1_Label.isHidden = false
            player1_EditButton.setImage(UIImage(systemName: "pencil"), for: .normal)
            print("New name is \(player1_Label.text ?? "")")
        } else {
            
            // Resign first responder for Player 1's text field
            player2_TextField.resignFirstResponder()
            
            // Start editing
            player1_TextField.text = player1_Label.text
            player1_TextField.isHidden = false
            player1_Label.isHidden = true
            player1_EditButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            player1_TextField.becomeFirstResponder() // Show the keyboard
            print("Old name is \(player1_Label.text ?? "")")
        }
        
        // Toggle the edit state.
        isEditingPlayer = !isEditingPlayer
        
    }

    @IBAction func editNamePlayer2(_ sender: UIButton) {
        
        if isEditingPlayer {
            
            // Save the edited name and update the label
            if let editedName = player2_TextField.text {
                player2_Label.text = editedName
            }
            
            // Hide the text field and show the label
            player2_TextField.isHidden = true
            player2_Label.isHidden = false
            player2_EditButton.setImage(UIImage(systemName: "pencil"), for: .normal)
            print("New name is \(player2_Label.text ?? "")")
        } else {
            
            // Resign first responder for Player 2's text field
            player1_TextField.resignFirstResponder()
            
            // Start editing
            player2_TextField.text = player2_Label.text
            player2_TextField.isHidden = false
            player2_Label.isHidden = true
            player2_EditButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            player2_TextField.becomeFirstResponder()// Show the keyboard

            print("Old name is \(player2_Label.text ?? "")")
        }
        
        // Toggle the edit state.
        isEditingPlayer = !isEditingPlayer
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
                destinationVC.p1receivedText = player1_Label.text
                destinationVC.p2receivedText = player2_Label.text
            }
        }
        
        if segue.identifier == playerVsAISegue {
            if segue.destination is PVEViewController {
                if let destinationVC = segue.destination as? PVEViewController {
                    destinationVC.p1receivedText = player1_Label.text
                }
            }
        }
    }
}
