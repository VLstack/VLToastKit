import SwiftUI

extension VLToast
{
 public struct StyleConfiguration
 {
  public struct Message: View
  {
   public init<Content: View>(content: Content) { body = AnyView(content) }
   public var body: AnyView
  }

  public let type: VLToast.ItemType
  public let message: Self.Message
  public let onDismiss: @MainActor () -> Void
 }
}
