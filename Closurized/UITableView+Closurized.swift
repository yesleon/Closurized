//
//  UITableView+Closurized.swift
//  Closurized
//
//  Created by Li-Heng Hsu on 04/02/2018.
//  Copyright © 2018 Li-Heng Hsu. All rights reserved.
//

import Foundation

extension UITableView: Closurized {
    
    class ClosureWrapper: NSObject, UITableViewDataSource, UITableViewDelegate {
        var numberOfRowsInSection: ((Int) -> Int)!
        var cellForRowAt: ((IndexPath) -> UITableViewCell)!
        var didSelectRowAt: ((IndexPath) -> Void)?
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return numberOfRowsInSection(section)
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return cellForRowAt(indexPath)
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            didSelectRowAt?(indexPath)
        }
        
    }
    
    func makeClosureWrapper() -> ClosureWrapper {
        return ClosureWrapper()
    }
    
    public enum HandlerEnum {
        case numberOfRowsInSection((Int) -> Int)
        case cellForRowAt((IndexPath) -> UITableViewCell)
        case didSelectRowAt(((IndexPath) -> Void)?)
    }
    
    public func setHandler(_ handler: HandlerEnum) {
        if delegate !== closureWrapper {
            delegate = closureWrapper
        }
        if dataSource !== closureWrapper {
            dataSource = closureWrapper
        }
        switch handler {
        case .numberOfRowsInSection(let handler):
            closureWrapper.numberOfRowsInSection = handler
        case .cellForRowAt(let handler):
            closureWrapper.cellForRowAt = handler
        case .didSelectRowAt(let handler):
            closureWrapper.didSelectRowAt = handler
        }
    }
    
}
