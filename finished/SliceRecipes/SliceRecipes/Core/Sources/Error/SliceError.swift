import Foundation

public struct SliceError: Error {
    public let message: String
    public let code: SliceErrorCode?
    
    public init(message: String) {
        self.code = nil
        self.message = message
    }
    
    public init(code: SliceErrorCode) {
        self.code = code
        self.message = code.localizedMessage
    }
}
