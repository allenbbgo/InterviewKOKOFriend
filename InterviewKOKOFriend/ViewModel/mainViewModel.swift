//
//  mainViewModel.swift
//  InterviewKOKOFriend
//
//  Created by allen on 2023/11/27.
//

import Foundation
import UIKit
import Combine

class mainViewModel: AddFriendBtnDelegate, SearchFriendToggleViewDelegate,FriendTableviewDelegate {
    
    
    
    var vc:ViewController
    var addFriendView1:AddFriendView
    var addFriendTableview:AddFriendTableview
    var emptyFriendView:EmptyFriendView
    var friendTableview:FriendTableview
    
    var viewToggle:Bool
    var contentViewToggle:Bool
    var topBarItemType:topBarItem = .friends
    
    var apiTestType:APITestList = apiTestContentType
    var apiTestUserData:APITestList = .APITestUserID
    
    var allFriendData:[Response] = []
    var addFriendData:[Response] = []
    
    var cancellable: AnyCancellable?
    
    init(viewController:ViewController) {
        self.vc = viewController
        self.viewToggle = false
        self.contentViewToggle = false
        
        
        let apiTestUserData = apiTestUserData.list.response.first
        
        self.vc.mOwnAccountView.kokoIDLabel.text = apiTestUserData?.kokoid
        self.vc.mOwnAccountView.settingIDLabel.text = apiTestUserData?.kokoid?.count == 0 ? "設定 KOKO ID ":"KOKO ID："
        self.vc.mOwnAccountView.settingIDimg.isHidden = apiTestUserData?.kokoid?.count == 0 ? false:true
        self.vc.mOwnAccountView.isEmptyImg.isHidden = apiTestUserData?.kokoid?.count == 0 ? false:true
        self.vc.mOwnAccountView.kokoNameLabel.text = apiTestUserData?.name
        
        addFriendTableview = AddFriendTableview(frame: CGRect(x: 0, y: 0, width: self.vc.mAddFriendView.layer.frame.width, height: 200),list: addFriendData)
        addFriendView1 = AddFriendView(frame: CGRect(x: 0, y: 0, width: self.vc.mAddFriendView.layer.frame.width, height: self.vc.mAddfriendHeight.constant))
        
        addFriendView1 = AddFriendView(frame: CGRect(x: 0, y: 0, width: self.vc.mAddFriendView.layer.frame.width, height: self.vc.mAddfriendHeight.constant),list: addFriendData)

        emptyFriendView = EmptyFriendView(frame: CGRect(x: 0, y: 0, width: self.vc.mCotentView.layer.frame.width, height: self.vc.mCotentView.layer.frame.height))
        
        friendTableview = FriendTableview(frame: CGRect(x: 0, y: 0, width: self.vc.mCotentView.layer.frame.width, height: self.vc.mCotentView.layer.frame.height), list: allFriendData)
        
        friendTableview.searchTextView.toggleViewDelegate = self
        friendTableview.delegate = self
        
        emptyFriendView.addFrienBtn.addTarget(self, action: #selector(showComboView), for: .touchUpInside)
        
        addFriendTableview.delegate = self
        addFriendView1.friendView.addFriendViewShadow()
        addFriendView1.friendShadowView.addFriendBottomViewShadow()
        addFriendView1.toggleBtn.addTarget(self, action: #selector(toggleView), for: .touchUpInside)
        
        self.vc.mTopbarView.friendButton?.addTarget(self, action: #selector(change(_ :)), for: .touchUpInside)
        self.vc.mTopbarView.chatButton?.addTarget(self, action: #selector(change(_ :)), for: .touchUpInside)
        
        switch topBarItemType {
        case .friends:
            self.vc.mTopbarView.friendButton?.topbarImage.isHidden = false
            self.vc.mTopbarView.chatButton?.topbarImage.isHidden = true
        case .chat:
            self.vc.mTopbarView.friendButton?.topbarImage.isHidden = true
            self.vc.mTopbarView.chatButton?.topbarImage.isHidden = false
        }
        
        if apiTestType == .APITestbyURL
        {
            loadingProgressView()
            self.fetchFriendData()
        }else
        {
            self.allFriendData = apiTestType.list.response
            self.addFriendData = allFriendData.filter{
                $0.status == 2
            }
            
            updateListView()

        }
        

    }
    
    func loadingProgressView()
    {
        guard let view = self.vc.view else {return}
        view.blurView(style: .dark)
        var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
         indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
         indicator.center = view.center
         view.addSubview(indicator)
        view.bringSubviewToFront(indicator)
         UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.vc.navigationController?.setNavigationBarHidden(true, animated: true)
        indicator.startAnimating()
    }
    
   @objc func refreshTableviewList() {
        
        let apiClient = APIClient()
        var baseURL = URL(string: kokoFriendUrl3)!
  
        cancellable = apiClient.fetchData(KOKOFriend.self, from: baseURL)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in // 5
                            print(completion)
                        }, receiveValue: { repositories in
                            print("kokoFriendUrl3 has \(repositories.response.count) repositories")
                            self.allFriendData = repositories.response
                            self.addFriendData = self.allFriendData.filter{
                                $0.status == 2
                            }
                            
                            self.updateListView()
                           
                        })

    }
    
    func updateListView()
    {
        
        if addFriendData.count > 0 {
            self.vc.mAddFriendView.addSubview(addFriendView1)
            self.vc.mAddfriendHeight.constant = 96
        }else
        {
            self.vc.mAddfriendHeight.constant = 0
        }

        emptyFriendView.removeFromSuperview()
        friendTableview.removeFromSuperview()
        
        if self.allFriendData.count == 0 {
            self.vc.mCotentView.addSubview(emptyFriendView)
        }else
        {
            self.vc.mCotentView.addSubview(friendTableview)
        }
        
        addFriendView1.updateView(list:addFriendData)
        addFriendTableview.reloadList(list: addFriendData)
        friendTableview.reloadList(list: allFriendData)
        
        
        self.vc.mTopbarView.friendButton?.updateBadge(badgeText: "\(addFriendData.count)")
        self.vc.mTopbarView.chatButton?.updateBadge(badgeText: "99+")

    }
    
    func fetchFriendData()
    {
        let baseURL1 = URL(string: kokoFriendUrl1)!
        let publisher1 = URLSession.shared.dataTaskPublisher(for: baseURL1)
        .map { $0.data }
        .decode(type: KOKOFriend.self, decoder: JSONDecoder())

        let baseURL2 = URL(string: kokoFriendUrl2)!
        let publisher2 = URLSession.shared.dataTaskPublisher(for: baseURL2)
        .map { $0.data }
        .decode(type: KOKOFriend.self, decoder: JSONDecoder())
        

        cancellable = Publishers.Zip(publisher1, publisher2)
        .eraseToAnyPublisher()
        .catch { _ in
            Just((KOKOFriend(response: []), KOKOFriend(response: [])))
        }
        .receive(on: DispatchQueue.main)
        .sink(receiveValue: { fetechData1, fetechData2 in
            
            
            self.updateList(fetechData1: fetechData1.response, fetechData2: fetechData2.response)
            
            self.vc.view.removeBlur()
            self.vc.navigationController?.setNavigationBarHidden(false, animated: true)
        })

    }
    
    func updateList(fetechData1:[Response],fetechData2:[Response])
    {
        var combinedArray = fetechData1 + fetechData2
        
        
        var responseDictionary: [String: Response] = [:]

        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"

        for response in combinedArray {
            if let existingResponse = responseDictionary[response.fid ?? ""] {
                if let existingUpdateDate = existingResponse.updateDate,
                   let newUpdateDate = response.updateDate,
                   let existingMillis = dateToMillis(dateString: existingUpdateDate, formatter: dateFormatter),
                   let newMillis = dateToMillis(dateString: newUpdateDate, formatter: dateFormatter),
                   existingMillis < newMillis {
                    responseDictionary[response.fid ?? ""] = response
                }
            } else {
                responseDictionary[response.fid ?? ""] = response
            }
        }

       
        var finalArray = Array(responseDictionary.values)

        
//        for response in finalArray {
//            print("fid: \(response.fid ?? ""), updateDate: \(response.updateDate ?? "")")
//        }
        
        self.allFriendData = finalArray
        self.addFriendData = allFriendData.filter{
            $0.status == 2
        }
        
        updateListView()

    }
    
    
    func dateToMillis(dateString: String, formatter: DateFormatter) -> Int64? {
        if let date = formatter.date(from: dateString.replacingOccurrences(of: "/", with: "")) {
            return Int64(date.timeIntervalSince1970 * 1000)
        }
        return nil
    }
    
    
    @objc func showComboView(_ sender: UIButton) {
        
        let listView = ComboViewController()
        let nav = UINavigationController(rootViewController: listView)
        nav.modalPresentationStyle = .fullScreen
        self.vc.present(nav, animated: true,completion: nil)
        
    }
    
    
    
    func toggleContentView(toggle: Bool) {
        self.contentViewToggle.toggle()
        
        self.vc.mAddFriendView.alpha = 0
        self.vc.mOwnAccountView.alpha = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0 ,
            animations: {
                if self.contentViewToggle{
                    self.vc.mAddFriendView.isHidden = true
                    self.vc.mOwnAccountView.isHidden = true
                }else{
                    self.vc.mAddFriendView.isHidden = false
                    self.vc.mOwnAccountView.isHidden = false
                    
                }
            },completion: {_ in
                self.vc.mAddFriendView.alpha = 1
                self.vc.mOwnAccountView.alpha = 1
        })
        
        
        
    }
    
    func toggleReturnView(toggle: Bool) {
        toggleView()
    }
    
    @objc func toggleView()
    {
        
        viewToggle.toggle()
        UIView.animate(withDuration: 0.5) {
            if self.viewToggle {
                
                self.vc.mAddfriendHeight.constant = self.addFriendData.count <= 1 ? 96:200
            }else{
                self.vc.mAddfriendHeight.constant = 96
            }
            self.vc.view.layoutIfNeeded()
        }

        self.vc.mAddFriendView.alpha = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0 ,
            animations: {
                self.vc.mAddFriendView.alpha = 1
        })
        
        if viewToggle{
            self.addFriendView1.removeFromSuperview()
            self.vc.mAddFriendView.addSubview(addFriendTableview)
        }else
        {
            self.addFriendTableview.removeFromSuperview()
            self.vc.mAddFriendView.addSubview(addFriendView1)
        }
                
    }
    
    
    @objc func change(_ sender:TopbarButton)
    {

        self.vc.mTopbarView.friendButton?.topbarImage.isHidden = true
        self.vc.mTopbarView.chatButton?.topbarImage.isHidden = true
        
        sender.topbarImage.alpha = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0 ,
            animations: {
                sender.topbarImage.alpha = 1
                sender.topbarImage.isHidden = false
        })
    }
    
    
    
}
