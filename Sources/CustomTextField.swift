//
//  CustomTextField.swift
//  MMLoginRegister
//
//  Created by Mikael Mukhsikaroyan on 11/21/16.
//  Copyright © 2016 MSquaredmm. All rights reserved.
//

import UIKit

public class CustomTextField: UITextField {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func errorMode() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.red.cgColor
    }
    
    func normalMode() {
        layer.borderWidth = 0
        layer.borderColor = UIColor.clear.cgColor
    }
    
}
