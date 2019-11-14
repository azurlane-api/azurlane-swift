public struct Names: Codable {
    public let en: String?
    public let cn: String?
    public let jp: String?
    public let kr: String?
}

public struct Skin: Codable {
    public let title: String?
    public let image: String?
    public let chibi: String?
}

public struct Stars: Codable {
    public let value: String?
    public let count: Int
}

public struct Stat: Codable {
    public let name: String?
    public let image: String?
    public let value: String?
}

public struct Stats: Codable {
    public let level100: [Stat]?
    public let level120: [Stat]?
    public let base: [Stat]?
    public let retrofit100: [Stat]?
    public let retrofit120: [Stat]?
}

public struct MiscellaneousData: Codable {
    public let link: String?
    public let name: String?
}

public struct Miscellaneous: Codable {
    public let artist: MiscellaneousData?
    public let web: MiscellaneousData?
    public let pixiv: MiscellaneousData?
    public let twitter: MiscellaneousData?
    public let voiceActerss: MiscellaneousData?
}

public struct Ship: Codable {
    public let wikiUrl: String
    public let id: String?
    public let names: Names
    public let thumbnail: String
    public let skins: [Skin]
    public let buildTime: String?
    public let rarity: String?
    public let stars: Stars
    public let `class`: String?
    public let nationality: String?
    public let nationalityShort: String?
    public let hullType: String?
    public let stats: Stats
    public let miscellaneous: Miscellaneous
}

public struct ShipResponse: Codable {
    public let statusCode: Int
    public let statusMessage: String
    public let message: String
    public let ship: Ship
}