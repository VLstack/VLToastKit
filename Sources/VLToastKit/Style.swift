import SwiftUI

extension VLToast
{
 public protocol Style
 {
  associatedtype Body: View
  typealias Configuration = VLToast.StyleConfiguration
  func makeBody(configuration: Self.Configuration) -> Self.Body
 }

 public struct AnyStyle: VLToast.Style
 {
  internal var _makeßody: (Configuration) -> AnyView

  public init<S: VLToast.Style>(style: S)
  {
   _makeßody = { configuration in AnyView(style.makeBody(configuration: configuration)) }
  }

  public func makeBody(configuration: Configuration) -> some View
  {
   _makeßody(configuration)
  }
 }
}

extension View
{
 public func toastStyle<S: VLToast.Style>(_ style: S) -> some View
 {
  self.environment(\.toastStyle, VLToast.AnyStyle(style: style))
 }
}
