import Foundation
import TinyNetworking

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

    public init(id: String, title: String, url: URL, artwork: Artwork, episodes_count: Int, total_duration: Int, description: String, new: Bool) {
        self.id = id
        self.title = title
        self.url = url
        self.artwork = artwork
        self.episodes_count = episodes_count
        self.total_duration = total_duration
        self.description = description
        self.new = new
	}
}

public struct Markdown: Codable {
    public var text: String
    public init(_ text: String) { self.text = text }
}

public struct EpisodeDetails: Codable {
    public struct TocItem: Codable {
        public var position: TimeInterval
        public var title: String
        public init(position: TimeInterval, title: String) {
            self.position = position
            self.title = title
        }
    }
    public var id: String
    public var hls_url: URL?
    public var toc: [TocItem]
    public var transcript: Markdown
    
    public init(id: String, hls_url: URL?, toc: [TocItem], transcript: Markdown) {
        self.id = id
        self.hls_url = hls_url
        self.toc = toc
        self.transcript = transcript
    }
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

    public init(id: String, number: Int, title: String, synopsis: String, url: URL, small_poster_url: URL, poster_url: URL, media_duration: Int, released_at: Date, collection: String, subscription_only: Bool, hls_url: URL?, preview_url: URL?) {
		self.id = id
		self.number = number
		self.title = title
		self.synopsis = synopsis
		self.url = url
		self.small_poster_url = small_poster_url
		self.poster_url = poster_url
		self.media_duration = media_duration
		self.released_at = released_at
		self.collection = collection
		self.subscription_only = subscription_only
		self.hls_url = hls_url
		self.preview_url = preview_url
	}
}

public struct Server {
    public var baseURL: URL
    
    public init(baseURL: URL = URL(string: "https://talk.objc.io")!) {
        self.baseURL = baseURL
    }
    
    public var allEpisodes: Endpoint<[EpisodeView]> {
        return Endpoint(json: .get, url: baseURL.appendingPathComponent("episodes.json"), decoder: decoder)
    }
    
    public var allCollections: Endpoint<[CollectionView]> {
        return Endpoint<[CollectionView]>(json: .get, url: URL(string: "https://talk.objc.io/collections.json")!, decoder: decoder)
    }

   	public func authenticated(sessionId: String, csrf: String) -> Authenticated {
        return Authenticated(baseURL: baseURL, sessionId: sessionId, csrf: csrf)
    }
}

public struct PlayProgress: Codable {
    public var csrf: String
    public var progress: Int
}

public struct Authenticated {
    let sessionId: String
    let csrf: String
    let baseURL: URL
    init(baseURL: URL, sessionId: String, csrf: String) {
        self.baseURL = baseURL
        self.sessionId = sessionId
        self.csrf = csrf
    }
    
    var authHeaders: [String:String] {
        return [
            "Cookie": "session=\(sessionId)"
        ]
    }
    
    public func playProgress(episode: EpisodeView, progress: Int) -> Endpoint<()> {
        let url = baseURL.appendingPathComponent("episodes/\(episode.id)/play-progress")
        return Endpoint<()>(json: .post, url: url, body: PlayProgress(csrf: csrf, progress: progress), headers: authHeaders)
    }
    
    public func episodeDetails(episode: EpisodeView) -> Endpoint<EpisodeDetails> {
        let url = baseURL.appendingPathComponent("episodes/\(episode.id)/details")
        return Endpoint<EpisodeDetails>(json: .get, url: url, headers: authHeaders)
    }
}
