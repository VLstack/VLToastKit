import SwiftUI

extension VLToast
{
 /// What a style receives to draw one toast
 public struct StyleConfiguration
 {
  public struct Message: View
  {
   public init<Content: View>(content: Content) { body = AnyView(content) }
   public var body: AnyView
  }

  public let type: VLToast.ItemType
  public let message: Self.Message
 }
}
