//
//  AddFriendTableview.swift
//  InterviewKOKOFriend
//
//  Created by allen on 2023/11/22.
//

import Foundation
import UIKit



protocol FriendTableviewDelegate {

     func refreshTableviewList()
}
class FriendTableview:UIView, UITableViewDelegate, UITableViewDataSource,SearchFriendViewDelegate{
    
    
    
    @IBOutlet weak var searchTextView: SearFriendView!
   
    
    var list:[Response] = []
    var originList:[Response] = []
    var refreshControl:UIRefreshControl?
    var delegate:FriendTableviewDelegate?
    
    func updateList(content: String) {
        print("updateList \(content)")
        
        let filterList = list.filter{
            $0.name.contains(content)
        }
        
        self.list = filterList.isEmpty ? originList:filterList
        
        mTableview.reloadData()
        
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

//        cell.textLabel?.text = ""
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCellView", for: indexPath) as? FriendCellView
        {
            
            let rowData = list[indexPath.row]
            
            cell.isTopImg.isHidden = rowData.isTop == "1" ? false:true
            cell.friendImageView.image = UIImage(named: "img_friends_list")
            cell.friendName.text = rowData.name
            
            if rowData.status == 2{
                cell.inviteBtn.borderWidth = 1
                cell.inviteBtn.setTitle("邀請中", for: .normal)
                cell.inviteBtn.titleLabel?.font = .systemFont(ofSize: 11, weight: .bold)
                cell.inviteBtn.setImage(UIImage(), for: .normal)
            }else {
                cell.inviteBtn.borderWidth = 0
//                cell.inviteBtn.setTitle("", for: .normal)
                cell.inviteBtn.setTitle("", for: .normal)
                cell.inviteBtn.setImage(UIImage(named: "ic_friends_more"), for: .normal)
            }
            
            cell.transferBtn.addTarget(self, action: #selector(transferAction), for: .touchUpInside)
            
            cell.inviteBtn.addTarget(self, action: #selector(inviteAction), for: .touchUpInside)
            
            return cell
        }
        
        
        return cell
    }
    
    @IBOutlet weak var mTableview: UITableView!
    @IBOutlet var view: UIView!
    
    required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            loadViewFromNib()

        searchTextView.delegate = self
        
        mTableview.delegate = self
        mTableview.dataSource = self
        
        
        mTableview.register(UINib(nibName: "FriendCellView", bundle: nil), forCellReuseIdentifier: "FriendCellView")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        
        searchTextView.delegate = self
        
        mTableview.delegate = self
        mTableview.dataSource = self
        
        
        mTableview.register(UINib(nibName: "FriendCellView", bundle: nil), forCellReuseIdentifier: "FriendCellView")
       
        
        
        
    }
    
    init(frame: CGRect,list:[Response]) {
        super.init(frame: frame)
        self.list = list
        self.originList = list
        
        loadViewFromNib()
        
        searchTextView.delegate = self
        
        mTableview.delegate = self
        mTableview.dataSource = self
        
        
        mTableview.register(UINib(nibName: "FriendCellView", bundle: nil), forCellReuseIdentifier: "FriendCellView")

        addRefreshControl()
        
        
        
        
    }
    
    
    @objc func transferAction()
    {
        print("tranferAction")
    }
    
    @objc func inviteAction()
    {
        print("inviteAction")
    }
    
    func reloadList(list:[Response])
    {
        self.list = list
        self.originList = list
        
        mTableview.reloadData()
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
    
    func addRefreshControl()
    {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .black
        mTableview.refreshControl = refreshControl
        refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
    }
    @objc func refreshList()
    {
        self.mTableview.refreshControl?.endRefreshing()
        UIView.animate(withDuration: 0.5, animations: {
            self.mTableview.contentOffset = CGPoint.zero
        })
        if (self.delegate != nil ) {

           
            self.delegate!.refreshTableviewList()
            
        }
        
        
    }

    

}
