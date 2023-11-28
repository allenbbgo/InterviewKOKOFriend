//
//  AddFriendTableview.swift
//  InterviewKOKOFriend
//
//  Created by allen on 2023/11/19.
//

import Foundation
import UIKit


protocol AddFriendBtnDelegate {
   
    func toggleReturnView(toggle:Bool)
}

class AddFriendTableview:UIView, UITableViewDelegate, UITableViewDataSource{
    
    var delegate:AddFriendBtnDelegate?
    
    var list:[Response] = []
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        cell.textLabel?.text = ""
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AddFriendCellView", for: indexPath) as? AddFriendCellView
        {
            
            let rowData = list[indexPath.row]
            
            cell.friendView.friendCellShadow()
            cell.toggleBtn.addTarget(self, action: #selector(toggleAction), for: .touchUpInside)
            
            cell.friendName.text = rowData.name
            cell.friendImageView.image = UIImage(named: "img_friends_list")
            
            cell.addFriendBtn.addTarget(self, action: #selector(addFriendAction), for: .touchUpInside)
            cell.addCancelBtn.addTarget(self, action: #selector(cancelFriendAction), for: .touchUpInside)
            
            return cell
        }
        
        
        return cell
    }
    
    @IBOutlet weak var mTableview: UITableView!
    
    @IBOutlet var view: UIView!
    
    
    init(frame: CGRect,list:[Response]) {
        self.list = list
        
        super.init(frame: frame)
        loadViewFromNib()
        
        
        print("list \(list.count)")
        
        mTableview.delegate = self
        mTableview.dataSource = self
        
        
        mTableview.register(UINib(nibName: "AddFriendCellView", bundle: nil), forCellReuseIdentifier: "AddFriendCellView")
        
    }

    
    required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            loadViewFromNib()

        
        
        mTableview.delegate = self
        mTableview.dataSource = self
        
        mTableview.register(UINib(nibName: "AddFriendCellView", bundle: nil), forCellReuseIdentifier: "AddFriendCellView")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        
        mTableview.delegate = self
        mTableview.dataSource = self
        
       
        mTableview.register(UINib(nibName: "AddFriendCellView", bundle: nil), forCellReuseIdentifier: "AddFriendCellView")
//        mTableview.register(AddFriendView.self, forHeaderFooterViewReuseIdentifier: "MyHeaderView")
        
        
        
        
        
    }
    
    func reloadList(list:[Response])
    {
        self.list = list
        
        mTableview.reloadData()
    }
    
    @objc func toggleAction()
    {
        if (self.delegate != nil) {
            
            self.delegate!.toggleReturnView(toggle: true)
        }

    }

    @objc func addFriendAction()
    {
        print("add")
    }
    
    @objc func cancelFriendAction()
    {
        print("cancel")
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
