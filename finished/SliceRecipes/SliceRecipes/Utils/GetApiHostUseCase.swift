import Foundation

protocol GetApiHostUseCase {
    func execute() -> String
}

final class GetApiHostUseCaseImpl: GetApiHostUseCase {
    func execute() -> String {
        Configuration.string(for: .apiHost)
    }
}
