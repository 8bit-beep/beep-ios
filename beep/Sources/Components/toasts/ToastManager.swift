import SwiftUI

class ToastManager: ObservableObject {
    static let shared = ToastManager()
    
    @Published var toastMessage: String?
    @Published var toastType: ToastType?
    @Published var detail: String?

    private var hideTask: DispatchWorkItem?

    func showToast(message: String, type: ToastType = .success, duration: TimeInterval = 3.4, detail: String = "") {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.hideTask?.cancel()

            self.toastMessage = message
            self.toastType = type
            self.detail = detail
            
            let task = DispatchWorkItem { [weak self] in
                self?.toastMessage = nil
            }
            self.hideTask = task
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: task)
        }
    }
}
