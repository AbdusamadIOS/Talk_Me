//
//  SingUPVC.swift
//  Talk_Me
//
//  Created by Abdusamad Mamasoliyev on 29/11/23.
//

import UIKit
import FirebaseAuth

class SingUPVC: UIViewController {

    @IBOutlet weak var ogohlantirish2Lbl: UILabel!
    @IBOutlet weak var ogohlantirishLbl: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var parolTF: UITextField!
    @IBOutlet weak var conteneirView: UIView!
    @IBOutlet weak var goBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        conteneirView.layer.cornerRadius = 30
        goBtn.layer.cornerRadius = 15
        loginBtn.layer.cornerRadius = 15
        navigationItem.hidesBackButton = true
        setTextField()
        configurTapGuest()
    }
    
    private func setTextField() {
        
        emailTF.delegate = self
        parolTF.delegate = self
        
    }
    
    private func configurTapGuest() {
        
        let tapGuest = UITapGestureRecognizer(target: self, action: #selector(tapGuestBtn))
        view.addGestureRecognizer(tapGuest)
    }
    @objc func tapGuestBtn() {
        
        view.endEditing(true)
    }

    @IBAction func goBtn(_ sender: UIButton) {
                
        if let email = emailTF.text, let password = parolTF.text{
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    self.ogohlantirishLbl.isHidden = false
                    self.ogohlantirish2Lbl.isHidden = false
                } else {
                    let go = TalkVC(nibName: "TalkVC", bundle: nil)
                    self.navigationController?.pushViewController(go, animated: true)
                }
            }
        }
    }
    @IBAction func eyeBtn(_ sender: UIButton) {
        
        if parolTF.isSecureTextEntry == true {
            
            parolTF.isSecureTextEntry = false
            sender.setImage(UIImage(systemName: "eye.slash.circle"), for: .normal)
        } else if parolTF.isSecureTextEntry == false {
            parolTF.isSecureTextEntry = true
            sender.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        }
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        
        let login = LoginVC(nibName: "LoginVC", bundle: nil)
        
        navigationController?.pushViewController(login, animated: true)
    }
    
}

extension SingUPVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
