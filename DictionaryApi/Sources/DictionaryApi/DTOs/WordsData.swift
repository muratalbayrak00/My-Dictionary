//
//  WordsData.swift
//
//
//  Created by murat albayrak on 18.05.2024.
//

import Foundation

public struct WordsData: Codable {
    let word, phonetic: String
    let phonetics: [Phonetic]
    let meanings: [Meaning]
    let license: License
    let sourceUrls: [String]
}

struct License: Codable {
    let name: String
    let url: String
}

struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
    let synonyms, antonyms: [String]
}

struct Definition: Codable {
    let definition: String
    let example: String?
}

struct Phonetic: Codable {
    let text: String
    let audio: String
    let sourceURL: String?
    let license: License?

    enum CodingKeys: String, CodingKey {
        case text, audio
        case sourceURL = "sourceUrl"
        case license
    }
}
