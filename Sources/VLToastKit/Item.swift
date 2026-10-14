import VLDurationKit
import Foundation
import SwiftUI

extension VLToast
{
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
  public let duration: TimeInterval?
  public let feedback: UIImpactFeedbackGenerator.FeedbackStyle?
  public let onDismiss: @MainActor () -> Void

  public init(message: String,
              type: VLToast.ItemType = .info,
              duration: TimeInterval? = 2.seconds,
              feedback: UIImpactFeedbackGenerator.FeedbackStyle? = nil,
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
