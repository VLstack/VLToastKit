import SwiftUI

extension VLToast
{
 // Manual keys rather than @Entry: both default values are main actor isolated
 internal struct StyleKey: @preconcurrency EnvironmentKey
 {
  @MainActor static let defaultValue = VLToast.AnyStyle(VLToast.DefaultStyle())
 }

 internal struct ManagerKey: @preconcurrency EnvironmentKey
 {
  @MainActor static let defaultValue = VLToast.Manager()
 }
}

extension EnvironmentValues
{
 internal var toastStyle: VLToast.AnyStyle
 {
  get { self[VLToast.StyleKey.self] }
  set { self[VLToast.StyleKey.self] = newValue }
 }

 public var toastManager: VLToast.Manager
 {
  get { self[VLToast.ManagerKey.self] }
  set { self[VLToast.ManagerKey.self] = newValue }
 }
}
