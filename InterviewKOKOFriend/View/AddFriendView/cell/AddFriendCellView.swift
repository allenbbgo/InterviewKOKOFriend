//
//  AddFriendCellView.swift
//  InterviewKOKOFriend
//
//  Created by allen on 2023/11/21.
//

import UIKit

class AddFriendCellView: UITableViewCell {

    @IBOutlet weak var friendView: UIView!
    
    
    
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var friendImageView: UIImageView!
    
    @IBOutlet weak var friendName: UILabel!
    
    @IBOutlet weak var addFriendBtn: UIButton!
    @IBOutlet weak var addCancelBtn: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
