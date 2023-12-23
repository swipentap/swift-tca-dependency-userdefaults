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
        public var boolForKey: @Sendable (String) -> Bool
        public var dataForKey: @Sendable (String) -> Data?
        public var doubleForKey: @Sendable (String) -> Double
        public var integerForKey: @Sendable (String) -> Int
        public var stringForKey: @Sendable (String) -> String
        public var remove: @Sendable (String) async -> Void
        public var setBool: @Sendable (Bool, String) async -> Void
        public var setData: @Sendable (Data?, String) async -> Void
        public var setDouble: @Sendable (Double, String) async -> Void
        public var setInteger: @Sendable (Int, String) async -> Void
        public var setString: @Sendable (String, String) async -> Void
    }
}

extension Appl.Dependencies.UserDefaultsClient: DependencyKey {
    public static let liveValue: Self = {
        let defaults = { UserDefaults(suiteName: "group.app.live")! }
        return Self(
            boolForKey: { defaults().bool(forKey: $0) },
            dataForKey: { defaults().data(forKey: $0) },
            doubleForKey: { defaults().double(forKey: $0) },
            integerForKey: { defaults().integer(forKey: $0) },
            stringForKey: { defaults().string(forKey: $0) ?? "" },
            remove: { defaults().removeObject(forKey: $0) },
            setBool: { defaults().set($0, forKey: $1) },
            setData: { defaults().set($0, forKey: $1) },
            setDouble: { defaults().set($0, forKey: $1) },
            setInteger: { defaults().set($0, forKey: $1) },
            setString: { defaults().set($0, forKey: $1) }
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
