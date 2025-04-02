import SwiftUI
import Moya

struct Home: View {
    @StateObject private var viewModel = UserViewModel()
    @StateObject private var nfcReader = NFCReader()
    let provider = MoyaProvider<Api>(session: Session(interceptor: ApiInterceptor()))
    @EnvironmentObject private var toastManager: ToastManager
    let room = Room()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .center, spacing: 32){
                VStack{
                    HStack{
                        Text("출석체크")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color.dark)
                        Spacer()
                    }
                    
                    Image("Phone")
                        .padding(.bottom, 36)
                    
                    Button(action: {
                        nfcReader.read()
                        
                        nfcReader.onRead = { scannedText in
                            print("스캔된 데이터: \(scannedText)")
                            provider.request(.attend(room: scannedText)) { result in
                                switch result {
                                case .success(let response):
                                    do {
                                        let statusCode = response.statusCode
                                        if statusCode == 400 {
                                            let error = try response.map(ErrorModel.self)
                                            print(error)
                                            if (error.code == "TIME_UNAVAILABLE") {
                                                toastManager.showToast(message: "출석 실패", type: .error, detail: "출석할 수 없는 시간입니다.")
                                            } else {
                                                toastManager.showToast(message: "출석 실패", type: .error, detail: "네트워크 에러")
                                            }
                                            
                                        } else {
                                            print(try response.mapJSON())
                                            viewModel.fetchUserData()
                                            toastManager.showToast(message: "출석되었습니다.")
                                        }
                                    } catch {
                                        print("❌ JSON 파싱 오류: \(error.localizedDescription)")
                                    }
                                case .failure(let error):
                                    toastManager.showToast(message: "출석에 실패했습니다.", type: .error)
                                    print("error: \(error)")
                                }
                            }
                            
                        }
                    }) {
                        VStack {
                            Text("출석하기")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 18)
                        .frame(maxWidth: .infinity)
                        .background(Color.serveColor)
                        .cornerRadius(10)
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.05), radius: 5)
                
                VStack(spacing: 10) {
                    HStack{
                        Text("출석 현황")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color.dark)
                        Spacer()
                    }
                    VStack(spacing: 4){
                        HStack{
                            Text("출석 현황 :")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color.black)
                            if let status = viewModel.userData?.data.status {
                                Text(status == "ATTEND" ? "O" : "X")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(status == "ATTEND" ? Color.serveColor : Color.red)
                            } else {
                                Text("X")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color.red)
                            }
                            
                            
                            Spacer()
                        }
                        HStack{
                            Text("출석 장소 :")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color.black)
                            if let fixedRoom = viewModel.userData?.data.fixedRoom?.name {
                                Text(room.parseRoomName(fixedRoom))
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color.black)
                            } else {
                                Text("--")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color.black)
                            }
                            Spacer()
                        }
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.05), radius: 5)
            }
            .padding(.top, 16)
            .padding(.bottom, 128)
        }
        .onAppear {
            viewModel.fetchUserData()
        }
    }
}

#Preview {
    Home()
}
