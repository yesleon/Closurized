//
//  UICollectionView+Closurized.swift
//  Closurized
//
//  Created by Li-Heng Hsu on 01/02/2018.
//  Copyright © 2018 Li-Heng Hsu. All rights reserved.
//

import Foundation

extension UICollectionView: Closurized {
    
    public class DataSource {
        
        public var numberOfSections: (() -> Int)?
        public var numberOfItemsInSection: ((Int) -> Int)?
        public var cellForItemAt: ((IndexPath) -> UICollectionViewCell)?
        public var canMoveItemAt: ((IndexPath) -> Bool)?
        public var moveItemAt: ((IndexPath, IndexPath) -> Void)?
        
    }
    
    class ClosurizedDelegate: NSObject, UICollectionViewDataSource {
        
        let dataSource = DataSource()
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return dataSource.numberOfSections?() ?? 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return dataSource.numberOfItemsInSection?(section) ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return dataSource.cellForItemAt!(indexPath)
        }
        
//        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//            <#code#>
//        }
        
        func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
            return dataSource.canMoveItemAt?(indexPath) ?? true
        }
        
        func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            dataSource.moveItemAt?(sourceIndexPath, destinationIndexPath)
        }
        
//        func indexTitles(for collectionView: UICollectionView) -> [String]? {
//            <#code#>
//        }
//
//        func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
//            <#code#>
//        }
        
    }
    
    public func setDataSource(handler: (DataSource) -> Void) {
        guard let closurizedDelegate = closurizedDelegate else {
            self.closurizedDelegate = ClosurizedDelegate()
            setDataSource(handler: handler)
            return
        }
        dataSource = configure(closurizedDelegate) {
            handler($0.dataSource)
        }
    }
    
}
