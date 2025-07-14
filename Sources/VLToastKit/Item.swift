import VLstackNamespace
import VLDurationKit
import Foundation
import SwiftUI

extension VLstack.Toast
{
 public struct Item: Identifiable, Equatable
 {
  public static func == (lhs: VLstack.Toast.Item,
                         rhs: VLstack.Toast.Item) -> Bool
  {
   lhs.id == rhs.id
  }

  public let id: UUID
  public let type: VLstack.Toast.ItemType
  public let message: String
  public let duration: TimeInterval?
  public let feedback: UIImpactFeedbackGenerator.FeedbackStyle?
  public let onDismiss: @MainActor () -> Void

  public init(message: String,
              type: VLstack.Toast.ItemType = .info,
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
