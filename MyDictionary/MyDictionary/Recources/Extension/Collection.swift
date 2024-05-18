//
//  Collection.swift
//  MyDictionary
//
//  Created by murat albayrak on 19.05.2024.
//

import Foundation

public extension Collection where Indices.Iterator.Element == Index {
  subscript (safe index: Index) -> Iterator.Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
