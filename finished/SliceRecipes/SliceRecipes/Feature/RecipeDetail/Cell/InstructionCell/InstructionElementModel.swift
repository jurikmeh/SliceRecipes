import Foundation

final class InstructionElementModel: RecipeCellElementModel {
    
    let instructions: [Instruction]
    
    var type: RecipeCell { .instruction }
    
    init(instructions: [Instruction]) {
        self.instructions = instructions
    }
    
}
