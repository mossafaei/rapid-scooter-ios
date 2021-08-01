//
//  RapidPopUp.swift
//  Rapid
//
//  Created by Apple on 11/28/19.
//  Copyright © 2019 ___MostafaSafaeipour___. All rights reserved.
//

import UIKit

class RapidPopUp: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var exitButtonGray: UIButton!
    @IBOutlet weak var batteryPercentage: UILabel!
    @IBOutlet weak var Kilometer: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        Bundle.main.loadNibNamed("RapidPopUp", owner: self, options: nil)
        contentView.fixInView(self)
    }
}
extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
