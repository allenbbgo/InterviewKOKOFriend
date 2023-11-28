//
//  ComboViewController.swift
//  InterviewKOKOFriend
//
//  Created by allen on 2023/11/24.
//

import UIKit

class ComboViewController: UIViewController {
    
    
    init() {
         super.init(nibName: "ComboViewController", bundle: nil)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    @IBOutlet weak var mScrollView: UIScrollView!
    
    @IBOutlet weak var mMainStackView: UIStackView!
    
    
    @IBOutlet weak var mTopContentView: UIView!
    @IBOutlet weak var mCenterContentView: UIView!
    @IBOutlet weak var mFootContentView: UIView!
    
    var topLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .medium)
        
        label.text = "留個聯絡方式"
        return label
    }()
    
    var topSubLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        label.text = "確認一下通訊資料，並讓我們知道如何與你聯繫：）"
        return label
    }()
    
    var stepLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 17)
        label.textColor = .gray
//        label.text = "3 / 4"
        
        var content = AttributedString()
        
        var setpValue = AttributedString("3")
        setpValue.font = .boldSystemFont(ofSize: 17)
        setpValue.foregroundColor = accentColor
        content += setpValue
        
        var maxValue = AttributedString(" / 4")
        maxValue.font = .boldSystemFont(ofSize: 17)
        maxValue.foregroundColor = UIColor.systemGray4
        content += maxValue
        

        label.attributedText = NSAttributedString(content)
        
        
        
        return label
    }()
    
    
    
    
    var cityLabel: ComboTextField = {
           let label = ComboTextField()
        label.contentTextField.placeholder = "居住縣市"
           return label
       }()
       
        var roleLabel: ComboTextField = {
           let label = ComboTextField()
            label.contentTextField.placeholder = "行政區"
           return label
       }()
       
    var addressLabel: ComboTextField = {
       let label = ComboTextField()
        label.contentTextField.placeholder = "居住住址"
        label.dropMenuButton.isHidden = true
       return label
   }()
    
    var cityNumLabel: ComboTextField = {
        let label = ComboTextField()
        label.contentTextField.placeholder = "區碼"
        label.snp.makeConstraints({ (make) in
                make.width.equalTo(85) // <---
            })
        return label
       }()
       
    var houseNumLabel: ComboTextField = {
       let label = ComboTextField()
        label.contentTextField.placeholder = "住家電話"
        label.dropMenuButton.isHidden = true
       return label
   }()
    
    var houseLabel: ComboTextField = {
       let label = ComboTextField()
        label.contentTextField.placeholder = "房屋所有權"
//        label.dropMenuButton.isHidden = true
       return label
   }()
    
    var liveTimeLabel: ComboTextField = {
       let label = ComboTextField()
        label.contentTextField.placeholder = "現居時間"
//        label.dropMenuButton.isHidden = true
       return label
   }()
    
    var cardAddressLabel: ComboTextField = {
       let label = ComboTextField()
        label.contentTextField.placeholder = "卡片/帳單收件地址"
//        label.dropMenuButton.isHidden = true
       return label
   }()
    
    lazy var topStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [topLabel, stepLabel])
       stack.axis = .horizontal
       stack.alignment = .center
        stack.distribution = .fillEqually
       stack.spacing = 16
       return stack
   }()
    
    lazy var topMainStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [topStackView, topSubLabel])
       stack.axis = .vertical
       stack.alignment = .leading
        stack.distribution = .fill
       stack.spacing = 16
       return stack
   }()

    
    lazy var cityStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [cityLabel, roleLabel])
       stack.axis = .horizontal
       stack.alignment = .center
        stack.distribution = .fillProportionally
       stack.spacing = 16
       return stack
   }()
    
    lazy var addressStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [addressLabel])
       stack.axis = .horizontal
//       stack.alignment = .center
        stack.distribution = .fill
       stack.spacing = 16
       return stack
   }()

    
    lazy var cityNumStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [cityNumLabel, houseNumLabel])
       stack.axis = .horizontal
//       stack.alignment = .center
        stack.distribution = .fill
       stack.spacing = 16
       return stack
   }()
    
    lazy var houseStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [houseLabel])
       stack.axis = .horizontal
//       stack.alignment = .center
        stack.distribution = .fill
       stack.spacing = 16
       return stack
   }()
    
    lazy var liveTimeStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [liveTimeLabel])
       stack.axis = .horizontal
//       stack.alignment = .center
        stack.distribution = .fill
       stack.spacing = 16
       return stack
   }()

    
    lazy var cardAddressStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [cardAddressLabel])
       stack.axis = .horizontal
