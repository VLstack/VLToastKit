import SwiftUI

public struct VLToastModifier: ViewModifier
{
 private let alignment: Alignment
 private let offsetY: CGFloat
 @Binding var toast: VLToast?
 @State private var workItem: DispatchWorkItem?
  
 init(alignment: Alignment,
      toast: Binding<VLToast?>)
 {
  self._toast = toast
  self.alignment = alignment
  switch alignment
  {
   case .top:    offsetY = 30
   case .center: offsetY = 0
   default:      offsetY = -30
  }
 }

 public func body(content: Content) -> some View
 {
  content
   .frame(maxWidth: .infinity, maxHeight: .infinity)
   .overlay
  {
   if let toast
   {
    ZStack
    {
     VStack
     {
      VLToastView(toast: toast) { dismiss() }
       .offset(y: offsetY)
     }
     .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
     .background(Color.white.opacity(0.75))
     .transition(alignment == .top ? .move(edge: .top)
                                   : alignment == .center ? .identity
                                                          : .move(edge: .bottom))
    }
    .animation(.spring(), value: toast)
   }
  }
  .onChange(of: toast, show)
 }
    
 private func show()
 {
  guard let toast,
        let duration: Double = toast.duration,
        duration > 0
  else { return }
  
  //  UIImpactFeedbackGenerator(style: .light).impactOccurred()
  
  workItem?.cancel()
  
  let task = DispatchWorkItem { dismiss() }
  
  workItem = task
  DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: task)
 }
    
 private func dismiss()
 {
  let onDismiss = toast?.onDismiss
  withAnimation { toast = nil }
        
  workItem?.cancel()
  workItem = nil
  if let onDismiss
  {
   DispatchQueue.main.async(execute: DispatchWorkItem { onDismiss() })
  }
 }
}

extension View
{
 public func toast(with toast: Binding<VLToast?>,
                   alignment: Alignment = .bottom) -> some View
 {
  self.modifier(VLToastModifier(alignment: alignment, toast: toast))
 }
}
