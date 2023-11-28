//
//  FriendCellView.swift
//  InterviewKOKOFriend
//
//  Created by allen on 2023/11/22.
//

import UIKit

class FriendCellView: UITableViewCell {

    @IBOutlet weak var isTopImg: UIImageView!
    
    @IBOutlet weak var friendImageView: UIImageView!
   
    @IBOutlet weak var friendName: UILabel!
    
    @IBOutlet weak var transferBtn: GradientButton!
    
    @IBOutlet weak var inviteBtn: GradientButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
