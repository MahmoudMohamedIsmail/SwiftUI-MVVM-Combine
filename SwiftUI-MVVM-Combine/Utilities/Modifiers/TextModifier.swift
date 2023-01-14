
import SwiftUI

struct PrimaryTitleStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.bold(.custom("Helvetica", size: 16))())
            .multilineTextAlignment(TextAlignment.leading)
            .foregroundColor(.primary)
    }
}

struct SecondaryTitleStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica-Medium", size: 16))
            .multilineTextAlignment(TextAlignment.leading)
            .foregroundColor(.secondary)
    }
}

