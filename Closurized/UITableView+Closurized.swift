//
//  UITableView+Closurized.swift
//  Closurized
//
//  Created by Li-Heng Hsu on 04/02/2018.
//  Copyright © 2018 Li-Heng Hsu. All rights reserved.
//

import Foundation

extension UITableView: Closurized {
    
    class ClosureWrapper: NSObject, UITableViewDataSource {
        var numberOfRowsInSection: ((Int) -> Int)!
        var cellForRowAt: ((IndexPath) -> UITableViewCell)!
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return numberOfRowsInSection(section)
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return cellForRowAt(indexPath)
        }
        
    }
    
    func makeClosureWrapper() -> ClosureWrapper {
        return ClosureWrapper()
    }
    
    public enum HandlerEnum {
        case numberOfRowsInSection((Int) -> Int)
        case cellForRowAt((IndexPath) -> UITableViewCell)
    }
    
    public func setHandler(_ handler: HandlerEnum) {
        switch handler {
        case .numberOfRowsInSection(let handler):
            closureWrapper.numberOfRowsInSection = handler
        case .cellForRowAt(let handler):
            closureWrapper.cellForRowAt = handler
        }
    }
    
    public var numberOfRowsInSection: (Int) -> Int {
        get {
            return closureWrapper.numberOfRowsInSection
        }
        set {
            closureWrapper.numberOfRowsInSection = newValue
        }
    }

    public var cellForRowAt: (IndexPath) -> UITableViewCell {
        get {
            return closureWrapper.cellForRowAt
        }
        set {
            closureWrapper.cellForRowAt = newValue
        }
    }
    
}
