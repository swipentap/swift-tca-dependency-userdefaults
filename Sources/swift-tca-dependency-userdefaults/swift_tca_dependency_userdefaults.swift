import Dependencies 
import Foundation
import Appl

extension DependencyValues {
    public var userDefaults: Appl.Dependencies.UserDefaultsClient {
        get { self[Appl.Dependencies.UserDefaultsClient.self] }
        set { self[Appl.Dependencies.UserDefaultsClient.self] = newValue }
    }
}

extension Appl.Dependencies {
    public struct UserDefaultsClient {
        
        public enum Key: String {
            case showUUIDInCatalogListItems
            case boxBarcode
            case startBarcodeNumber
            case barcodeLabel
            case printerAddress
            case printerPort
            case nopAPIURL
            case calendar
        }
        
        public var boolForKey: @Sendable (Key) -> Bool
        public var dataForKey: @Sendable (Key) -> Data?
        public var doubleForKey: @Sendable (Key) -> Double
        public var integerForKey: @Sendable (Key) -> Int
        public var stringForKey: @Sendable (Key) -> String
        public var remove: @Sendable (Key) async -> Void
        public var setBool: @Sendable (Bool, Key) async -> Void
        public var setData: @Sendable (Data?, Key) async -> Void
        public var setDouble: @Sendable (Double, Key) async -> Void
        public var setInteger: @Sendable (Int, Key) async -> Void
        public var setString: @Sendable (String, Key) async -> Void
    }
}

extension Appl.Dependencies.UserDefaultsClient: DependencyKey {
    public static let liveValue: Self = {
        let defaults = { UserDefaults(suiteName: "group.keepstuff.live")! }
        return Self(
            boolForKey: { defaults().bool(forKey: $0.rawValue) },
            dataForKey: { defaults().data(forKey: $0.rawValue) },
            doubleForKey: { defaults().double(forKey: $0.rawValue) },
            integerForKey: { defaults().integer(forKey: $0.rawValue) },
            stringForKey: { defaults().string(forKey: $0.rawValue) ?? "" },
            remove: { defaults().removeObject(forKey: $0.rawValue) },
            setBool: { defaults().set($0, forKey: $1.rawValue) },
            setData: { defaults().set($0, forKey: $1.rawValue) },
            setDouble: { defaults().set($0, forKey: $1.rawValue) },
            setInteger: { defaults().set($0, forKey: $1.rawValue) },
            setString: { defaults().set($0, forKey: $1.rawValue) }
        )
    }()
}

extension Appl.Dependencies.UserDefaultsClient: TestDependencyKey {
    public static let previewValue = Self.noop
    public static let testValue = Self.noop
}

extension Appl.Dependencies.UserDefaultsClient {
    public static let noop = Self(
        boolForKey: { _ in false },
        dataForKey: { _ in nil },
        doubleForKey: { _ in 0 },
        integerForKey: { _ in 0 },
        stringForKey: { _ in "" },
        remove: { _ in },
        setBool: { _, _ in },
        setData: { _, _ in },
        setDouble: { _, _ in },
        setInteger: { _, _ in },
        setString: { _, _ in }
    )
}
