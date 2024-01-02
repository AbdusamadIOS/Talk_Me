//
//  TalkCell.swift
//  Talk_Me
//
//  Created by Abdusamad Mamasoliyev on 29/11/23.
//

import UIKit

class TalkCell: UITableViewCell {

    @IBOutlet weak var meConsteneir: NSLayoutConstraint!
    @IBOutlet weak var youConsteneir: NSLayoutConstraint!
    @IBOutlet weak var conteneirView: UIView!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var senderLbl: UILabel!
    @IBOutlet weak var youLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        conteneirView.layer.cornerRadius = conteneirView.frame.height / 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configur(message: Message) {
        
        messageLbl.text = message.message
    }
}

