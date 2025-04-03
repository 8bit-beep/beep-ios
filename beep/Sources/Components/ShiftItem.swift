//
//  ShiftItem.swift
//  beep
//
//  Created by cher1shRXD on 3/31/25.
//

import SwiftUI
import Moya

struct ShiftItem: View {
    let shiftData: ShiftModel
    @Binding var isUpdated: Bool
    let room = Room()
    let provider = MoyaProvider<Api>(session: Session(interceptor: ApiInterceptor()))
    @EnvironmentObject var toastManager: ToastManager
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 4){
                if let fixedRoom = shiftData.fixedRoom,
                   let shiftRoom = shiftData.shiftRoom {
                    HStack(alignment: .center, spacing: 4){
                        Text(room.parseRoomName(fixedRoom))
                            .font(.system(size: 16, weight: .semibold))
                        
                        Image("ArrowRight")
                            .resizable()
                            .frame(width: 16, height: 16)
                        
                        Text(room.parseRoomName(shiftRoom))
                            .font(.system(size: 16, weight: .semibold))
                    }
                    
                }
                
                if let period = shiftData.period,
                   let status = shiftData.status {
                    HStack(alignment: .center, spacing: 4){
                        Text("\(period)~\(period + 1)교시")
                            .font(.system(size: 14, weight: .medium))
                        Text("·")
                        Text(status == "APPROVED" ? "승인됨" : status == "REJECTED" ? "거절됨" : "대기중")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(status == "APPROVED" ? Color.serveColor : status == "REJECTED" ? Color.red : Color.main)
                    }
                    
                }
                    
                if let reason = shiftData.reason {
                    Text(reason)
                        .font(.system(size: 12, weight: .light))
                }
                
            }
            Spacer()
            Button {
                provider.request(.deleteShift(id: shiftData.id!)) { result in
                    switch result {
                    case .success:
                        self.isUpdated.toggle()
                        toastManager.showToast(message: "삭제 성공", detail: "실 이동 요청이 삭제되었습니다.")
                    case .failure:
                        toastManager.showToast(message: "삭제 실패", type: .error, detail: "네트워크 에러")
                    }
                }
            } label: {
                Image("X").resizable().frame(width: 16, height: 16)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "FBFBFB"))
        .cornerRadius(20)
        .shadow(color: Color(hex: "FBFBFB"), radius: 5)
    }
}
