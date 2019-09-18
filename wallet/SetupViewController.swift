//
//  SetupViewController.swift
//  wallet
//
//  Created by Matis Luzi on 9/17/19.
//  Copyright © 2019 Matis Luzi. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    var KBChange: Double!
    
    @IBOutlet var setupView: UIView!
    // CONSTRAINTS
    
    @IBOutlet var c_tf: NSLayoutConstraint!
    @IBOutlet var b_tf_btn: NSLayoutConstraint!
    @IBOutlet var b_l1_l2: NSLayoutConstraint!
    @IBOutlet var l1_c: NSLayoutConstraint!
    
    //===================
    
    var className = "SetupViewController"
    
    @IBOutlet var goButton: UIButton!
    @IBOutlet var setupBudget: UITextField!
    
    let firstViewController = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(className)
        // Do any additional setup after loading the view.
        
        c_tf.isActive = true
        b_tf_btn.isActive = false
        b_l1_l2.isActive = false
        setupView.layoutIfNeeded()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        l1_c.constant = -1 * UIScreen.main.bounds.height * 0.25
        goButton.backgroundColor = UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
        goButton.layer.cornerRadius = 10
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
            KBChange = Double(keyboardSize.height)
        }
        if (className == "ViewController") {
        
        }
        else if (className == "SecondViewController"){
            
        }
        else if (className == "SetupViewController"){
            keyboardShowConstraintsSetup()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        if (className == "ViewController") {
            
        }
        else if (className == "SecondViewController"){
            
        }
        else if (className == "SetupViewController"){
            keyboardHideConstraintsSetup()
        }
    }
    
    @IBAction func finishSetup(_ sender: Any) {
        let money:Double? = Double(setupBudget.text!)
        if !(money == nil) {
            firstViewController.money = money!
            firstViewController.saveData()
            UserDefaults.standard.set(true, forKey: "hasSetup")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyBoard.instantiateViewController(withIdentifier: "nav_root")
            self.present(mainViewController, animated: true, completion: nil)
        }
        dismissKeyboard()
    }
    
    func keyboardShowConstraintsSetup(){
        l1_c.isActive = false
        c_tf.isActive = false
        b_tf_btn.isActive = true
        b_tf_btn.constant = (UIScreen.main.bounds.height+self.view.frame.origin.y) * 0.1
        b_l1_l2.isActive = true
        b_l1_l2.constant = (UIScreen.main.bounds.height+self.view.frame.origin.y) * 0.05
        setupView.layoutIfNeeded()
        
    }
    func keyboardHideConstraintsSetup(){
        c_tf.isActive = true
        b_tf_btn.isActive = false
        b_l1_l2.isActive = false
        l1_c.isActive = true
        setupView.layoutIfNeeded()
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
