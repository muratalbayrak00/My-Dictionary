//
//  NewWordData.swift
//  MyDictionary
//
//  Created by murat albayrak on 23.05.2024.
//

import Foundation

public struct NewWordData: Decodable {
    public var newPartOfSpeech: String?
    public var newDefinition: String?
    public var newExample: String?
}
