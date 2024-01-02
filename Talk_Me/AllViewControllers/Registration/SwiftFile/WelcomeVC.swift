//
//  WelcomeVC.swift
//  Talk_Me
//
//  Created by Abdusamad Mamasoliyev on 29/11/23.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var singUpbtm: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        singUpbtm.layer.cornerRadius = 15
        loginBtn.layer.cornerRadius = 15
        
    }

    @IBAction func singUpBtn(_ sender: UIButton) {
        
        let sing = SingUPVC(nibName: "SingUPVC", bundle: nil)
        
        navigationController?.pushViewController(sing, animated: true)
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        
        let login = LoginVC(nibName: "LoginVC", bundle: nil)
        
        navigationController?.pushViewController(login, animated: true)
    }
    

}
