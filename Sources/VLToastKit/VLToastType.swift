import SwiftUI

public enum VLToastType
{
 case custom(VLToastStyle)
 case danger
 case info
 case success
 case warning
}

extension VLToastType
{
 var style: VLToastStyle
 {
  switch self
  {
   case .custom(let s): return s
   case .danger: return VLToastStyle.dangerStyle
   case .info: return VLToastStyle.infoStyle
   case .success: return VLToastStyle.successStyle
   case .warning: return VLToastStyle.warningStyle
  }
 }
}
