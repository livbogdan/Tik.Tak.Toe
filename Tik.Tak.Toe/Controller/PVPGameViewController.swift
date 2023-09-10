//
//  PVPGameViewController.swift
//  Tik.Tak.Toe
//
//  Created by Bogdan Livanov on 2023-09-08.
//

import UIKit

class PVPGameViewController: UIViewController {
    
    enum Player {
        case X
        case O
    }
    
    @IBOutlet weak var lblScore: UILabel!
    
    @IBOutlet weak var lblPlayer1: UILabel!
    @IBOutlet weak var lblPlayer2: UILabel!
    
    var p1receivedText: String?
    var p2receivedText: String?
    
    var currentPlayer: Player = .X
    var gameBoard: [Int: Player] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let text = p1receivedText {
            lblPlayer1.text = text
        }
        
        if let text = p2receivedText {
            lblPlayer2.text = text
        }
        
        for i in 1...9 {
            gameBoard[i] = nil
        }
    }
    
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
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
                } else {
                    imageView.image = UIImage(named: "Player2")
                    gameBoard[imageViewTag] = .O
                    print("0 Cell with tag \(imageViewTag) was tapped.")
                }
                
                // Switch to the other player
                currentPlayer = (currentPlayer == .X) ? .O : .X
                
                // Disable the gesture recognizer for this cell
                imageView.isUserInteractionEnabled = false
            }
        }
        
    }
}
