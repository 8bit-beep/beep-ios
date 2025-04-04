import SwiftUI

enum ToastType {
    case success
    case error
}

struct ToastView: View {
    var message: String
    var detail: String
    var toastType: ToastType
    var duration: TimeInterval = 3.0
    var onDismiss: (() -> Void)?
    
    @State private var isVisible: Bool = false
    
    var body: some View {
        VStack {
            if isVisible {
                HStack(alignment: .center, spacing: 16) {
                    Image(systemName: toastType == .success ? "checkmark.circle.fill" : "x.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(toastType == .success ? Color.green : Color.red)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(message)
                            .font(.system(size: 18))
                        
                        if !detail.isEmpty {
                            Text(detail)
                                .font(.system(size: 14, weight: .light))
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isVisible = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            onDismiss?()
                        }
                    } label: {
                        Image("X")
                            .resizable()
                            .frame(width: 12, height: 12)
                    }
                }
                .padding(.horizontal, 16)
                .frame(width: UIScreen.main.bounds.width - 32, height: 80)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.4), radius: 4)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.2)) {
                isVisible = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isVisible = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    onDismiss?()
                }
            }
        }
    }
}
