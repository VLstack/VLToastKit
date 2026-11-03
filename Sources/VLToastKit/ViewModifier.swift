import SwiftUI

extension VLToast
{
 internal struct Modifier: ViewModifier
 {
  private enum Placement
  {
   case top
   case center
   case bottom
  }

  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @Environment(\.toastStyle) private var toastStyle
  @Environment(VLToast.Manager.self) private var toastManager

  private let alignment: Alignment
  private let placement: Placement
  /// Kept from 3.x: room between the stack and the edge of the screen
  private let edgeInset: CGFloat = 40

  internal init(alignment: Alignment)
  {
   self.alignment = alignment
   if alignment.vertical == .bottom { placement = .bottom }
   else if alignment.vertical == .center { placement = .center }
   else { placement = .top }
  }

  internal func body(content: Content) -> some View
  {
   content
   .overlay(alignment: alignment)
   {
    VStack(spacing: 8)
    {
     ForEach(orderedItems)
     {
      item in
      VLToast.ItemView(item: item,
                       style: toastStyle ?? VLToast.AnyStyle(VLToast.DefaultStyle()),
                       swipeDirection: placement == .bottom ? 1 : -1,
                       dismiss: { toastManager.dismiss(id: item.id) })
       .transition(transition)
     }
    }
    .padding(.horizontal, 16)
    .padding(edge, edgeInset)
    .animation(animation, value: toastManager.items)
   }
   .sensoryFeedback(trigger: toastManager.latest) { $1?.feedback }
   .onChange(of: toastManager.latest)
   {
    _, newValue in
    guard let newValue else { return }
    AccessibilityNotification.Announcement(newValue.message).post()
   }
  }
 }
}

private extension VLToast.Modifier
{
 // MARK: - Properties
 /// The newest toast is always the closest to the edge
 var orderedItems: [VLToast.Item]
 {
  switch placement
  {
   case .top, .center: toastManager.items
   case .bottom: toastManager.items.reversed()
  }
 }

 var edge: Edge.Set
 {
  switch placement
  {
   case .top: .top
   case .center: []
   case .bottom: .bottom
  }
 }

 var transition: AnyTransition
 {
  if reduceMotion { return .opacity }

  switch placement
  {
   case .top: return .move(edge: .top).combined(with: .opacity)
   case .center: return .scale(scale: 0.8).combined(with: .opacity)
   case .bottom: return .move(edge: .bottom).combined(with: .opacity)
  }
 }

 var animation: Animation
 {
  reduceMotion ? .easeInOut(duration: 0.2)
               : .spring(duration: 0.4, bounce: 0.2)
 }
}

extension View
{
 public func toast(alignment: Alignment = .top) -> some View
 {
  self.modifier(VLToast.Modifier(alignment: alignment))
 }
}
