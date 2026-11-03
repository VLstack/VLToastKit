import Foundation
import SwiftUI

extension VLToast
{
 /// One toast of the stack
 public struct Item: Identifiable, Equatable
 {
  public static func == (lhs: VLToast.Item,
                         rhs: VLToast.Item) -> Bool
  {
   lhs.id == rhs.id
  }

  public let id: UUID
  public let type: VLToast.ItemType
  public let message: String
  /// Seconds before the toast closes by itself, `nil` or `0` to keep it until the user closes it
  public let duration: TimeInterval?
  /// Sensory feedback played when the toast appears
  public let feedback: SensoryFeedback?
  /// Called once, when the toast leaves the stack for any reason
  public let onDismiss: @MainActor () -> Void

  public init(message: String,
              type: VLToast.ItemType = .info,
              duration: TimeInterval? = 2,
              feedback: SensoryFeedback? = nil,
              onDismiss: @escaping @MainActor () -> Void = {})
  {
   self.id = UUID()
   self.type = type
   self.message = message
   self.duration = duration
   self.feedback = feedback
   self.onDismiss = onDismiss
  }
 }
}
