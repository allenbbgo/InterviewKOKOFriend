//
//  EmptyFriendView.swift
//  InterviewKOKOFriend
//
//  Created by allen on 2023/11/22.
//

import UIKit

class EmptyFriendView: UIView {

    @IBOutlet weak var addFrienBtn: GradientButton!
    
       required public init?(coder aDecoder: NSCoder) {
               super.init(coder: aDecoder)
               loadViewFromNib()
           
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
//           self.view = view
           
           
           
       }

}
