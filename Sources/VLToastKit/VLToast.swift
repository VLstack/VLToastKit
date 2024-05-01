import Foundation

public struct VLToast: Identifiable
{
 public let id: String = UUID().uuidString
 
 let type: VLToastType
 let title: String?
 let message: String
 let duration: Double?
 let onDismiss: () -> Void
 
 public init(type: VLToastType, 
             title: String? = nil,
             message: String,
             duration: Double? = 1,
             onDismiss: @escaping () -> Void = {})
 {
  self.type = type
  self.title = title
  self.message = message
  self.duration = duration
  self.onDismiss = onDismiss
 }
}

// MARK: - Equatable
extension VLToast: Equatable
{
 public static func == (lhs: VLToast,
                        rhs: VLToast) -> Bool
 {
  lhs.id == rhs.id
 }
}
