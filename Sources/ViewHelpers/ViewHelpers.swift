import Foundation

extension Int {
    public var padded: String {
        return self < 10 ? "0" + "\(self)" : "\(self)"
    }
}

extension DateFormatter {
    static public let iso8601: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }()
}

extension TimeInterval {
    private var hm: (Int, Int, Int) {
        let h = floor(self/(60*60))
        let m = floor(self.truncatingRemainder(dividingBy: 60*60)/60)
        let s = self.truncatingRemainder(dividingBy: 60).rounded()
        return (Int(h), Int(m), Int(s))
    }
    
    public var minutes: String {
        let m = Int((self/60).rounded())
        return "\(m) min"
    }
    
    public var hoursAndMinutes: String {
        let (hours, minutes, _) = hm
        if hours > 0 {
            return "\(Int(hours))h\(minutes.padded)min"
        } else { return "\(minutes)min" }
    }
    
    public var timeString: String {
        let (hours, minutes, seconds) = hm
        if hours == 0 {
            return "\(minutes.padded):\(seconds.padded)"
        } else {
            return "\(hours):\(minutes.padded):\(seconds.padded)"
        }
    }
}

extension DateFormatter {
    public convenience init(format: String) {
        self.init()
        self.locale = Locale(identifier: "en_US")
        self.timeZone = TimeZone(secondsFromGMT: 0)
        self.dateFormat = format
    }
    
    static public let withYear = DateFormatter(format: "MMM dd yyyy")
    
    /// e.g. "November 23, 2018"
    static public let fullPretty = DateFormatter(format: "MMMM dd, yyyy")
    static public let withoutYear = DateFormatter(format: "MMM dd")
}

extension Date {
    public var pretty: String {
        let cal = NSCalendar.current
        if cal.component(.year, from: Date()) == cal.component(.year, from: self) {
            return DateFormatter.withoutYear.string(from: self)
        } else {
            return DateFormatter.withYear.string(from: self)
        }
    }
}
