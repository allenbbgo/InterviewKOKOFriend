//
//  TopbarView.swift
//  InterviewKOKOFriend
//
//  Created by allen on 2023/11/17.
//

import Foundation
import UIKit
import SnapKit

class TopbarView:UIView{
    
    @IBOutlet var view:UIView!
    @IBOutlet weak var topbarStack: UIStackView!
    
 
    var friendButton:TopbarButton?
    var chatButton:TopbarButton?
    
    required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            loadViewFromNib()
        
        friendButton = topBarItem.friends.buttonContent
        friendButton?.tag = 1
        
        chatButton = topBarItem.chat.buttonContent
        chatButton?.tag = 2
        
        topbarStack.addArrangedSubview(friendButton!)
        topbarStack.addArrangedSubview(chatButton!)
       
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        

    }
    
    
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
 
        addSubview(view)
        self.view = view
        
        
        
    }
}
