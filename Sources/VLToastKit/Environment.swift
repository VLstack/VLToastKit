import VLstackNamespace
import SwiftUI

extension VLstack.Toast
{
 internal struct StyleKey: @preconcurrency EnvironmentKey
 {
  @MainActor static let defaultValue = VLstack.Toast.AnyStyle(style: VLstack.Toast.DefaultStyle())
 }

 internal struct ManagerKey: @preconcurrency EnvironmentKey
 {
  @MainActor static let defaultValue = VLstack.Toast.Manager()
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

extension EnvironmentValues
{
 public var toastStyle: VLstack.Toast.AnyStyle
 {
  get { self[VLstack.Toast.StyleKey.self] }
  set { self[VLstack.Toast.StyleKey.self] = newValue }
 }

 public var toastManager: VLstack.Toast.Manager
 {
  get { self[VLstack.Toast.ManagerKey.self] }
  set { self[VLstack.Toast.ManagerKey.self] = newValue }
 }

 public var toastMessageFont: Font
 {
  get { self[VLstack.Toast.FontMessageKey.self] }
  set { self[VLstack.Toast.FontMessageKey.self] = newValue }
 }

 public var toastMessageColor: Color
 {
  get { self[VLstack.Toast.ColorMessageKey.self] }
  set { self[VLstack.Toast.ColorMessageKey.self] = newValue }
 }

 public var toastBackgroundColor: Color
 {
  get { self[VLstack.Toast.ColorBackgroundKey.self] }
  set { self[VLstack.Toast.ColorBackgroundKey.self] = newValue }
 }

 public var toastSuccessColor: Color
 {
  get { self[VLstack.Toast.ColorSuccessKey.self] }
  set { self[VLstack.Toast.ColorSuccessKey.self] = newValue }
 }

 public var toastInfoColor: Color
 {
  get { self[VLstack.Toast.ColorInfoKey.self] }
  set { self[VLstack.Toast.ColorInfoKey.self] = newValue }
 }

 public var toastWarningColor: Color
 {
  get { self[VLstack.Toast.ColorWarningKey.self] }
  set { self[VLstack.Toast.ColorWarningKey.self] = newValue }
 }

 public var toastDangerColor: Color
 {
  get { self[VLstack.Toast.ColorDangerKey.self] }
  set { self[VLstack.Toast.ColorDangerKey.self] = newValue }
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
