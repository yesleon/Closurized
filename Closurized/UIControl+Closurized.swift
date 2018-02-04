//
//  UIControl+Closurized.swift
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

extension UIControl: Closurized {
    func makeClosurizedDelegate() -> ClosurizedDelegate {
        return ClosurizedDelegate()
    }
    
    
    public typealias Handler = () -> Void
    
    class ClosurizedDelegate {
        
        fileprivate var handlers: [UIControlEvents : Handler] = [:]
        
        @objc private func didTouchUpInside() {
            handlers[.touchUpInside]?()
        }
        
        @objc private func didTouchDown() {
            handlers[.touchDown]?()
        }
        
        fileprivate static func selector(for controlEvents: UIControlEvents) -> Selector? {
            switch controlEvents {
            case .touchUpInside:
                return #selector(didTouchUpInside)
            case .touchDown:
                return #selector(didTouchDown)
            default:
                return nil
            }
        }
    }
    
    public func setControlEvents(_ controlEvents: UIControlEvents, handler: Handler?) {
        guard let action = ClosurizedDelegate.selector(for: controlEvents) else { return }
        if let handler = handler {
            closurizedDelegate.handlers[controlEvents] = handler
            addTarget(closurizedDelegate, action: action, for: controlEvents)
        } else {
            closurizedDelegate.handlers[controlEvents] = nil
            removeTarget(closurizedDelegate, action: action, for: controlEvents)
        }
    }
    
}
