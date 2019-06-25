import Foundation

public let encodingStrategy = JSONEncoder.DateEncodingStrategy.secondsSince1970

public let decodingStrategy = JSONDecoder.DateDecodingStrategy.secondsSince1970

public struct CollectionView: Codable {
    public struct Artwork: Codable {
        var svg: URL
        var png: URL
    }
    public var id: String
    public var title: String
    public var url: URL
    public var artwork: Artwork
    public var episodes_count: Int
    public var total_duration: Int
    public var description: String
    public var new: Bool
}

public struct EpisodeView: Codable {
    public var number: Int
    public var title: String
    public var synopsis: String
    public var url: URL
    public var small_poster_url: URL
    public var poster_url: URL
    public var media_duration: Int
    public var released_at: Date
    public var collection: String // todo: slug<collection>
    public var subscription_only: Bool
    public var hls_url: URL?
    public var preview_url: URL?
}
