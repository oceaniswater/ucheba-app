//
//  InstitutionsModel.swift
//  ucheba app
//
//  Created by Марк Голубев on 05.02.2023.
//

import Foundation

// MARK: - InstitutionsModel
struct InstitutionsModel: Codable {
    let total: Int?
    let items: [Institution]?
}

// MARK: - Item
struct Institution: Codable {
    let id: Int?
    let name: String?
    let type: TypeClass?
    let isState: Bool?
    let abbreviation, description, logoURL: String?
    let feedbackStats: FeedbackStats?
    let programSummary: ProgramSummary?
    let rankings: [RankingElement]?
    let mediaList: [MediaList]?

    enum CodingKeys: String, CodingKey {
        case id, name, type, isState, abbreviation, description
        case logoURL = "logoUrl"
        case feedbackStats, programSummary, rankings, mediaList
    }
}

// MARK: - FeedbackStats
struct FeedbackStats: Codable {
    let total: Int?
    let score: Double?
}

// MARK: - MediaList
struct MediaList: Codable {
    let id: Int?
    let fileURL: String?
    let thumbnailURL: String?
    let mediaType: TypeClass?
    let isOfficialPromo: Bool?
    let description: String?
    let thumbnail: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case fileURL = "fileUrl"
        case thumbnailURL = "thumbnailUrl"
        case mediaType, isOfficialPromo, description, thumbnail
    }
}

// MARK: - TypeClass
struct TypeClass: Codable {
    let value: Int?
    let name: TypeName?
}

enum TypeName: String, Codable {
    case видеоYoutube = "Видео youtube"
    case вуз = "Вуз"
    case фото = "Фото"
}

// MARK: - ProgramSummary
struct ProgramSummary: Codable {
    let count, budgetPlacesCount, minPassingScore, maxPassingScore: Int?
    let priceFrom, priceTo: Int?
}

// MARK: - RankingElement
struct RankingElement: Codable {
    let ranking: RankingRanking?
    let rankFrom: Int?
    let rankTo: JSONNull?
    let worldRankFrom: Int?
    let worldRankTo: Int?
    let isOutOfRank, isOutOfWorldRank: Bool?
}

// MARK: - RankingRanking
struct RankingRanking: Codable {
    let id: Int?
    let name: RankingName?
    let description: String?
    let url: String?
    let logoURL: LogoURL?

    enum CodingKeys: String, CodingKey {
        case id, name, description, url
        case logoURL = "logoUrl"
    }
}

enum LogoURL: String, Codable {
    case pixLogoCache12_200430022316Upto100X100PNG = "/pix/logo_cache/12_200430022316.upto100x100.png"
    case pixLogoCache19_200430022240Upto100X100PNG = "/pix/logo_cache/19_200430022240.upto100x100.png"
    case pixLogoCache4_200430022418Upto100X100PNG = "/pix/logo_cache/4_200430022418.upto100x100.png"
}

enum RankingName: String, Codable {
    case qsWorldUniversityRankings = "QS World University Rankings"
    case timesHigherEducationWorldUniversityRankings = "Times Higher Education World University Rankings"
    case рейтингТоп100ВузовРоссииRAEX = "Рейтинг \"Топ-100 вузов России\" RAEX"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
