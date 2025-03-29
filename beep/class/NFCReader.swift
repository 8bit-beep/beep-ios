import SwiftUI
import CoreNFC

class NFCReader: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {
    @Published var scannedMessage: String?
    
    private var session: NFCNDEFReaderSession?
    
    func startScanning() {
        guard NFCNDEFReaderSession.readingAvailable else {
            print("NFC 지원되지 않음")
            return
        }
        
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.alertMessage = "NFC 태그를 스캔하세요."
        session?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        if let record = messages.first?.records.first,
           let payloadText = String(data: record.payload.advanced(by: 3), encoding: .utf8) {
            DispatchQueue.main.async {
                self.scannedMessage = payloadText
            }
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("NFC 스캔 실패:", error.localizedDescription)
    }
}
