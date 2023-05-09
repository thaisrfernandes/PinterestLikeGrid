//
//  Helper.swift
//  PinterestLikeGrid
//
//  Created by Thaís Fernandes on 02/05/23.
//

import Foundation

class Helper {
    /**
     Splits the given array into multiple arrays with a specified number of columns.
     
     - Parameters:
     - arr: Array of any type
     - columnNumber: Number of columns
     
     - Returns: An array splitted into a given number of columns.
     */
    
    static func splitData<T>(from arr: [T], into columnNumber: Int = 2) -> [[T]] {
        guard !arr.isEmpty else { return [] }
        let columns = columnNumber > arr.count ? arr.count : columnNumber
        var result = [[T]](repeating: [], count: columns)
        
        for (index, item) in arr.enumerated() {
            let arrayIndex = index % columns
            result[arrayIndex].append(item)
        }
        return result
    }
}
