//
//  UIButton+Closurized.swift
//  Closurized
//
//  Created by Li-Heng Hsu on 29/01/2018.
//  Copyright © 2018 Li-Heng Hsu. All rights reserved.
//

import Foundation

extension UIControlEvents: Hashable {
    
    public var hashValue: Int {
        return Int(rawValue)
    }
    
}

extension UIButton: Closurized {
    
    public typealias Handler = () -> Void
    
    class Delegate {
        
        var handlers: [UIControlEvents : Handler] = [:]
        
        @objc
        func didTouchUpInside(_ sender: UIButton) {
            handlers[.touchUpInside]?()
        }
        
        static func selector(for controlEvents: UIControlEvents) -> Selector? {
            switch controlEvents {
            case .touchUpInside:
                return #selector(didTouchUpInside(_:))
            default:
                return nil
            }
        }
    }
    
    typealias ClosurizedDelegate = Delegate
    
    public func setHandler(for controlEvents: UIControlEvents, handler: Handler?) {
        guard let action = ClosurizedDelegate.selector(for: controlEvents) else { return }
        guard let closurizedDelegate = closurizedDelegate else {
            self.closurizedDelegate = ClosurizedDelegate()
            setHandler(for: controlEvents, handler: handler)
            return
        }
        closurizedDelegate.handlers[controlEvents] = handler
        if handler != nil {
            addTarget(closurizedDelegate, action: action, for: controlEvents)
        } else {
            removeTarget(closurizedDelegate, action: action, for: controlEvents)
        }
    }
    
}
