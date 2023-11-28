//
//  TabbarView.swift
//  InterviewKOKOFriend
//
//  Created by allen on 2023/11/17.
//

import Foundation
import UIKit




open class TabbarView: UIView {
    
    
    @IBOutlet var view: UIView!
    
    
    @IBOutlet weak var homeTabBarItem: UIImageView!
    
    @IBOutlet weak var leftTabBarStack: UIStackView!
    
    @IBOutlet weak var rightTabBarStack: UIStackView!
    
    var walletTabbarItem: tabButton?
    
    var friendTabbarItem: tabButton?
    
    var accountingTabbarItem: tabButton?
    
    var settingTabbarItem: tabButton?
    
    
    required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            loadViewFromNib()
        
        walletTabbarItem = tabBarItem.wallets.buttonContent
        friendTabbarItem = tabBarItem.friends.buttonContent
        accountingTabbarItem = tabBarItem.accounting.buttonContent
        settingTabbarItem = tabBarItem.setting.buttonContent
        
        
        leftTabBarStack.addArrangedSubview(walletTabbarItem!)
        leftTabBarStack.addArrangedSubview(friendTabbarItem!)
        rightTabBarStack.addArrangedSubview(accountingTabbarItem!)
        rightTabBarStack.addArrangedSubview(settingTabbarItem!)
            
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


class tabViewModel {
    var tabView:TabbarView
    
    init(tabView: TabbarView) {
        self.tabView = tabView
    }
    
    func change()
    {
        
    }
    
}
