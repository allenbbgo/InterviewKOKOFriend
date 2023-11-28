//
//  Content.swift
//  InterviewKOKOFriend
//
//  Created by allen on 2023/11/17.
//

import Foundation
import UIKit

//test API Data Type
//自行切換測試資料格式
var apiTestContentType:APITestList = .APITestbyURL

let accentColor = UIColor(named: "SelectOnTabbar")
let badgeColor = UIColor(named: "BadgeColor")


public enum tabBarItem{
    case wallets
    case friends
    case accounting
    case setting
    
    var buttonContent:tabButton
    {
        switch self {
        case .wallets:
           let button = tabButton()
            button.tabImage.image = UIImage(named: "ic_tabbar_products")
            button.tabImage.image =  button.tabImage.image?.withRenderingMode(.alwaysOriginal)
            button.tabLabel.text = "錢錢"
            return button
        case .friends:
            let button = tabButton()
             button.tabImage.image = UIImage(named: "ic_tabbar_friends")
             button.tabImage.image =  button.tabImage.image?.withRenderingMode(.alwaysOriginal)
             button.tabLabel.text = "朋友"
            button.tabLabel.textColor = UIColor(named: "SelectOnTabbar")
            return button
        case .accounting:
            let button = tabButton()
             button.tabImage.image = UIImage(named: "ic_tabbar_manage")
             button.tabImage.image =  button.tabImage.image?.withRenderingMode(.alwaysOriginal)
             button.tabLabel.text = "計算"
            return button
        case .setting:
            let button = tabButton()
             button.tabImage.image = UIImage(named: "ic_tabbar_setting")
            button.tabImage.image =  button.tabImage.image?.withRenderingMode(.alwaysOriginal)
             button.tabLabel.text = "設定"
            return button
        }
    }
    
    
    
}

public enum topBarItem{
    case friends
    case chat
    
    
    var buttonContent:TopbarButton{
        switch self{
        case .friends:
            let button = TopbarButton(badgeText: "2")
            button.topbarLabel.text = "好友"
            button.topbarImage.tintColor = accentColor
            button.topbarImage.layer.cornerRadius = 4
            button.badgeText = "2"
            return button
        case .chat:
            let button = TopbarButton(badgeText: "99+")
            button.topbarLabel.text = "聊天"
            button.topbarImage.tintColor = accentColor
            button.topbarImage.layer.cornerRadius = 4
            button.badgeText = "99+"
            return button
        }
    }

}




func addBadge(text:String) -> UIImageView{
    
    if text.isEmpty {
        return UIImageView()
    }
    
    let shapeView = UIImageView()
    shapeView.image = UIImage(systemName: text.count > 1 ? "capsule.fill":"circle.fill")
    
    shapeView.contentMode = .scaleAspectFill
    
    shapeView.image =  shapeView.image!.withRenderingMode(.alwaysTemplate)
    shapeView.tintColor = badgeColor

    
    let badgeText = UILabel(frame: CGRect(x:0,y:0,width: 30, height: 25))
    badgeText.text = text
    badgeText.textColor = .white
    badgeText.font = badgeText.font.withSize(12)
    
    shapeView.addSubview(badgeText)
    
    badgeText.snp.makeConstraints { make in

        make.center.equalTo(shapeView)

    }
    
    return shapeView
}


enum APITestList{
    case APITestUserID
    case APITestFriend1
    case APITestFriend2
    case APITestFriendWithAdd
    case APITestEmptyFriend
    case APITestbyURL
    
    
    
    var list:KOKOFriend {
        switch self {
        case .APITestUserID:
            return Bundle.main.decode("APITestUser.json")
        case .APITestFriend1:
            return Bundle.main.decode("APITestFriend1.json")
        case .APITestFriend2:
            return Bundle.main.decode("APITestFriend2.json")
        case .APITestFriendWithAdd:
            return Bundle.main.decode("APITestFirendWithAdd.json")
        case .APITestEmptyFriend:
            return Bundle.main.decode("APITestEmptyFriend.json")
        case .APITestbyURL:

            return Bundle.main.decode("APITestEmptyFriend.json")
            
        }
        
    }
}


import Foundation

// MARK: - KOKOFriend
class KOKOFriend: Codable {
    let response: [Response]

    init(response: [Response]) {
        self.response = response
    }
}

// MARK: - Response
class Response: Codable {
    var name: String
    var status: Int?
    var isTop, fid, updateDate: String?
    var kokoid:String?

    init(name: String = "", status: Int = 0, isTop: String = "", fid: String = "", updateDate: String = "",kokoid:String = "") {
        self.name = name
        self.status = status
        self.isTop = isTop
        self.fid = fid
        self.updateDate = updateDate
        self.kokoid = kokoid
    }
}

