//
//  UIView.swift
//  FloatingControl
//
//  Created by Ryuhei Kaminishi on 2019/10/21.
//  Copyright © 2019 catelina777. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0.0
        }
    }

    var viewController: UIViewController? {
        var resp: UIResponder? = self
        while let next = resp?.next {
            if next is UIViewController {
                return next as? UIViewController
            }
            resp = next
        }
        return nil
    }


    // MARK: -
    class func initWithSize(_ size: CGSize) -> UIView {
        return UIView(frame: CGRect(x: 0, y: 0,
                                    width: size.width,
                                    height: size.height))
    }

    class func animateWithSystemMotion(_ animations: (() -> Void)?, completion: ((Bool) -> Void)?) {
        UIView.perform(.delete,
                       on: [],
                       options: [.beginFromCurrentState, .allowUserInteraction],
                       animations: animations,
                       completion: completion)
    }
}

