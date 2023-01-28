//
//  MessageTableViewCell.swift
//  Sour Chat
//
//  Created by Nick Khachatryan on 12.02.2021.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    
    // MARK: OUTLETS
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var chatBG: UIImageView!
    @IBOutlet weak var avatarBoyIMG: UIImageView!
    @IBOutlet weak var avatarGirlIMG: UIImageView!
    
    
    // MARK: VC LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
