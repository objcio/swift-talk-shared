import Foundation

public let encodingStrategy = JSONEncoder.DateEncodingStrategy.secondsSince1970

public struct CollectionView: Codable {
    public var id: String
    public var title: String
    public var url: URL
    public var artwork: URL
    public var episodes_count: Int
    public var total_duration: Int
}

public struct EpisodeView: Codable {
    public var number: Int
    public var title: String
    public var synopsis: String
    public var url: URL
    public var small_poster_url: URL
    public var media_duration: Int
    public var released_at: Date
    public var collection: String // todo: slug<collection>
    public var subscription_only: Bool
}
