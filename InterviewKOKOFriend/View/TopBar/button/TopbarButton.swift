//
//  TopbarButton.swift
//  InterviewKOKOFriend
//
//  Created by allen on 2023/11/17.
//


import Foundation
import UIKit




public class TopbarButton: UIButton {
    
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var topbarLabel: UILabel!
    @IBOutlet weak var topbarImage: UIImageView!
    
//    @IBOutlet weak var badgeLabel: UILabel!
    
    var badgeText = ""
    
    var badgeView:UIImageView?
    
    init(badgeText: String) {
        self.badgeText = badgeText
        
        super.init(frame: .zero)
        loadViewFromNib()
        
        
        if !self.badgeText.isEmpty && self.badgeText != "0"{
            badgeView = addBadge(text: badgeText)

            view?.addSubview(badgeView!)
            badgeView!.snp.makeConstraints { make in
                make.top.equalTo(view!.snp.top).offset(-5)
                make.right.equalTo(view!.snp.right).offset(-5)
                make.width.equalTo(30)
                make.height.equalTo(22)

            }
        }
    }
    
    
    func updateBadge(badgeText:String){
        badgeView?.removeFromSuperview()
        
        self.badgeText = badgeText
        if !self.badgeText.isEmpty && self.badgeText != "0"{
            badgeView = addBadge(text: badgeText)

            view?.addSubview(badgeView!)
            badgeView!.snp.makeConstraints { make in
                make.top.equalTo(view!.snp.top).offset(-5)
                make.right.equalTo(view!.snp.right).offset(-12)
                make.width.equalTo(20)
                make.height.equalTo(22)

            }
        }else
        {
            
            badgeView?.removeFromSuperview()
        }
    }

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
        view.isUserInteractionEnabled = false
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
 
        addSubview(view)
        
        
        
        
        
    }
    
    
}
