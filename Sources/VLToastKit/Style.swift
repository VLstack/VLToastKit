import VLstackNamespace
import SwiftUI

extension VLstack.Toast
{
 public protocol Style
 {
  associatedtype Body: View
  typealias Configuration = VLstack.Toast.StyleConfiguration
  func makeBody(configuration: Self.Configuration) -> Self.Body
 }

 public struct AnyStyle: VLstack.Toast.Style
 {
  internal var _makeßody: (Configuration) -> AnyView

  public init<S: VLstack.Toast.Style>(style: S)
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
 public func toastStyle<S: VLstack.Toast.Style>(_ style: S) -> some View
 {
  self.environment(\.toastStyle, VLstack.Toast.AnyStyle(style: style))
 }
}
