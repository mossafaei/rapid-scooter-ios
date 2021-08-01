//
//  RapidTextField.swift
//  Rapid
//
//  Created by Apple on 10/29/19.
//  Copyright © 2019 ___MostafaSafaeipour___. All rights reserved.
//

import UIKit

class RapidTextField: UITextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder :aDecoder)
    }
    func setForRapid(RapidPlaceHolder:String,isPersian:Bool) {
        self.background = #imageLiteral(resourceName: "textFieldBack")
        self.borderStyle = .none
        self.textAlignment = .center
        self.textColor = UIColor(red: 242.0, green: 241.0, blue: 239.0, alpha: 1.0)
        if isPersian {
            self.font = UIFont(name: "B Yekan", size: 20.0)
            self.attributedPlaceholder = NSAttributedString(string: RapidPlaceHolder, attributes: [NSAttributedString.Key.foregroundColor :UIColor.init(red: 242.0, green: 241.0, blue: 239.0, alpha: 0.5) , NSAttributedString.Key.font :UIFont(name: "B Yekan", size: 20.0)!])
        }else{
            self.font = UIFont(name: "Avenir Book", size: 20.0)
            self.attributedPlaceholder = NSAttributedString(string: RapidPlaceHolder, attributes: [NSAttributedString.Key.foregroundColor :UIColor.init(red: 242.0, green: 241.0, blue: 239.0, alpha: 0.5) , NSAttributedString.Key.font :UIFont(name: "Avenir Book", size: 20.0)!])
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
