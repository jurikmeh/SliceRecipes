import Foundation

public enum Configuration {
    public static func string(for key: BuildKey) -> String {
        if let value = ProcessInfo.processInfo.environment[key.rawValue] {
            return value
        }
 
        guard let value = Bundle.main.infoDictionary?[key.rawValue] as? String else {
            fatalError("Couldn't find \(key.rawValue) key in Info.plist and Build Settings")
        }
        return value
    }
}
