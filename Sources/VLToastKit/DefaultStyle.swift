import VLstackNamespace
import SwiftUI

public extension VLstack.Toast.Style where Self == VLstack.Toast.DefaultStyle
{
 static var `default`: Self { .init() }
}

extension VLstack.Toast
{
 public struct DefaultStyle: @preconcurrency VLstack.Toast.Style
 {
  @MainActor
  public func makeBody(configuration: Configuration) -> some View
  {
   VLstack.Toast.DefaultStyleView(configuration: configuration)
  }
 }
}
