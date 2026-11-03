import SwiftUI

extension VLToast
{
 /// One toast of the stack: draws it with the style and closes it on tap or swipe toward its edge
 internal struct ItemView: View
 {
  internal let item: VLToast.Item
  internal let style: VLToast.AnyStyle
  /// -1 to close by swiping up, 1 to close by swiping down
  internal let swipeDirection: CGFloat
  internal let dismiss: @MainActor () -> Void

  private let dragThreshold: CGFloat = 30
  private let opacityMaxDistance: CGFloat = 120

  @GestureState private var dragOffset: CGFloat = 0

  internal var body: some View
  {
   style
    .makeBody(configuration: VLToast.StyleConfiguration(type: item.type,
                                                        message: .init(content: Text(verbatim: item.message))))
    .contentShape(.rect)
    .offset(y: dragOffset)
    .opacity(1.0 - min(abs(dragOffset) / opacityMaxDistance, 0.9))
    .gesture(DragGesture()
             .updating($dragOffset)
             {
              value, state, _ in
              if value.translation.height * swipeDirection > 0
              {
               state = value.translation.height
              }
             }
             .onEnded
             {
              value in
              if value.translation.height * swipeDirection > dragThreshold
              {
               dismiss()
              }
             })
    .onTapGesture(perform: dismiss)
    .accessibilityElement(children: .combine)
    .accessibilityAction(.default, dismiss)
    .accessibilityAction(.escape, dismiss)
  }
 }
}
