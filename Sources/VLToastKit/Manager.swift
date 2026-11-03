import Foundation
import Observation
import SwiftUI

extension VLToast
{
 /// Stack of the toasts on screen: every toast stays until its own duration ends or the user closes it
 @MainActor
 @Observable
 public final class Manager
 {
  /// Beyond this count, the oldest toast leaves the stack, even a persistent one
  internal static let maximumCount: Int = 5

  /// Toasts on screen, newest first
  public private(set) var items: [VLToast.Item] = []
  /// Last toast shown, kept after it is dismissed: triggers the sensory feedback and the VoiceOver announcement
  internal private(set) var latest: VLToast.Item? = nil

  @ObservationIgnored private var timers: [UUID: Task<Void, Never>] = [:]

  public init() {}

  internal func show(message: String,
                     type: VLToast.ItemType,
                     duration: TimeInterval?,
                     feedback: SensoryFeedback?,
                     onDismiss: @escaping @MainActor () -> Void = {})
  {
   let item = VLToast.Item(message: message,
                           type: type,
                           duration: duration,
                           feedback: feedback,
                           onDismiss: onDismiss)
   items.insert(item, at: 0)
   latest = item

   if let duration,
      duration > 0
   {
    let id = item.id
    timers[id] = Task
    {
     [weak self] in
     do { try await Task.sleep(for: .seconds(duration)) }
     catch { return }
     self?.dismiss(id: id)
    }
   }

   while items.count > Self.maximumCount,
         let oldest = items.last
   {
    dismiss(id: oldest.id)
   }
  }

  /// Closes the toast with this identifier, does nothing if it already left the stack
  public func dismiss(id: UUID)
  {
   guard let index = items.firstIndex(where: { $0.id == id }) else { return }

   let item = items.remove(at: index)
   timers.removeValue(forKey: id)?.cancel()
   item.onDismiss()
  }

  public func success(_ message: String,
                      duration: TimeInterval? = 2,
                      feedback: SensoryFeedback? = nil,
                      onDismiss: @escaping @MainActor () -> Void = {})
  {
   self.show(message: message,
             type: .success,
             duration: duration,
             feedback: feedback,
             onDismiss: onDismiss)
  }

  public func danger(_ message: String,
                     duration: TimeInterval? = 5,
                     feedback: SensoryFeedback? = nil,
                     onDismiss: @escaping @MainActor () -> Void = {})
  {
   self.show(message: message,
             type: .danger,
             duration: duration,
             feedback: feedback,
             onDismiss: onDismiss)
  }

  /// Shows the error description as a danger toast that stays until the user closes it
  public func error(_ error: any Error,
                    feedback: SensoryFeedback? = nil,
                    onDismiss: @escaping @MainActor () -> Void = {})
  {
   self.show(message: error.localizedDescription,
             type: .danger,
             duration: nil,
             feedback: feedback,
             onDismiss: onDismiss)
  }

  public func info(_ message: String,
                   duration: TimeInterval? = 2,
                   feedback: SensoryFeedback? = nil,
                   onDismiss: @escaping @MainActor () -> Void = {})
  {
   self.show(message: message,
             type: .info,
             duration: duration,
             feedback: feedback,
             onDismiss: onDismiss)
  }

  public func warning(_ message: String,
                      duration: TimeInterval? = 3,
                      feedback: SensoryFeedback? = nil,
                      onDismiss: @escaping @MainActor () -> Void = {})
  {
   self.show(message: message,
             type: .warning,
             duration: duration,
             feedback: feedback,
             onDismiss: onDismiss)
  }
 }
}
