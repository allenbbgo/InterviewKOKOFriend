//
//  ViewController.swift
//  InterviewKOKOFriend
//
//  Created by allen on 2023/11/17.
//

import UIKit
import Combine
import SwiftUI

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var mTabView: TabbarView!
    
    @IBOutlet weak var mOwnAccountView: OwnAccountView!
    
    @IBOutlet weak var mTopbarView: TopbarView!
    
    @IBOutlet weak var mAddFriendView: UIView!
    
    @IBOutlet weak var mAddfriendHeight: NSLayoutConstraint!
    @IBOutlet weak var mOwnAccountViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var mTopContenStack: UIStackView!
    
    
    @IBOutlet weak var mCotentView: FriendTableview!
    
    
    var mainViewModel:mainViewModel!
    
    var viewToggle:Bool = false
    var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        print("viewDidLoad")
        
        var image = UIImage(named: "ic_navpink_scan")
        image = image?.withRenderingMode(.alwaysOriginal)
        let logoutBarButtonItem = UIBarButtonItem(image:image, style: .done, target: self, action: #selector(showComboView))
        
        var imageWithdraw = UIImage(named: "ic_nav_pink_withdraw")
        imageWithdraw = imageWithdraw?.withRenderingMode(.alwaysOriginal)
        let withdrawBarButtonItem = UIBarButtonItem(image:imageWithdraw, style: .done, target: self, action: #selector(showComboView))
        var imageTransfer = UIImage(named: "ic_nav_pink_transfer")
        imageTransfer = imageTransfer?.withRenderingMode(.alwaysOriginal)
        let transferBarButtonItem = UIBarButtonItem(image:imageTransfer, style: .done, target: self, action: #selector(showComboView))
        
        
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
        self.navigationItem.leftBarButtonItems = [withdrawBarButtonItem,transferBarButtonItem]
        
        
        
       
        
        
    }
    
    @objc func showComboView(){
        let listView = ComboViewController()
        let nav = UINavigationController(rootViewController: listView)
        self.present(nav, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        
        let tabview = InterviewKOKOFriend.mainViewModel(viewController: self)
        mainViewModel = tabview
        
        self.hideKeyboardWhenTappedAround()
        

        
    }
    
    

}





