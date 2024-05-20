//
//  WordsData.swift
//
//
//  Created by murat albayrak on 18.05.2024.
//

import Foundation

public struct WordsData: Decodable {
    public let word, phonetic: String
    public let phonetics: [Phonetic]
    public let meanings: [Meaning]
    public let license: License
    public let sourceUrls: [String]
}

public struct License: Decodable {
    public let name: String
    public let url: String
}

public struct Meaning: Decodable {
    public let partOfSpeech: String
    public let definitions: [Definition]
    public let synonyms, antonyms: [String]
}

public struct Definition: Decodable {
    public let definition: String
    public let example: String?
}

public struct Phonetic: Decodable {
    public let text: String
    public let audio: String
    public let sourceURL: String?
    public let license: License?

    enum CodingKeys: String, CodingKey {
        case text, audio
        case sourceURL = "sourceUrl"
        case license
    }
}
