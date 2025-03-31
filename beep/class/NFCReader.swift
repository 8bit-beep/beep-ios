import Foundation
import CoreNFC

class NFCManager: NSObject, NFCNDEFReaderSessionDelegate, ObservableObject {
    var session: NFCNDEFReaderSession?

    func startScanning() {
        guard NFCNDEFReaderSession.readingAvailable else {
            print("NFC를 사용할 수 없습니다.")
            return
        }

        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.alertMessage = "NFC 태그를 스캔하세요."
        session?.begin()
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                if let text = String(data: record.payload, encoding: .utf8) {
                    DispatchQueue.main.async {
                        print("NFC 데이터: \(text)")
                    }
                }
            }
        }
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        DispatchQueue.main.async {
            print("NFC 읽기 실패: \(error.localizedDescription)")
        }
    }
}
