import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    

    var isEdit = false
    
    //Player name
    @IBOutlet weak var lblPlayer1: UILabel!
    @IBOutlet weak var lblPlayer2: UILabel!
    
    //PLayer Text Field
    @IBOutlet weak var tfPlayer1: UITextField!
    @IBOutlet weak var tfPlayer2: UITextField!
    
    //Player Edit Button
    @IBOutlet weak var btnEditNamePLayer1: UIButton!
    @IBOutlet weak var btnEditNamePlayer2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfPlayer1.isHidden = true
        tfPlayer1.delegate = self
        tfPlayer2.isHidden = true
        tfPlayer2.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: Fix print line and set UI image
    @IBAction func editNamePlayer1(_ sender: UIButton) {
        
        if isEdit {
            // Save the edited name and update the label
            if let editedName = tfPlayer1.text {
                lblPlayer1.text = editedName
            }
            // Hide the text field and show the label
            tfPlayer1.isHidden = true
            lblPlayer1.isHidden = false
            btnEditNamePLayer1.setImage(UIImage(systemName: "square.fill"), for: .normal)
            print("Current name is \(lblPlayer2.text ?? "")")
        } else {
            // Resign first responder for Player 1's text field
            tfPlayer2.resignFirstResponder()
            // Start editing
            tfPlayer1.text = lblPlayer1.text
            tfPlayer1.isHidden = false
            lblPlayer1.isHidden = true
            btnEditNamePLayer1.setImage(UIImage(systemName: "multiply"), for: .normal)
            tfPlayer1.becomeFirstResponder() // Show the keyboard
            print("\(lblPlayer1.text ?? "") named to \(lblPlayer1.text ?? "")")
        }
        
        isEdit = !isEdit
        
    }

    //MARK: Fix print line and set UI image
    @IBAction func editNamePlayer2(_ sender: UIButton) {
        
        if isEdit {
            // Save the edited name and update the label
            if let editedName = tfPlayer2.text {
                lblPlayer2.text = editedName
            }
            // Hide the text field and show the label
            tfPlayer2.isHidden = true
            lblPlayer2.isHidden = false
            btnEditNamePlayer2.setTitle("Edit Name", for: .normal)
            print("Current name is \(lblPlayer2.text ?? "")")
        } else {
            // Resign first responder for Player 2's text field
            tfPlayer1.resignFirstResponder()
            // Start editing
            tfPlayer2.text = lblPlayer2.text
            tfPlayer2.isHidden = false
            lblPlayer2.isHidden = true
            btnEditNamePlayer2.setTitle("Save Name", for: .normal)
            tfPlayer2.becomeFirstResponder()// Show the keyboard

            print("\(lblPlayer2.text ?? "") named to \(lblPlayer2.text ?? "")")
        }
        
        isEdit = !isEdit
    }
}
