//
//  UIView+Extension.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 24/1/22.
//

import UIKit

extension UIView {
    @IBInspectable var corneRadius: CGFloat {
        get {return self.corneRadius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
