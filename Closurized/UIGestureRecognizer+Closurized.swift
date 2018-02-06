//
//  UIGestureRecognizer+Closurized.swift
//  Closurized
//
//  Created by Li-Heng Hsu on 29/01/2018.
//  Copyright © 2018 Li-Heng Hsu. All rights reserved.
//

import Foundation

extension UIGestureRecognizer: Closurized {
    
    public typealias Handler = () -> Void
    
    struct ClosureWrapper: ClosureWrapperProtocol {
        var handler: Handler?
    }
    
    @objc func didRecognizeGesture() {
        closureWrapper.handler?()
    }
    
    public var handler: Handler? {
        get {
            return closureWrapper.handler
        }
        set {
            if let handler = newValue {
                closureWrapper.handler = handler
                addTarget(self, action: #selector(didRecognizeGesture))
            } else {
                closureWrapper.handler = nil
                removeTarget(self, action: #selector(didRecognizeGesture))
            }
        }
    }
    
}

