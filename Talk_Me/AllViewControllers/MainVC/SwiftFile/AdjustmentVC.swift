//
//  AdjustmentVC.swift
//  Talk_Me
//
//  Created by Abdusamad Mamasoliyev on 30/12/23.
//

import UIKit

class AdjustmentVC: UIViewController {

    @IBOutlet weak var labelColorView: UIView!
    @IBOutlet weak var labelColorWell: UIColorWell!
    @IBOutlet weak var labelEditTF: UITextField!
    @IBOutlet weak var profilColorView: UIView!
    @IBOutlet weak var profilColorWell: UIColorWell!
    @IBOutlet weak var saveBtn: UIButton!
    
    var closure: ((Adjustment) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAllAdjustment()
    }
    // MARK: Setting AdjustMent and ColerWell
    func setupAllAdjustment() {
        
        labelColorWell.addTarget(self, action: #selector(labelColorBtn), for: .valueChanged)
        profilColorWell.addTarget(self, action: #selector(profilColorBtn), for: .valueChanged)
        saveBtn.layer.cornerRadius = 15
    }
    
    @objc func labelColorBtn() {
        labelColorView.backgroundColor = labelColorWell.selectedColor
        
    }
    
    @objc func profilColorBtn() {
        profilColorView.backgroundColor = profilColorWell.selectedColor
    }
    
    // MARK: Setting Dismiss Button
    @IBAction func disBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // MARK: Setting Save Button
    @IBAction func saveBtn(_ sender: UIButton) {
        
        let adjustment = Adjustment(labelColor: labelColorView.backgroundColor ?? .white,
                                    viewColor: profilColorView.backgroundColor ?? .black,
                                    labelEdit: labelEditTF.text ?? "iDevFan")
        
        if let closure {
            closure(adjustment)
        }
        dismiss(animated: true)
    }
}
