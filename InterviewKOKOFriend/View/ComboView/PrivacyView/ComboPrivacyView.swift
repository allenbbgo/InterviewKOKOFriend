//
//  ComboPrivacyView.swift
//  InterviewKOKOFriend
//
//  Created by allen on 2023/11/24.
//


import Foundation
import UIKit


class ComboPrivacyView:UIView{
    
    @IBOutlet weak var privacyLabel: UILabel!
    
    var stepLabel: NSAttributedString = {
       
        var content = AttributedString()
        
        var setpValue = AttributedString("考量個人的隱私權益，想確認你是否同意 ")
        setpValue.font = .systemFont(ofSize: 13)
        setpValue.foregroundColor = UIColor.systemGray2
        
        
        content += setpValue
        
        var maxValue = AttributedString("個資保護法告知內容第六點個別條款？")
        maxValue.font = .systemFont(ofSize: 13)
        maxValue.underlineColor = accentColor
        maxValue.underlineStyle = .single
        maxValue.foregroundColor = accentColor

        content += maxValue
        
        
        return NSAttributedString(content)
    }()
 
    required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            loadViewFromNib()
        
        privacyLabel.attributedText = stepLabel
        
        
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
//        self.view = view
        
        
        
    }
}

