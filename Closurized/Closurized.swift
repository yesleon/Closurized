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
    
    associatedtype ClosureWrapper
    
    func makeClosureWrapper() -> ClosureWrapper
}

extension Closurized {
    
    var closureWrapper: ClosureWrapper {
        get {
            if let delegate = objc_getAssociatedObject(self, &associatedObjectKey) as? ClosureWrapper {
                return delegate
            } else {
                return configure(makeClosureWrapper()) {
                    objc_setAssociatedObject(self, &associatedObjectKey, $0, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
            }
        }
        set {
            objc_setAssociatedObject(self, &associatedObjectKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
