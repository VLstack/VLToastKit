import SwiftUI

struct VLToastView: View
{
 var toast: VLToast
 var onCancelTapped: (() -> Void)
 
 var body: some View
 {
  VStack(alignment: .leading)
  {
   HStack(alignment: .firstTextBaseline)
   {
    Image(systemName: toast.type.style.symbolName)
     .foregroundStyle(toast.type.style.color)
    
    VStack(alignment: .leading)
    {
     if let title = toast.title
     {
      Text(title)
       .font(toast.type.style.titleFont)
       .foregroundStyle(toast.type.style.titleColor)
     }
     
     Text(toast.message)
      .font(toast.type.style.messageFont)
      .foregroundStyle(toast.type.style.messageColor)
    }
    
    Spacer(minLength: 10)
    
    Button(action: onCancelTapped)
    {
     Image(systemName: "xmark")
      .foregroundStyle(toast.type.style.titleColor)
    }
   }
   .padding()
  }
  .background(toast.type.style.backgroundColor)
  .overlay(alignment: .leading)
  {
   Rectangle()
   .fill(toast.type.style.color)
   .frame(width: 6)
  }
  .frame(minWidth: 0, maxWidth: .infinity)
  .clipShape(.rect(cornerRadius: 8))
  .shadow(color: Color.black.opacity(0.25),
          radius: 4,
          x: 0,
          y: 1)
  .padding(.horizontal, 16)
 }
}
