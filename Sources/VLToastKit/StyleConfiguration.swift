import VLstackNamespace
import SwiftUI

extension VLstack.Toast
{
 public struct StyleConfiguration
 {
  public struct Message: View
  {
   public init<Content: View>(content: Content) { body = AnyView(content) }
   public var body: AnyView
  }

  public let type: VLstack.Toast.ItemType
  public let message: Self.Message
  public let onDismiss: @MainActor () -> Void
 }
}
