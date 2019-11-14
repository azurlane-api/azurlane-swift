public struct Names: Codable {
    let en: String?
    let cn: String?
    let jp: String?
    let kr: String?
}

public struct Skin: Codable {
    let title: String?
    let image: String?
    let chibi: String?
}

public struct Stars: Codable {
    let value: String?
    let count: Int
}

public struct Stat: Codable {
    let name: String?
    let image: String?
    let value: String?
}

public struct Stats: Codable {
    let level100: [Stat]?
    let level120: [Stat]?
    let base: [Stat]?
    let retrofit100: [Stat]?
    let retrofit120: [Stat]?
}

public struct MiscellaneousData: Codable {
    let link: String?
    let name: String?
}

public struct Miscellaneous: Codable {
    let artist: MiscellaneousData?
    let web: MiscellaneousData?
    let pixiv: MiscellaneousData?
    let twitter: MiscellaneousData?
    let voiceActerss: MiscellaneousData?
}

public struct Ship: Codable {
    let wikiUrl: String
    let id: String?
    let names: Names
    let thumbnail: String
    let skins: [Skin]
    let buildTime: String?
    let rarity: String?
    let stars: Stars
    let `class`: String?
    let nationality: String?
    let nationalityShort: String?
    let hullType: String?
    let stats: Stats
    let miscellaneous: Miscellaneous
}

public struct ShipResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    let message: String
    let ship: Ship
}