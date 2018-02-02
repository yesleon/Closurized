//
//  Closurized.swift
//  Closurized
//
//  Created by Li-Heng Hsu on 29/01/2018.
//  Copyright © 2018 Li-Heng Hsu. All rights reserved.
//

import Foundation

private var associatedObjectKey: UInt8 = 0

protocol Closurized: AnyObject {
    
    associatedtype ClosurizedDelegate
    
    func setClosurizedDelegate() -> ClosurizedDelegate
}

extension Closurized {
    
    public var closurizedDelegate: ClosurizedDelegate {
        get {
            if let delegate = objc_getAssociatedObject(self, &associatedObjectKey) as? ClosurizedDelegate {
                return delegate
            } else {
                let delegate = setClosurizedDelegate()
                objc_setAssociatedObject(self, &associatedObjectKey, delegate, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return delegate
            }
        }
        set {
            objc_setAssociatedObject(self, &associatedObjectKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
