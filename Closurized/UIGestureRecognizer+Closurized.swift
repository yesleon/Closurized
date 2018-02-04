//
//  UIGestureRecognizer+Closurized.swift
//  Closurized
//
//  Created by Li-Heng Hsu on 29/01/2018.
//  Copyright © 2018 Li-Heng Hsu. All rights reserved.
//

import Foundation

extension UIGestureRecognizer: Closurized {
    
    func makeClosurizedDelegate() -> ClosurizedDelegate {
        return ClosurizedDelegate()
    }
    
    public typealias Handler = () -> Void
    
    class ClosurizedDelegate {
        var handler: Handler?
        @objc func didRecognizeGesture() {
            handler?()
        }
    }
    
    public func setHandler(_ handler: Handler?) {
        if let handler = handler {
            closurizedDelegate.handler = handler
            addTarget(closurizedDelegate, action: #selector(ClosurizedDelegate.didRecognizeGesture))
        } else {
            closurizedDelegate.handler = nil
            removeTarget(closurizedDelegate, action: #selector(ClosurizedDelegate.didRecognizeGesture))
        }
    }
    
}

