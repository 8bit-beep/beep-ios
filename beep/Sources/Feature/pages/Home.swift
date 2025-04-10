import SwiftUI
import Moya

struct Home: View {
    @StateObject private var nfcReader = NFCReader()
    let provider = MoyaProvider<Api>(session: Session(interceptor: ApiInterceptor()))
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject private var toastManager: ToastManager
    let room = Room()
    @State var navigateToRegister = false
    
    var body: some View {
        if navigateToRegister {
            NavigationLink(destination: RegisterRoom().environmentObject(toastManager), isActive: $navigateToRegister){
                EmptyView()
                    .frame(width: 0, height: 0)
            }.frame(width: 0, height: 0)
        }
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .center, spacing: 32){
                VStack{
                    HStack{
                        Text("출석체크")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color.dark)
                        Spacer()
                    }
                    
                    ZStack{
                        VStack{
                            HStack{
                                Spacer()
                                if viewModel.userData?.data.status != "ATTEND" {
                                    GifImage("zzz")
                                        .frame(width: 56, height: 56)
                                } else {
                                    Spacer()
                                    Spacer()
                                    Image("Smile")
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                        VStack{
                            Spacer()
                            Image("Phone")
                                .resizable()
                                .frame(width: 240, height: 240)
                                .padding(.bottom, 36)
                        }
                        
                    }
                    .frame(width: 240, height: 280)
                    
                    
                    
                    
                    Button{
                        if let status = viewModel.userData?.data.status, status == "ATTEND" {
                            provider.request(.cancelAttend) { result in
                                switch result {
                                case .success(let response):
                                    do {
                                        let statusCode = response.statusCode
                                        if statusCode == 400 {
                                            let error = try response.map(ErrorModel.self)
                                            print(error)
                                            if (error.code == "TIME_UNAVAILABLE") {
                                                toastManager.showToast(message: "퇴실 실패", type: .error, detail: "퇴실할 수 없는 시간입니다.")
                                            } else {
                                                toastManager.showToast(message: "퇴실 실패", type: .error, detail: "네트워크 에러")
                                            }
                                        } else {
                                            toastManager.showToast(message: "퇴실되었습니다.")
                                            viewModel.fetchUserData()
                                        }
                                    } catch {
                                        toastManager.showToast(message: "퇴실 실패", type: .error, detail: "네트워크 에러")
                                    }
                                    
                                    break
                                case .failure:
                                    toastManager.showToast(message: "퇴실 실패", type: .error, detail: "네트워크 에러")
                                    break
                                }
                            }
                        } else {
                            nfcReader.clearData()
                            nfcReader.read()
                            
                            nfcReader.onRead = { scannedText in
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
                                                } else if (error.code == "ROOM_MISMATCH") {
                                                    toastManager.showToast(message: "출석 실패", type: .error, detail: "다른 스터디실 입니다.")
                                                }
                                                else {
                                                    toastManager.showToast(message: "출석 실패", type: .error, detail: "네트워크 에러")
                                                }
                                            } else {
                                                toastManager.showToast(message: "출석되었습니다.")
                                                viewModel.fetchUserData()
                                            }
                                        } catch {
                                            print("❌ JSON 파싱 오류: \(error.localizedDescription)")
                                        }
                                        break
                                    case .failure(let error):
                                        toastManager.showToast(message: "출석에 실패했습니다.", type: .error)
                                        print("error: \(error)")
                                        break
                                    }
                                }
                                nfcReader.clearData()
                            }
                            
                        }
                    } label: {
                        if let status = viewModel.userData?.data.status {
                            VStack {
                                Text(status == "ATTEND" ? "퇴실하기" : "출석하기")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical, 18)
                            .frame(maxWidth: .infinity)
                            .background(status == "ATTEND" ? Color.red : Color.serveColor)
                            .cornerRadius(10)
                        } else {
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
        .onReceive(viewModel.$userData) { userData in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if userData?.data != nil, userData?.data.fixedRoom?.name == nil {
                    navigateToRegister = true
                }
            }
        }
        .onAppear {
            navigateToRegister = false
            
            viewModel.fetchUserData()
        }
    }
}

#Preview {
    Home()
}
