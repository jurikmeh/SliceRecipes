import Foundation

struct InstructionElement: RecipeCellElement {
    let instructions: [Instruction]
    
    var kind: RecipeCellKind { .instruction }
}
