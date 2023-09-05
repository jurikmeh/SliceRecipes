import Foundation

public protocol GetApiHostUseCase {
    func execute() -> String
}

public final class GetApiHostUseCaseImpl: GetApiHostUseCase {
    public init() {}
    
    public func execute() -> String {
        Configuration.string(for: .apiHost)
    }
}
