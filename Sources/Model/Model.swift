import Foundation

public let encoder: JSONEncoder = {
    let r = JSONEncoder()
    r.dateEncodingStrategy = .secondsSince1970
    return r
}()

public let decoder: JSONDecoder = {
    let r = JSONDecoder()
    r.dateDecodingStrategy = .secondsSince1970
    return r
}()


public struct CollectionView: Codable {
    public struct Artwork: Codable {
        public var svg: URL
        public var png: URL
        public init(svg: URL, png: URL) {
            self.svg = svg
            self.png = png
        }
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
    public var id: String
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
