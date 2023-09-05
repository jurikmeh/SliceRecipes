import Foundation

struct LabelElement: RecipeCellElement {
    let title: String
    let description: String
    
    var kind: RecipeCellKind { .label }
}
