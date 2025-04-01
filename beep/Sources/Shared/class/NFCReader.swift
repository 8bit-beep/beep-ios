import CoreNFC
import SwiftUI

public class NFCReader: NSObject, NFCNDEFReaderSessionDelegate, ObservableObject {
    @Published public var raw = "스캔 후 데이터가 표시됩니다."
    @Published public var isScanning = false
    public var onRead: ((String) -> Void)?

    public var session: NFCNDEFReaderSession?
    
    
    public func read() {
        guard NFCNDEFReaderSession.readingAvailable else {
            print("NFC를 사용할 수 없습니다.")
            return
        }
        
        isScanning = true
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.alertMessage = "NFC를 이용해 출석을 진행합니다."
        session?.begin()
    }
    
    public func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        DispatchQueue.main.async {
            self.isScanning = false
            
            if let record = messages.first?.records.first,
               let text = self.decodeTextPayload(record.payload) {
                self.raw = text
            } else {
                self.raw = "읽을 수 없는 데이터"
            }
            
            self.onRead?(self.raw)
        }
    }
    
    public func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        DispatchQueue.main.async {
            self.isScanning = false
            self.session = nil
        }
    }

    private func decodeTextPayload(_ payload: Data) -> String? {
        guard payload.count > 0 else { return nil }
        
        let statusByte = payload[0]
        let encoding = (statusByte & 0x80) == 0 ? String.Encoding.utf8 : String.Encoding.utf16
        let languageCodeLength = Int(statusByte & 0x3F)
        
        guard 1 + languageCodeLength < payload.count else { return nil }
        
        return String(data: payload.subdata(in: (1 + languageCodeLength)..<payload.count), encoding: encoding)
    }
}
