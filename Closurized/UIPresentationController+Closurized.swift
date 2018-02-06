//
//  UIPresentationController+Closurized.swift
//  Closurized
//
//  Created by Li-Heng Hsu on 04/02/2018.
//  Copyright © 2018 Li-Heng Hsu. All rights reserved.
//

import Foundation

extension UIPopoverPresentationController: Closurized {
    
    class ClosureWrapper: NSObject, ClosureWrapperProtocol, UIPopoverPresentationControllerDelegate {
        var adaptivePresentationStyle: (() -> UIModalPresentationStyle)?
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return adaptivePresentationStyle?() ?? controller.adaptivePresentationStyle
        }
        required override init() { }
    }
    
    public enum HandlerEnum {
        case adaptivePresentationStyle((() -> UIModalPresentationStyle)?)
    }
    
    public func setHandler(_ handler: HandlerEnum) {
        if delegate !== closureWrapper {
            delegate = closureWrapper
        }
        switch handler {
        case .adaptivePresentationStyle(let handler):
            closureWrapper.adaptivePresentationStyle = handler
        }
    }
}
