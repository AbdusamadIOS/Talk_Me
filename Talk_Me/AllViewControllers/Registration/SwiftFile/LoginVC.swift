//
//  LoginVC.swift
//  Talk_Me
//
//  Created by Abdusamad Mamasoliyev on 29/11/23.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var ogohlantirish2Lbl: UILabel!
    @IBOutlet weak var ogohlantirishLbl: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var parolTF: UITextField!
    @IBOutlet weak var conteneirView: UIView!
    @IBOutlet weak var singUpBtn: UIButton!
    @IBOutlet weak var goBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        conteneirView.layer.cornerRadius = 30
        singUpBtn.layer.cornerRadius = 15
        goBtn.layer.cornerRadius = 15
        navigationItem.hidesBackButton = true
        setTextField()
        configureTapGuest()
    }

    // MARK: Setting TextField
    private func setTextField() {
        
        emailTF.delegate = self
        parolTF.delegate = self
    }
    
    // MARK: Setting UITapGesture
    private func configureTapGuest() {
        
        let tapGuest = UITapGestureRecognizer(target: self, action: #selector(tapGestBtn))
        view.addGestureRecognizer(tapGuest)
    }
    
    @objc func tapGestBtn() {
        
        view.endEditing(true)
    }
    
    // MARK: Setting SingUp Button
    @IBAction func singUpBtn(_ sender: Any) {
        
        let vc = SingUPVC(nibName: "SingUPVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Setting Go Button
    @IBAction func goBtn(_ sender: Any) {
        
        if let email = emailTF.text, let password = parolTF.text {
            Auth.auth().signIn(withEmail: email, password: password) { [self] authResult, error in
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
    
    // MARK: Setting Hidden Text Button
    @IBAction func eyeBtn(_ sender: UIButton) {
        if parolTF.isSecureTextEntry == true {
            parolTF.isSecureTextEntry = false
            sender.setImage(UIImage(systemName: "eye.slash.circle"), for: .normal)
        } else if parolTF.isSecureTextEntry == false {
            parolTF.isSecureTextEntry = true
            sender.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        }
    }
}

// MARK: TextField Delegate
extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
