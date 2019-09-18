//
//  SecondViewController.swift
//  wallet
//
//  Created by Matis Luzi on 9/17/19.
//  Copyright © 2019 Matis Luzi. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet var secondView: UIView!
    // CONSTRAINTS
    @IBOutlet var tf_c: NSLayoutConstraint!
    @IBOutlet var b_tf_btn: NSLayoutConstraint!
    // =============
    
    var className = "SecondViewController"
    var KBHeight:Double?
    @IBOutlet var newAmountField: UITextField!
    @IBOutlet var continueButton: UIButton!
    
    var newAmount: Double? = 0
    let firstViewController = ViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(className)
        
        continueButton.layer.cornerRadius = 10
        continueButton.backgroundColor = UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        b_tf_btn.isActive = false
        secondView.layoutIfNeeded()
    }
    
    @IBAction func editBudget(_ sender: Any) {
        newAmount = Double(newAmountField.text!)
        if !(newAmount==nil) {
            firstViewController.checkForData()
            firstViewController.money = newAmount!
            firstViewController.saveData()
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyBoard.instantiateViewController(withIdentifier: "nav_root")
            self.present(mainViewController, animated: true, completion: nil)
        }
        dismissKeyboard()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                KBHeight = Double(keyboardSize.height)
            }
        }
        if (className == "ViewController") {
            
        }
        else if (className == "SecondViewController"){
            keyboardShowConstraintsSecond()
        }
        else if (className == "SetupViewController"){
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        if (className == "ViewController") {
        
        }
        else if (className == "SecondViewController"){
            keyboardHideConstraintsSecond()
        }
        else if (className == "SetupViewController"){
            
        }
    }
    
    func keyboardShowConstraintsSecond(){
        tf_c.isActive = false
        b_tf_btn.isActive = true
        b_tf_btn.constant = 0.1 * UIScreen.main.bounds.height
        secondView.layoutIfNeeded()
    }
    func keyboardHideConstraintsSecond(){
        tf_c.isActive = true
        b_tf_btn.isActive = false
        secondView.layoutIfNeeded()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
