//
//  ProfilVC.swift
//  Talk_Me
//
//  Created by Abdusamad Mamasoliyev on 29/11/23.
//

import UIKit
import FirebaseAuth

class ProfilVC: UIViewController {

    @IBOutlet weak var conteneirView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        conteneirView.layer.cornerRadius = 30
        navBar()
    }
    
    // MARK: Setting Navigation Controller
    func navBar() {
        
        let logOut = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"), style: .done, target: self, action: #selector(logOut))
        navigationItem.rightBarButtonItem = logOut
        logOut.tintColor = .systemYellow
        
    }

    @objc func logOut() {
        
        let alert = UIAlertController(title: "Haqiqatdan ham ilovani tark etmoqchimisiz?", message: nil, preferredStyle: .alert)
        
        let ha = UIAlertAction(title: "Ha", style: .default) { _ in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                let vc = WelcomeVC(nibName: "WelcomeVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
                
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
        let orqaga = UIAlertAction(title: "Orqaga", style: .cancel)
        
        alert.addAction(orqaga)
        alert.addAction(ha)
        self.present(alert, animated: true)
    }
}


