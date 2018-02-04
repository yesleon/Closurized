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
    
    func makeClosureWrapper() -> ClosureWrapper {
        return ClosureWrapper()
    }
    
    public typealias Handler = () -> Void
    
    struct ClosureWrapper {
        var handlers: [UIControlEvents : Handler] = [:]
    }
    
    @objc func didTouchUpInside() {
        closureWrapper.handlers[.touchUpInside]?()
    }
    
    @objc func didTouchDown() {
        closureWrapper.handlers[.touchDown]?()
    }
    
    func selector(for controlEvents: UIControlEvents) -> Selector? {
        switch controlEvents {
        case .touchUpInside:
            return #selector(didTouchUpInside)
        case .touchDown:
            return #selector(didTouchDown)
        default:
            return nil
        }
    }
    
    public func setHandler(for controlEvents: UIControlEvents, handler: Handler?) {
        guard let action = selector(for: controlEvents) else { return }
        if let handler = handler {
            closureWrapper.handlers[controlEvents] = handler
            addTarget(closureWrapper, action: action, for: controlEvents)
        } else {
            closureWrapper.handlers[controlEvents] = nil
            removeTarget(closureWrapper, action: action, for: controlEvents)
        }
    }
    
    public func handler(for controlEvents: UIControlEvents) -> Handler? {
        return closureWrapper.handlers[controlEvents]
    }
    
}
