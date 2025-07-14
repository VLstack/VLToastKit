import VLstackNamespace
import SwiftUI
import UIKit

extension VLstack.Toast
{
 public struct VLModifier: ViewModifier
 {
  @Environment(\.toastStyle) private var toastStyle

  private let alignment: Alignment
  private let offsetY: CGFloat

  @State private var workItem: DispatchWorkItem?
  @State private var toastManager = VLstack.Toast.Manager()

  public init(alignment: Alignment)
  {
   self.alignment = alignment
   switch alignment
   {
    case .top:    offsetY = 40
    case .center: offsetY = 0
    default:      offsetY = -40
   }
  }

  public func body(content: Content) -> some View
  {
   content
   .environment(\.toastManager, toastManager)
   .overlay
   {
    if let toast = toastManager.current
    {
     ZStack
     {
      VStack
      {
       toastStyle
        .makeBody(configuration: VLstack.Toast.StyleConfiguration(type: toast.type,
                                                                  message: .init(content: Text(verbatim: toast.message)),
                                                                  onDismiss: dismiss))
        .offset(y: offsetY)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
      .transition(alignment == .top ? .move(edge: .top)
                  : alignment == .center ? .identity
                  : .move(edge: .bottom))
     }
     .animation(.spring(), value: toast)
    }
   }
   .onChange(of: toastManager.current, show)
  }

  internal func show()
  {
   workItem?.cancel()

   guard let toast = toastManager.current else { return }

   if let feedback = toast.feedback
   {
    UIImpactFeedbackGenerator(style: feedback).impactOccurred()
   }

   guard let duration: TimeInterval = toast.duration,
         duration > 0
   else { return }

   let task = DispatchWorkItem { dismiss() }
   workItem = task
   DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: workItem!)
  }

  internal func dismiss()
  {
   let onDismiss = toastManager.current?.onDismiss
   withAnimation { toastManager.current = nil }

   workItem?.cancel()
   workItem = nil
   if let onDismiss
   {
    DispatchQueue.main.async(execute: DispatchWorkItem { onDismiss() })
   }
  }
 }
}

extension View
{
 public func toast(alignment: Alignment = .top) -> some View
 {
  self.modifier(VLstack.Toast.VLModifier(alignment: alignment))
 }
}
