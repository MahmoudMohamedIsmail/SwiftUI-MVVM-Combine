
import SwiftUI

struct ViewHideModifier: ViewModifier {
    let flag: Bool
    func body(content: Content) -> some View {
        Group {
            if flag {
                EmptyView()
            } else {
                content
            }
        }
    }
}
