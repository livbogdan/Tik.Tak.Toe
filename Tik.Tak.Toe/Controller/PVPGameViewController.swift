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
    var gameOver = false
    
    let winCombination:[[Int]] = [
        [1, 2, 3], [4, 5, 6], [7, 8, 9], // Rows
        [1, 4, 7], [2, 5, 8], [3, 6, 9], // Columns
        [1, 5, 9], [3, 5, 7]] // Diagonals
    
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
    
    func checkForWin() -> Bool {
        for combination in winCombination {
            if let player = gameBoard[combination[0]],
                player == gameBoard[combination[1]],
                player == gameBoard[combination[2]] {
                return true
            }
        }
        return false
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
                
                if checkForWin() {
                    gameOver = true
                    print("\(currentPlayer) Win!!!")
                } else {
                    // Switch to the other player
                    currentPlayer = (currentPlayer == .X) ? .O : .X
                }
                // Disable the gesture recognizer for this cell
                imageView.isUserInteractionEnabled = false
            }
        }
        
    }
}
