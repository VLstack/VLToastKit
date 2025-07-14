import VLstackNamespace
import SwiftUI

extension VLstack.Toast
{
 internal struct DefaultStyleView: View
 {
  @Environment(\.toastMessageFont) private var messageFont
  @Environment(\.toastMessageColor) private var messageColor
  @Environment(\.toastBackgroundColor) private var backgroundColor
  @Environment(\.toastSuccessColor) private var successColor
  @Environment(\.toastInfoColor) private var infoColor
  @Environment(\.toastWarningColor) private var warningColor
  @Environment(\.toastDangerColor) private var dangerColor

  internal let configuration: VLstack.Toast.StyleConfiguration

  private let dragThreshold: CGFloat = 30
  private let opacityMaxDistance: CGFloat = 120
  private let dismissOffset: CGFloat = 150

  @GestureState private var dragOffset: CGSize = .zero
  @State private var finalOffset: CGFloat = 0
  @State private var isDismissing: Bool = false

  internal var body: some View
  {
   let dragAmount: CGFloat = finalOffset + dragOffset.height
   let dynamicOpacity: CGFloat = isDismissing ? 0 : 1.0 - min(abs(dragAmount) / opacityMaxDistance, 0.9)
   let color = foregroundStyle(configuration.type)

   VStack(alignment: .leading)
   {
    HStack(alignment: .firstTextBaseline)
    {
     icon(configuration.type)
      .imageScale(.large)

     configuration.message
      .foregroundStyle(Color(.label))
      .multilineTextAlignment(.leading)

     Spacer(minLength: 10)

     Image(systemName: "xmark")
      .imageScale(.small)
    }
    .font(messageFont)
    .foregroundStyle(color)
    .padding()
   }
   .background(Color(.systemBackground))
   .overlay(alignment: .leading)
   {
    Rectangle()
    .fill(color)
    .frame(width: 6)
   }
   .frame(minWidth: 0, maxWidth: .infinity)
   .clipShape(.rect(cornerRadius: 10))
   .overlay
   {
    RoundedRectangle(cornerRadius: 10)
     .stroke(color, lineWidth: 1)
   }
   .contentShape(.rect(cornerRadius: 10))
   .padding(.horizontal, 16)
   .offset(y: isDismissing ? -dismissOffset : dragAmount)
   .opacity(dynamicOpacity)
   .animation(.spring(response: 0.4, dampingFraction: 0.85), value: isDismissing)
   .animation(.easeOut(duration: 0.2), value: finalOffset)
   .gesture(DragGesture()
            .updating($dragOffset)
            {
             value, state, _ in
             if value.translation.height < 0
             {
              state = value.translation
             }
            }
            .onEnded
            {
             value in
             // Swipe vers le haut
             if value.translation.height < -dragThreshold
             {
              finalOffset = value.translation.height
              dismiss()
             }
             else
             {
              finalOffset = 0
             }
            })
   .onTapGesture(perform: dismiss)
  }
 }
}

private extension VLstack.Toast.DefaultStyleView
{
 // MARK: - Functions
 func foregroundStyle(_ type: VLstack.Toast.ItemType) -> Color
 {
  switch type
  {
   case .danger: dangerColor
   case .info: infoColor
   case .success: successColor
   case .warning: warningColor
  }
 }

 func icon(_ type: VLstack.Toast.ItemType) -> Image
 {
  switch type
  {
   case .danger: Image(systemName: "xmark.circle.fill")
   case .info: Image(systemName: "info.circle.fill")
   case .success: Image(systemName: "checkmark.circle.fill")
   case .warning: Image(systemName: "exclamationmark.circle.fill")
  }
 }

 func dismiss()
 {
  withAnimation { isDismissing = true }
  DispatchQueue.main.asyncAfter(deadline: .now() + 0.25)
  {
   configuration.onDismiss()
  }
 }
}
