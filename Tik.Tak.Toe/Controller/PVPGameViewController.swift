//
//  PVPGameViewController.swift
//  Tik.Tak.Toe
//
//  Created by Bogdan Livanov on 2023-09-08.
//

import UIKit

class PVPGameViewController: UIViewController {
    
    

    @IBOutlet weak var lblScore: UILabel!
    
    @IBOutlet weak var lblPlayer1: UILabel!
    @IBOutlet weak var lblPlayer2: UILabel!
    
    
    var p1receivedText: String?
    var p2receivedText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let text = p1receivedText {
                lblPlayer1.text = text
            }
            
        if let text = p2receivedText {
            lblPlayer2.text = text
        }

    }
    
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        // Identify which UIImageView was tapped
        if let imageView = sender.view as? UIImageView {
            let imageViewTag = imageView.tag
            print("Empty Cell with tag \(imageViewTag) was tapped.")
            //print("cell pressed")
        }
    }
    
}
