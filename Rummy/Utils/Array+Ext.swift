//
//  Array+Ext.swift
//  Rummy
//
//  Created by Vishaal Kumar on 8/16/24.
//

import Foundation

extension Array where Element: Hashable {
    var isUnique: Bool {
        var seen = Set<Element>()
        return allSatisfy { seen.insert($0).inserted }
    }
}
