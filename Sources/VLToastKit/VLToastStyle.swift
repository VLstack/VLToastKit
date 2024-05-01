import SwiftUI

public struct VLToastStyle: Sendable
{
 public private(set) var backgroundColor: Color
 public private(set) var color: Color
 public private(set) var messageColor: Color
 public private(set) var messageFont: Font
 public private(set) var symbolName: String
 public private(set) var titleColor: Color
 public private(set) var titleFont: Font
 
 public init(backgroundColor: Color = .white,
             color: Color = .black,
             messageColor: Color = .black.opacity(0.75),
             messageFont: Font = .system(size: 12),
             symbolName: String = "circle.fill",
             titleColor: Color = .black,
             titleFont: Font = .system(size: 14, weight: .semibold))
 {
  self.backgroundColor = backgroundColor
  self.color = color
  self.messageColor = messageColor
  self.messageFont = messageFont
  self.symbolName = symbolName
  self.titleColor = titleColor
  self.titleFont = titleFont
 }
 
 public func copy() -> VLToastStyle
 {
  let result = self
  return result
 }
 
 public func adjustedCopy(backgroundColor: Color? = nil,
                          color: Color? = nil,
                          messageColor: Color? = nil,
                          messageFont: Font? = nil,
                          symbolName: String? = nil,
                          titleColor: Color? = nil,
                          titleFont: Font? = nil) -> VLToastStyle
 {
  var result = self
  
  if let value: Color = backgroundColor { result.backgroundColor = value }
  if let value: Color = color { result.color = value }
  if let value: Color = messageColor { result.messageColor = value }
  if let value: Font = messageFont { result.messageFont = value }
  if let value: String = symbolName { result.symbolName = value }
  if let value: Color = titleColor { result.titleColor = value }
  if let value: Font = titleFont { result.titleFont = value }

  return result
 }
}

// MARK: - default styles
extension VLToastStyle
{
 public static let dangerStyle: VLToastStyle = .init(color: .red, symbolName: "xmark.circle.fill")
 public static let infoStyle: VLToastStyle = .init(color: .blue, symbolName: "info.circle.fill")
 public static let successStyle: VLToastStyle = .init(color: .green, symbolName: "checkmark.circle.fill")
 public static let warningStyle: VLToastStyle = .init(color: .orange, symbolName: "exclamationmark.triangle.fill")
}
