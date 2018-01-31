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
    
    class ClosurizedDelegate {
        var handler: Handler?
        @objc func didRecognizeGesture() {
            handler?()
        }
    }
    
    public func setHandler(_ handler: Handler?) {
        guard let closurizedDelegate = closurizedDelegate else {
            self.closurizedDelegate = ClosurizedDelegate()
            setHandler(handler)
            return
        }
        if let handler = handler {
            closurizedDelegate.handler = handler
            addTarget(closurizedDelegate, action: #selector(ClosurizedDelegate.didRecognizeGesture))
        } else {
            closurizedDelegate.handler = nil
            removeTarget(closurizedDelegate, action: #selector(ClosurizedDelegate.didRecognizeGesture))
        }
    }
    
}
//
//extension UIView {
//    public func addClosurizedGestureRecognizer<T: UIGestureRecognizer>(_ GestureRecognizer: T.Type) {
//        addGestureRecognizer(configure(GestureRecognizer.init()) { gesture in
//            gesture.setHandler() {
//                print(gesture.state)
//            }
//        })
//    }
//}
//
//extension UIPanGestureRecognizer {
//
//    public convenience init(handler: Handler?) {
//        self.init()
//        setHandler(handler)
//    }
//}

