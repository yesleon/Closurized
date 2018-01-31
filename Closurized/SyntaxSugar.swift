//
//  SyntaxSugar.swift
//  Closurized
//
//  Created by Li-Heng Hsu on 29/01/2018.
//  Copyright © 2018 Li-Heng Hsu. All rights reserved.
//

import Foundation

@discardableResult
public func configure<T>(_ object: T, handler: (T) -> Void) -> T {
    handler(object)
    return object
}

