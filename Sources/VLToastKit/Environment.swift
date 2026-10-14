import SwiftUI

extension VLToast
{
 internal struct StyleKey: @preconcurrency EnvironmentKey
 {
  @MainActor static let defaultValue = VLToast.AnyStyle(style: VLToast.DefaultStyle())
 }

 internal struct ManagerKey: @preconcurrency EnvironmentKey
 {
  @MainActor static let defaultValue = VLToast.Manager()
 }

 internal struct FontMessageKey: EnvironmentKey
 {
  static let defaultValue: Font = .body
 }

 internal struct ColorMessageKey: EnvironmentKey
 {
  static let defaultValue: Color = Color(.label)
 }

 internal struct ColorBackgroundKey: EnvironmentKey
 {
  static let defaultValue: Color = Color(.systemBackground)
 }

 internal struct ColorSuccessKey: EnvironmentKey
 {
  static let defaultValue: Color = .green
 }

 internal struct ColorInfoKey: EnvironmentKey
 {
  static let defaultValue: Color = .blue
 }

 internal struct ColorWarningKey: EnvironmentKey
 {
  static let defaultValue: Color = .orange
 }

 internal struct ColorDangerKey: EnvironmentKey
 {
  static let defaultValue: Color = .red
 }
}

// TODO: à vérifier mais je crois qu'il existe une notation plus récente de faire ça
extension EnvironmentValues
{
 public var toastStyle: VLToast.AnyStyle
 {
  get { self[VLToast.StyleKey.self] }
  set { self[VLToast.StyleKey.self] = newValue }
 }

 public var toastManager: VLToast.Manager
 {
  get { self[VLToast.ManagerKey.self] }
  set { self[VLToast.ManagerKey.self] = newValue }
 }

 public var toastMessageFont: Font
 {
  get { self[VLToast.FontMessageKey.self] }
  set { self[VLToast.FontMessageKey.self] = newValue }
 }

 public var toastMessageColor: Color
 {
  get { self[VLToast.ColorMessageKey.self] }
  set { self[VLToast.ColorMessageKey.self] = newValue }
 }

 public var toastBackgroundColor: Color
 {
  get { self[VLToast.ColorBackgroundKey.self] }
  set { self[VLToast.ColorBackgroundKey.self] = newValue }
 }

 public var toastSuccessColor: Color
 {
  get { self[VLToast.ColorSuccessKey.self] }
  set { self[VLToast.ColorSuccessKey.self] = newValue }
 }

 public var toastInfoColor: Color
 {
  get { self[VLToast.ColorInfoKey.self] }
  set { self[VLToast.ColorInfoKey.self] = newValue }
 }

 public var toastWarningColor: Color
 {
  get { self[VLToast.ColorWarningKey.self] }
  set { self[VLToast.ColorWarningKey.self] = newValue }
 }

 public var toastDangerColor: Color
 {
  get { self[VLToast.ColorDangerKey.self] }
  set { self[VLToast.ColorDangerKey.self] = newValue }
 }
}

extension View
{
 public func toastMessage(font: Font) -> some View
 {
  self.environment(\.toastMessageFont, font)
 }

 public func toastMessage(font: Font,
                          color: Color) -> some View
 {
  self.toastMessage(font: font)
      .toastColor(message: color)
 }

 public func toastColor(message: Color) -> some View
 {
  self.environment(\.toastMessageColor, message)
 }

 public func toastColor(background color: Color) -> some View
 {
  self.environment(\.toastBackgroundColor, color)
 }

 public func toastColor(success color: Color) -> some View
 {
  self.environment(\.toastSuccessColor, color)
 }

 public func toastColor(info color: Color) -> some View
 {
  self.environment(\.toastInfoColor, color)
 }

 public func toastColor(warning color: Color) -> some View
 {
  self.environment(\.toastWarningColor, color)
 }

 public func toastColor(danger color: Color) -> some View
 {
  self.environment(\.toastDangerColor, color)
 }

 public func toastColors(background: Color,
                         message: Color,
                         success: Color,
                         info: Color,
                         warning: Color,
                         danger: Color) -> some View
 {
  self.toastColor(background: background)
      .toastColor(message: message)
      .toastColor(success: success)
      .toastColor(info: info)
      .toastColor(warning: warning)
      .toastColor(danger: danger)
 }
}