//       stack.alignment = .center
        stack.distribution = .fill
       stack.spacing = 16
       return stack
   }()


    

        override func viewDidLoad() {
            super.viewDidLoad()
            
            mTopContentView.addSubview(topMainStackView)
            
            mCenterContentView.addSubview(cityStackView)
            mCenterContentView.addSubview(addressStackView)
            mCenterContentView.addSubview(cityNumStackView)
            
            mCenterContentView.addSubview(houseStackView)
            mCenterContentView.addSubview(liveTimeStackView)
            mCenterContentView.addSubview(cardAddressStackView)
            
            topStackView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                        // center Y to image
                make.top.equalTo(topMainStackView.snp.top)

                    }
            
            topMainStackView.snp.makeConstraints { make in
                        // left padding to image for 12px
//                make.leading.equalTo(questionContentView.snp.leading).offset(30)
                
                make.leading.trailing.equalToSuperview().inset(30)
                        // center Y to image
                make.top.equalTo(mTopContentView.snp.top)
//                        make.centerY.equalTo(questionContentView.snp.centerY)
                        // trailing to superview
//                        make.trailing.equalToSuperview().offset(-20)
                    }

            cityStackView.snp.makeConstraints { make in
                        // left padding to image for 12px
//                make.leading.equalTo(questionContentView.snp.leading).offset(30)
                
                make.leading.trailing.equalToSuperview().inset(30)
                        // center Y to image
                make.top.equalTo(mCenterContentView.snp.top)
//                        make.centerY.equalTo(questionContentView.snp.centerY)
                        // trailing to superview
//                        make.trailing.equalToSuperview().offset(-20)
                    }
            
            addressStackView.snp.makeConstraints { make in
 
                make.leading.trailing.equalToSuperview().inset(30)
                        // center Y to image
                make.top.equalTo(cityStackView.snp.bottom).offset(10)

                    }
            
            cityNumStackView.snp.makeConstraints { make in
 
                make.leading.trailing.equalToSuperview().inset(30)
                        // center Y to image
                make.top.equalTo(addressStackView.snp.bottom).offset(10)

                    }
            
            houseStackView.snp.makeConstraints { make in
 
                make.leading.trailing.equalToSuperview().inset(30)
                        // center Y to image
                make.top.equalTo(cityNumStackView.snp.bottom).offset(10)

                    }

            liveTimeStackView.snp.makeConstraints { make in
 
                make.leading.trailing.equalToSuperview().inset(30)
                        // center Y to image
                make.top.equalTo(houseStackView.snp.bottom).offset(10)

                    }

            cardAddressStackView.snp.makeConstraints { make in
 
                make.leading.trailing.equalToSuperview().inset(30)
                        // center Y to image
                make.top.equalTo(liveTimeStackView.snp.bottom).offset(10)

                    }

            
            var image = UIImage(systemName: "xmark")
            image = image?.withRenderingMode(.alwaysTemplate)
            let logoutBarButtonItem = UIBarButtonItem(image:image, style: .done, target: self, action: #selector(returnMainView))
            logoutBarButtonItem.tintColor = accentColor
            
            var imageWithdraw = UIImage(systemName: "arrow.left")
            imageWithdraw = imageWithdraw?.withRenderingMode(.alwaysTemplate)
            
            let withdrawBarButtonItem = UIBarButtonItem(image:imageWithdraw, style: .done, target: self, action: #selector(returnMainView))
            withdrawBarButtonItem.tintColor = accentColor
            
            self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
            self.navigationItem.leftBarButtonItems = [withdrawBarButtonItem]
            
            
            
//            scrollView = UIScrollView()
//            scrollView.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(scrollView)

//            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: .alignAllCenterX, metrics: nil, views: ["scrollView": scrollView]))
//            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: .alignAllCenterX, metrics: nil, views: ["scrollView": scrollView]))


//            stackView = UIStackView()
//            stackView.translatesAutoresizingMaskIntoConstraints = false
            mMainStackView.axis = .vertical
//            scrollView.addSubview(stackView)

//            scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView]|", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: ["stackView": stackView]))
//            scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: ["stackView": stackView]))

//            for _ in 1 ..< 100 {
//                let vw = UIButton(type: UIButton.ButtonType.system)
//                vw.setTitle("Button", for: .normal)
//                stackView.addArrangedSubview(vw)
//            }
            
//            for _ in 1 ..< 100 {
//                let cotentView = ComboContentView()
//                stackView.addArrangedSubview(cotentView)
//            }
            
           
            
        }

        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            mScrollView.contentSize = CGSize(width: mMainStackView.frame.width, height: mMainStackView.frame.height)
        }
    
    
    
    @objc func returnMainView(){
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated:true, completion: nil)
    }

}




class ComboViewModel {
    
    
    var vc:ViewController
    
    init(viewController:ViewController) {
        self.vc = viewController
    }
    
    
}
