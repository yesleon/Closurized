//
//  UITableView+Closurized.swift
//  Closurized
//
//  Created by Li-Heng Hsu on 04/02/2018.
//  Copyright © 2018 Li-Heng Hsu. All rights reserved.
//

import Foundation

extension UITableView: Closurized, UITableViewDataSource, UITableViewDelegate {
    
    public struct DataSourceWrapper {
        var numberOfRowsInSection: ((Int) -> Int)!
        var cellForRowAt: ((IndexPath) -> UITableViewCell)!
    }
    
    public struct DelegateWrapper {
        var didSelectRowAt: ((IndexPath) -> Void)?
    }
    
    struct ClosureWrapper: ClosureWrapperProtocol {
        var dataSourceWrapper: DataSourceWrapper?
        var delegateWrapper: DelegateWrapper?
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return closureWrapper.dataSourceWrapper!.numberOfRowsInSection(section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return closureWrapper.dataSourceWrapper!.cellForRowAt(indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        closureWrapper.delegateWrapper!.didSelectRowAt?(indexPath)
    }
    
    public func setDelegateWrapper(_ delegateWrapper: DelegateWrapper?) {
        closureWrapper.delegateWrapper = delegateWrapper
        if delegateWrapper != nil {
            delegate = self
        } else {
            delegate = nil
        }
    }
    
    public func setDataSourceWrapper(_ dataSourceWrapper: DataSourceWrapper?) {
        closureWrapper.dataSourceWrapper = dataSourceWrapper
        if dataSourceWrapper != nil {
            dataSource = self
        } else {
            dataSource = nil
        }
    }
    
}
