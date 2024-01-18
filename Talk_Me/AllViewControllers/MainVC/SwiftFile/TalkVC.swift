//
//  TalkVC.swift
//  Talk_Me
//
//  Created by Abdusamad Mamasoliyev on 29/11/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class TalkVC: UIViewController {

    @IBOutlet weak var profilView: UIView!
    @IBOutlet weak var mainNameEditLbl: UILabel!
    @IBOutlet weak var conteneirView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    var messages: [Message] = []
    private let databesa = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabView()
        navBar()
        loadMessageFromFB()
        setTextFiled()
        configureTapGuest()
    }
    
    // MARK: Setting TextField
    private func setTextFiled() {
    
        self.messageTF.delegate = self
    }
    private func configureTapGuest() {
        
        let tapGuest = UITapGestureRecognizer(target: self, action: #selector(tapGuestBtn))
        view.addGestureRecognizer(tapGuest)
    }
    @objc func tapGuestBtn() {
        view.endEditing(true)
    }
    
    // MARK: Setting NavigationController
    func navBar() {
        
        navigationItem.hidesBackButton = true
       let profil = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .done, target: self, action: #selector(profil))
       let edit   = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .done, target: self, action: #selector(editBtn))
        navigationItem.rightBarButtonItems = [profil, edit]
        profil.tintColor = .systemYellow
        edit.tintColor   = .systemYellow
        
    }
    
    @objc func editBtn() {
        
        let adjustmentVC = AdjustmentVC(nibName: "AdjustmentVC", bundle: nil)
        adjustmentVC.modalTransitionStyle = .coverVertical
        adjustmentVC.modalPresentationStyle = .popover
        
        adjustmentVC.closure = { [self] adjustment in
              
            mainNameEditLbl.text = adjustment.labelEdit
            profilView.backgroundColor = adjustment.viewColor
            mainNameEditLbl.textColor = adjustment.labelColor
                       
        }
        self.present(adjustmentVC, animated: true)
    }
    @objc func profil() {
        
        let pro = ProfilVC(nibName: "ProfilVC", bundle: nil)
        self.navigationController?.pushViewController(pro, animated: true)
    }
    
    // MARK: Setting TableView
    func setupTabView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TalkCell", bundle: nil), forCellReuseIdentifier: "TalkCell")
    }

    // MARK: Setting Send Button
    @IBAction func sendBtn(_ sender: UIButton) {
        
        let messageBody = messageTF.text
        let sender = Auth.auth().currentUser?.email
        
        if let messageBody = messageBody, let sender = sender {
            databesa.collection(Constants.messages).addDocument(data: [Constants.body: messageBody, Constants.sender: sender, Constants.date: Date().timeIntervalSince1970]) { error in
                if let e = error?.localizedDescription {
                    self.showAlert(title: e)
                }else {
                    self.messageTF.text = ""
                    print("Saved!!!")
                }
            }
        }
    }
    
    // MARK: Setting Load Message
    func loadMessageFromFB() {
        
        databesa.collection(Constants.messages)
            .order(by: Constants.date)
            .addSnapshotListener { snapshot, error in
                self.messages = []
                
                if let errorAlert = error?.localizedDescription {
                    print("Error occured  when receiving data from FB \(error?.localizedDescription ?? "error")")
                    self.showAlert(title: errorAlert)
                } else {
                    if let snapshotDoc = snapshot?.documents {
                        snapshotDoc.forEach { doc in
                            let data = doc.data()
                           print("Data \(data)")
                            if let sender = data[Constants.sender] as? String, let body = data[Constants.body] as? String {
                                let message = Message(sender: sender, message: body)
                                self.messages.append(message)

                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Setting UIAlert
    func showAlert(title: String) {
        
        let alert = UIAlertController(title: "Error", message: title, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}

// MARK: TableView datasource and delegete
extension TalkVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TalkCell", for: indexPath) as! TalkCell
        cell.messageLbl.text  = messages[indexPath.row].message
        var labelAlignment = cell.messageLbl.alignmentRectInsets
        if Auth.auth().currentUser?.email == messages[indexPath.row].sender {
            
            cell.conteneirView.backgroundColor = .white
            cell.youConsteneir.constant = 160
            cell.meConsteneir.constant = 10
            cell.messageLbl.textAlignment = .right
        } else {
            cell.messageLbl.textAlignment = .left
            cell.youConsteneir.constant = 10
            cell.meConsteneir.constant = 160
            cell.conteneirView.backgroundColor = .systemYellow

        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            
            let ochirish = UIAction(title: "Delete", image: UIImage(systemName: "trash")?.withRenderingMode(.alwaysOriginal).withTintColor(.red)) { _ in
                self.messages.remove(at: indexPath.row)
                self.tableView.reloadData()
                
            }
            let remove = UIAction(title: "Remove all messages", image: UIImage(systemName: "minus.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.red)) { _ in
                self.messages.removeAll()
                self.tableView.reloadData()
            }
            return UIMenu(children: [ochirish, remove])
        }
    }
}

// MARK: TextField Delegate
extension TalkVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
