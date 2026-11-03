import SwiftUI

extension VLToast
{
 /// Appearance of a toast, like `ButtonStyle`: the style only draws the toast,
 /// the stack handles position, gestures, animation, sensory feedback and accessibility
 @MainActor
 public protocol Style
 {
  associatedtype Body: View
  typealias Configuration = VLToast.StyleConfiguration
  @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
 }

 internal struct AnyStyle: VLToast.Style
 {
  private let makeBodyClosure: (Configuration) -> AnyView

  internal init<S: VLToast.Style>(_ style: S)
  {
   makeBodyClosure = { AnyView(style.makeBody(configuration: $0)) }
  }

  internal func makeBody(configuration: Configuration) -> some View
  {
   makeBodyClosure(configuration)
  }
 }
}

extension View
{
 public func toastStyle<S: VLToast.Style>(_ style: S) -> some View
 {
  self.environment(\.toastStyle, VLToast.AnyStyle(style))
 }
}
