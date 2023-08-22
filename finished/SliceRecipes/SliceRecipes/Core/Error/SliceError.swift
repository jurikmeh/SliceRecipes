import Foundation

struct SliceError: Error {
    let message: String
    let code: SliceErrorCode?
    
    init(message: String) {
        self.code = nil
        self.message = message
    }
    
    init(code: SliceErrorCode) {
        self.code = code
        self.message = code.localizedMessage
    }
}
