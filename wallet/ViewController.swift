//
//  ViewController.swift
//  wallet
//
//  Created by Matis Luzi on 9/17/19.
//  Copyright © 2019 Matis Luzi. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class ViewController: UIViewController {
    
    // history vars
    var purchaseNameHis:String!
    var purchaseDateHis:String!
    var purchaseAmountHis:Double!
    
    var purchaseNames:[String] = []
    var purchaseDates:[String] = []
    var purchaseAmounts:[Double] = []
    
    @IBOutlet var mainView: UIView!
    var className = "ViewController"
    var KBHeight: Double? = 0
    // CONSTRAINTS
    
    @IBOutlet var b_btn: NSLayoutConstraint!
    @IBOutlet var b_tf2_btn: NSLayoutConstraint!
    @IBOutlet var c_tf1: NSLayoutConstraint!
    @IBOutlet var b_l1_tf1: NSLayoutConstraint!
    @IBOutlet var b_tf1_tf2: NSLayoutConstraint!
    
    var b_l1_tf1_old:Double! = 0
    var b_tf2_btn_old:Double! = 0
    
    //==================

    @IBOutlet var moneyLeft: UILabel!
    @IBOutlet var addPurchaseButton: UIButton!
    @IBOutlet var purchaseName: UITextField!
    @IBOutlet var purchaseAmount: UITextField!
    
    let defaults = UserDefaults.standard
    var setupBool:Bool!
    var savedData:Double?
    var money:Double?
    var purchaseAmountVar:Double?
    var purchaseNameVar:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkForData()
        checkForSetup()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        b_tf2_btn.isActive = false
        b_l1_tf1.isActive = true
        b_l1_tf1.constant = UIScreen.main.bounds.height * 0.1
        c_tf1.isActive = true
        c_tf1.constant = -1 * UIScreen.main.bounds.height * 0.1
        mainView.layoutIfNeeded()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                KBHeight = Double(keyboardSize.height)
            }
            keyboardShowConstraints()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        if (className == "ViewController") {
            keyboardHideConstraints()
        }
        else if (className == "SecondViewController"){
        
        }
        else if (className == "SetupViewController"){
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (setupBool == true) {
            money = round(money!*100) / 100
            self.moneyLeft.text = String(money!)+" KM"
        }
        addPurchaseButton.layer.cornerRadius = 10
        addPurchaseButton.backgroundColor = UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
    }
    override func viewDidAppear(_ animated: Bool) {
        if (setupBool==false){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let setupViewController = storyBoard.instantiateViewController(withIdentifier: "setup")
            self.present(setupViewController, animated: false, completion: nil)
        }
    }
    
    @IBAction func addPurchase(_ sender: Any) {
        purchaseAmountVar = Double(purchaseAmount.text!)
        purchaseNameVar = purchaseName.text
        if !(purchaseAmountVar==nil || purchaseNameVar==""){
            money! -= purchaseAmountVar!
            money = round(money!*10) / 10
            self.moneyLeft.text = String(money!) + " KM"
            
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy"
            purchaseDateHis = formatter.string(from: date)
            purchaseAmountHis = purchaseAmountVar!
            if !(purchaseName.text == nil){
                purchaseNameHis = purchaseName.text
            }
            else {
                purchaseNameHis = "No Name"
            }
            addPurchaseToHistory(name: purchaseNameHis, date: purchaseDateHis, amount: purchaseAmountHis)
            saveData()
            purchaseName.text = ""
            purchaseAmount.text = ""
            UIView.transition(with: moneyLeft, duration: 0.25, options: .transitionCrossDissolve, animations: {
                self.moneyLeft.textColor = UIColor(red: 80/255, green: 230/255, blue: 80/255, alpha: 1)
            }, completion: {_ in
                UIView.transition(with: self.moneyLeft, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.moneyLeft.textColor = UIColor.black
                }, completion: nil)
            })
        }
        dismissKeyboard()
    }
    
    func checkForSetup() {
        setupBool = UserDefaults.standard.bool(forKey: "hasSetup")
    }
    
    func checkForData() {
        savedData = defaults.double(forKey: "budgetAmount")
        if (savedData == 0.0) {
            money = 0.0
            saveData()
        }
        else {
            money = savedData!
        }
        purchaseDates = UserDefaults.standard.stringArray(forKey: "purchaseDates") ?? [String]()
        purchaseNames = UserDefaults.standard.stringArray(forKey: "purchaseNames") ?? [String]()
        purchaseAmounts = UserDefaults.standard.array(forKey: "purchaseAmounts") as? [Double] ?? [Double]()
    }
    
    func saveData() {
        defaults.set(money, forKey: "budgetAmount")
        defaults.set(purchaseNames, forKey: "purchaseNames")
        defaults.set(purchaseDates, forKey: "purchaseDates")
        defaults.set(purchaseAmounts, forKey: "purchaseAmounts")
        
    }
    
    
    func keyboardShowConstraints(){
        b_tf2_btn.isActive = true
        b_tf2_btn_old = Double(b_tf2_btn.constant)
        b_tf2_btn.constant = 0.1 * (UIScreen.main.bounds.height + self.view.frame.origin.y)
        c_tf1.isActive = false
        b_l1_tf1.isActive = true
        b_l1_tf1_old = Double(b_l1_tf1.constant)
        b_l1_tf1.constant = 0.1 * (UIScreen.main.bounds.height + self.view.frame.origin.y)
        b_tf1_tf2.constant = 0.05 * (UIScreen.main.bounds.height + self.view.frame.origin.y)
        print(b_tf1_tf2.constant)

        mainView.layoutIfNeeded()
    }
    func keyboardHideConstraints(){
        b_tf2_btn.constant = CGFloat(b_tf2_btn_old)
        b_tf2_btn.isActive = false
        c_tf1.isActive = true
        b_l1_tf1.isActive = true
        b_l1_tf1.constant = UIScreen.main.bounds.height * 0.1
        b_tf1_tf2.constant = 30
        mainView.layoutIfNeeded()
    }
    
    func addPurchaseToHistory(name:String, date:String, amount:Double){
        purchaseNames.append(name)
        purchaseAmounts.append(amount)
        purchaseDates.append(date)
        saveData()
    }
    
}

