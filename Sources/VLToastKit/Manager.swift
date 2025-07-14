import VLstackNamespace
import Foundation
import Observation
import VLDurationKit
import UIKit

extension VLstack.Toast
{
 @MainActor
 @Observable
 public final class Manager
 {
  public var current: VLstack.Toast.Item? = nil

  internal func show(message: String,
                     type: VLstack.Toast.ItemType,
                     duration: TimeInterval?,
                     feedback: UIImpactFeedbackGenerator.FeedbackStyle?,
                     onDismiss: @escaping @MainActor () -> Void = {})
  {
   self.current = .init(message: message,
                        type: type,
                        duration: duration,
                        feedback: feedback,
                        onDismiss: onDismiss)
  }

  public func success(_ message: String,
                      duration: TimeInterval? = 2.seconds,
                      feedback: UIImpactFeedbackGenerator.FeedbackStyle? = nil,
                      onDismiss: @escaping @MainActor () -> Void = {})
  {
   self.show(message: message,
             type: .success,
             duration: duration,
             feedback: feedback,
             onDismiss: onDismiss)
  }

  public func danger(_ message: String,
                     duration: TimeInterval? = 5.seconds,
                     feedback: UIImpactFeedbackGenerator.FeedbackStyle? = nil,
                     onDismiss: @escaping @MainActor () -> Void = {})
  {
   self.show(message: message,
             type: .danger,
             duration: duration,
             feedback: feedback,
             onDismiss: onDismiss)
  }

  public func error(_ error: any Error,
                    feedback: UIImpactFeedbackGenerator.FeedbackStyle? = nil,
                    onDismiss: @escaping @MainActor () -> Void = {})
  {
   self.show(message: error.localizedDescription,
             type: .danger,
             duration: nil,
             feedback: feedback,
             onDismiss: onDismiss)
  }

  public func info(_ message: String,
                   duration: TimeInterval? = 2.seconds,
                   feedback: UIImpactFeedbackGenerator.FeedbackStyle? = nil,
                   onDismiss: @escaping @MainActor () -> Void = {})
  {
   self.show(message: message,
             type: .info,
             duration: duration,
             feedback: feedback,
             onDismiss: onDismiss)
  }

  public func warning(_ message: String,
                      duration: TimeInterval? = 3.seconds,
                      feedback: UIImpactFeedbackGenerator.FeedbackStyle? = nil,
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
