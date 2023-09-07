//
//  ViewController.swift
//  Tik.Tak.Toe
//
//  Created by Bogdan Livanov on 2023-09-07.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Edit Player Name Outlet
    
    @IBOutlet weak var lblPlayer1: UILabel!
    @IBOutlet weak var lblPlayer2: UILabel!
    @IBOutlet weak var txtFldChangeName: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var btnEditNamePLayer1: UIButton!
    @IBOutlet weak var btnEditNamePlayer2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFldChangeName.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func editNamePlayer1(_ sender: UIButton) {
        
        lblPlayer1.isHidden = true
        lblPlayer2.isHidden = true
        txtFldChangeName.isHidden = false
        txtFldChangeName.text = lblPlayer1.text
        btnEditNamePLayer1.isHidden = true
        btnEditNamePlayer2.isHidden = false
        btnSave.isHidden = false
        print("Edit Player 1 name to \(lblPlayer1.text)")
    }
    
    
    @IBAction func editNamePlayer2(_ sender: UIButton) {
        lblPlayer1.isHidden = true
        lblPlayer2.isHidden = true
        txtFldChangeName.isHidden = false
        txtFldChangeName.text = lblPlayer2.text
        btnEditNamePLayer1.isHidden = false
        btnEditNamePlayer2.isHidden = true
        btnSave.isHidden = false
        print("Edit Player 2 name to \(lblPlayer2.text)")
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        if txtFldChangeName.isHidden == false {
            if btnEditNamePLayer1.isHidden == true {
                // Editing Player 1's name
                lblPlayer1.text = txtFldChangeName.text
            } else if btnEditNamePlayer2.isHidden == true {
                // Editing Player 2's name
                lblPlayer2.text = txtFldChangeName.text
            }
            
            lblPlayer1.isHidden = false
            lblPlayer2.isHidden = false
            txtFldChangeName.isHidden = true
            btnEditNamePLayer1.isHidden = false
            btnSave.isHidden = true
        }
        
    }
    
}
