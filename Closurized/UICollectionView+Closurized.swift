//
//  UICollectionView+Closurized.swift
//  Closurized
//
//  Created by Li-Heng Hsu on 06/02/2018.
//  Copyright © 2018 Li-Heng Hsu. All rights reserved.
//

import Foundation

extension UICollectionView: Closurized, UICollectionViewDataSource, UICollectionViewDelegate {
    public struct DataSourceWrapper {
        var numberOfItemsInSection: ((Int) -> Int)!
        var cellForItemAt: ((IndexPath) -> UICollectionViewCell)!
    }
    
    public struct DelegateWrapper {
        var didSelectItemAt: ((IndexPath) -> Void)?
    }
    
    struct ClosureWrapper: ClosureWrapperProtocol {
        var dataSourceWrapper: DataSourceWrapper?
        var delegateWrapper: DelegateWrapper?
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return closureWrapper.dataSourceWrapper!.numberOfItemsInSection(section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return closureWrapper.dataSourceWrapper!.cellForItemAt(indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        closureWrapper.delegateWrapper!.didSelectItemAt?(indexPath)
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
