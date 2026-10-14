import SwiftUI

public extension VLToast.Style where Self == VLToast.DefaultStyle
{
 static var `default`: Self { .init() }
}

extension VLToast
{
 public struct DefaultStyle: @preconcurrency VLToast.Style
 {
  @MainActor
  public func makeBody(configuration: Configuration) -> some View
  {
   VLToast.DefaultStyleView(configuration: configuration)
  }
 }
}
