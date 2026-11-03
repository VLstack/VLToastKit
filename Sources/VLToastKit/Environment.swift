import SwiftUI

extension EnvironmentValues
{
 /// `nil` until `.toastStyle(_:)` is used: the stack then draws with `VLToast.DefaultStyle`
 @Entry internal var toastStyle: VLToast.AnyStyle? = nil
}
