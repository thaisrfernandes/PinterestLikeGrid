//
//  PinterestGrid.swift
//  Dashboard
//
//  Created by Thaís Fernandes on 02/05/23.
//

import SwiftUI

/**
 Custom SwiftUI view that displays data in a Pinterest-like grid style.
 
 - Important: Items in the data array must conform to the `Hashable` protocol.
 
 - Parameters:
 - data: Binding array of items to be displayed on the list. The item must conform to the `Hashable` protocol.
 - columns: The number of columns in the grid. The default value is 2.
 - content: View that represents each item in the grid. It provides the current item of the data array and its index.
 
 - Example:
 
 ````
 struct ContentView: View {
 @State var data = [1,2,3,4]
 
 var body: some View {
 PinterestLikeGrid($data) { item, index in
 Text("\(item)")
 }
 }
 }
 ````
 */

@available(macOS 10.15, *)
public struct PinterestLikeGrid<T:Hashable, Content:View>: View {
    
    /// Binding to an array of hashable items to be displayed
    @Binding var data: [T]
    
    /// The number of columns in the grid
    let columns: Int
    
    /// Closure that takes as input a hashable item from the data array and its optional index, and returns a SwiftUI view that represents the item in the grid.
    let content: (_ item: T, _ index: Int?) -> Content
    
    /// A range representing the indices of the grid columns.
    let range: ClosedRange<Int>
    
    /// An array of arrays of hashable items that represents the data array splitted into the number of columns.
    var splittedData: [[T]] {
        Helper.splitData(from: data, into: columns)
    }
    
    var rowSpacing: CGFloat
    
    var columnSpacing: CGFloat
    
    /**
     Creates a new PinteresLikeGrid with the specified data, number of columns, row and column spacing and content. If column is nil, 2 is the default value.
     */
    public init(_ data: Binding<[T]>, columns: Int = 2, rowSpacing: CGFloat = 8, columnSpacing: CGFloat = 8, @ViewBuilder content: @escaping (_ item: T,  _ index: Int?) -> Content) {
        self._data = data
        self.columns = columns
        self.rowSpacing = rowSpacing
        self.columnSpacing = columnSpacing
        self.range = 0...(columns + 1)
        self.content = content
    }
    
    /**
     Creates a new PinteresLikeGrid with the specified data, number of columns, vertical and horizontal spacing and content. If column is nil, 2 is the default value.
     */
    public init(_ data: Binding<[T]>, columns: Int = 2, spacing: CGFloat = 8, @ViewBuilder content: @escaping (_ item: T,  _ index: Int?) -> Content) {
        self._data = data
        self.columns = columns
        self.rowSpacing = spacing
        self.columnSpacing = spacing
        self.range = 0...(columns + 1)
        self.content = content
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: columnSpacing) {
            ForEach(range, id: \.self) { index in
                if index < splittedData.count {
                    VStack(spacing: rowSpacing) {
                        ForEach(splittedData[index], id: \.self) { item in
                            content(item, getIndexInList(for: item))
                                .transition(.identity)
                        }
                    }
                }
            }
        }
        .animation(.easeInOut, value: data)
    }
    
    /**
     Returns the index of a specified item from the data array.
     - Parameter item: The item to search for the index.
     - Returns: The index of the specified item in the data array or nil, if it's not found.
     */
    private func getIndexInList(for item: T) -> Int? {
        data.firstIndex(where: { $0.hashValue == item.hashValue })
    }
}
