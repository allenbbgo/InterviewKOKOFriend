//
//  AddFriendView.swift
//  InterviewKOKOFriend
//
//  Created by allen on 2023/11/17.
//

import Foundation
import UIKit

class AddFriendView:UIView{
    
    @IBOutlet var view:UIView!
    
    @IBOutlet weak var friendView: UIView!
    @IBOutlet weak var friendShadowView: UIView!
    
    
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var friendImageView: UIImageView!
    
    @IBOutlet weak var friendName: UILabel!
    
    @IBOutlet weak var addFriendBtn: UIButton!
    @IBOutlet weak var addCancelBtn: UIButton!
    
    var list:[Response] = []
 
    required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            loadViewFromNib()
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
       
        addFriendBtn.addTarget(self, action: #selector(addFriendAction), for: .touchUpInside)
        addCancelBtn.addTarget(self, action: #selector(cancelAddFriendAction), for: .touchUpInside)
        
    }
    
    
    init(frame: CGRect,list:[Response]) {
        self.list = list
        
        super.init(frame: frame)
        loadViewFromNib()
        
        friendName.text = self.list.first?.name
        friendImageView.image = UIImage(named: "img_friends_list")
        
        addFriendBtn.addTarget(self, action: #selector(addFriendAction), for: .touchUpInside)
        addCancelBtn.addTarget(self, action: #selector(cancelAddFriendAction), for: .touchUpInside)
    }
    
    func updateView(list:[Response])
    {
        self.list = list
        friendName.text = self.list.first?.name
        friendImageView.image = UIImage(named: "img_friends_list")
    }
    
    @objc func toggleView()
    {
        print("toggle")
    }
    
    @objc func addFriendAction()
    {
        print("addFriendAction")
    }
    
    @objc func cancelAddFriendAction()
    {
        print("cancelAddFriendAction")
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
