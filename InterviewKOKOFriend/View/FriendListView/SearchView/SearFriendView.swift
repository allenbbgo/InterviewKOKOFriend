//
//  SearFriendView.swift
//  InterviewKOKOFriend
//
//  Created by allen on 2023/11/22.
//

import Foundation
import UIKit




protocol SearchFriendViewDelegate {

    
    
     func updateList(content:String)
}

protocol SearchFriendToggleViewDelegate {

     func toggleContentView(toggle:Bool)
    
    
}

class SearFriendView:UIView,UITextFieldDelegate{
    
  
    @IBOutlet weak var searchTextField: UITextField!
    var delegate:SearchFriendViewDelegate?
    var toggleViewDelegate:SearchFriendToggleViewDelegate?
 
    required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            loadViewFromNib()
        
        searchTextField.delegate = self
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        
        searchTextField.delegate = self
        
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

        
    }
    
    @objc func toggleAction(toggle:Bool)
    {
        if (self.toggleViewDelegate != nil ) {

            self.toggleViewDelegate!.toggleContentView(toggle: toggle)
        }

    }

    
    //按下輸入欄後會變高
       //TODO: Declare textFieldDidBeginEditing here:
       func textFieldDidBeginEditing(_ textField: UITextField) {
           
           toggleAction(toggle: true)
           self.searchTextField.becomeFirstResponder()
           
       }
       //離開輸入欄
       func textFieldDidEndEditing(_ textField: UITextField) {
           toggleAction(toggle: false)
           
       }
       
       //按下小鍵盤的return後觸發
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           
      
           return true
       }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if (self.delegate != nil ) {
            print("textFieldDidChangeSelection \(textField.text ?? "")")
            self.delegate!.updateList(content: textField.text ?? "")
        }
    }
    
}
