import SwiftUI

extension VLToast
{
 internal struct DefaultStyleView: View
 {
  internal let configuration: VLToast.StyleConfiguration
  internal let font: Font
  internal let colors: VLToast.DefaultStyle.Colors

  internal var body: some View
  {
   let color = typeColor(configuration.type)

   HStack(alignment: .firstTextBaseline)
   {
    icon(configuration.type)
     .imageScale(.large)
     .foregroundStyle(color)
     .accessibilityHidden(true)

    configuration.message
     .foregroundStyle(colors.message)
     .multilineTextAlignment(.leading)

    Spacer(minLength: 10)

    Image(systemName: "xmark")
     .imageScale(.small)
     .foregroundStyle(color)
     .accessibilityHidden(true)
   }
   .font(font)
   .padding()
   .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
   .background(colors.background)
   .overlay(alignment: .leading)
   {
    Rectangle()
     .fill(color)
     .frame(width: 6)
   }
   .clipShape(.rect(cornerRadius: 10))
   .overlay
   {
    RoundedRectangle(cornerRadius: 10)
     .stroke(color, lineWidth: 1)
   }
  }
 }
}

private extension VLToast.DefaultStyleView
{
 // MARK: - Functions
 func typeColor(_ type: VLToast.ItemType) -> Color
 {
  switch type
  {
   case .danger: colors.danger
   case .info: colors.info
   case .success: colors.success
   case .warning: colors.warning
  }
 }

 func icon(_ type: VLToast.ItemType) -> Image
 {
  switch type
  {
   case .danger: Image(systemName: "xmark.circle.fill")
   case .info: Image(systemName: "info.circle.fill")
   case .success: Image(systemName: "checkmark.circle.fill")
   case .warning: Image(systemName: "exclamationmark.circle.fill")
  }
 }
}
