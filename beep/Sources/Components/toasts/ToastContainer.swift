import SwiftUI

struct ToastContainer: View {
    @EnvironmentObject var toastManager: ToastManager
    
    var body: some View {
        ZStack {
            if let message = toastManager.toastMessage, let toastType = toastManager.toastType, let detail = toastManager.detail {
                ToastView(message: message, detail: detail, toastType: toastType) {
                    toastManager.toastMessage = nil
                }
            }
        }
        .animation(.easeInOut(duration: 0.2), value: toastManager.toastMessage)
    }
}
