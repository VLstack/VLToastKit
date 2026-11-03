import SwiftUI

public extension VLToast.Style where Self == VLToast.DefaultStyle
{
 static var `default`: Self { .init() }

 static func `default`(font: Font = .body,
                       colors: VLToast.DefaultStyle.Colors = .init()) -> Self
 {
  .init(font: font,
        colors: colors)
 }
}

extension VLToast
{
 public struct DefaultStyle: VLToast.Style
 {
  public struct Colors: Sendable
  {
   public let background: Color
   public let message: Color
   public let success: Color
   public let info: Color
   public let warning: Color
   public let danger: Color

   public init(background: Color = Color(.systemBackground),
               message: Color = Color(.label),
               success: Color = .green,
               info: Color = .blue,
               warning: Color = .orange,
               danger: Color = .red)
   {
    self.background = background
    self.message = message
    self.success = success
    self.info = info
    self.warning = warning
    self.danger = danger
   }
  }

  private let font: Font
  private let colors: Self.Colors

  public init(font: Font = .body,
              colors: Self.Colors = .init())
  {
   self.font = font
   self.colors = colors
  }

  public func makeBody(configuration: Configuration) -> some View
  {
   VLToast.DefaultStyleView(configuration: configuration,
                            font: font,
                            colors: colors)
  }
 }
}
