import Foundation

public struct VLToast: Identifiable
{
 public let id: String = UUID().uuidString
 
 var type: VLToastType
 var title: String? = nil
 var message: String
 var duration: Double? = 1
 var onDismiss: () -> Void = {}
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
