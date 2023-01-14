
import SwiftUI

extension View {
    
    func applyPrimaryTitleStyle() -> some View {
        self.modifier(PrimaryTitleStyleModifier())
    }
    
    func applySecondaryTitleStyle() -> some View {
        self.modifier(SecondaryTitleStyleModifier())
    }
    
}
