import Foundation
import Domain

struct InstructionElement: RecipeCellElement {
    let instructions: [Instruction]
    
    var kind: RecipeCellKind { .instruction }
}
