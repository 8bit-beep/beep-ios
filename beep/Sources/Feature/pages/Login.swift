//
//  Login.swift
//  beep
//
//  Created by cher1shRXD on 4/1/25.
//

import SwiftUI
import Moya

struct Login: View {
    @State var dauthId: String = ""
    @State var dauthPw: String = ""
    @State var loading: Bool = false
    let provider = MoyaProvider<Api>()
    @EnvironmentObject private var toastManager: ToastManager
    
    var body: some View {
        VStack(alignment: .center, spacing: 40){
            Spacer()
            Image("Logo")
                .resizable()
                .frame(width: 80, height: 80)
            
            VStack(alignment: .leading, spacing: 16){
                HStack(alignment: .center, spacing: 0){
                    Text("도담도담")
                        .font(.system(size: 20))
                        .foregroundStyle(Color(hex: "0083F0"))
                    Text("으로 로그인")
                        .font(.system(size: 20))
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                TextField("도담도담 아이디", text: $dauthId)
                    .padding(16)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: Color(hex: "F0F0F0"), radius: 8)
                    .hideKeyBoard()
                
                SecureField("도담도담 비밀번호", text: $dauthPw)
                    .padding(16)
                    .background(.white)
                    .cornerRadius(16)
                    .shadow(color: Color(hex: "F0F0F0"), radius: 8)
                    .hideKeyBoard()
                
            }
            
            Button {
                if dauthId.isEmpty || dauthPw.isEmpty {
                    return
                }
                loading = true
                provider.request(.login(dauthId: dauthId, dauthPw: dauthPw)) { result in
                    switch result {
                    case .success(let response):
                        do {
                            let json = try response.map(DauthModel.self)
                            
                            let codeSubstring = json.data.location.components(separatedBy: "code=")[1].split(separator: "&")[0]
                            let code = String(codeSubstring)
                            
                            provider.request(.getToken(code: code)) { tokenResult in
                                switch tokenResult {
                                case .success(let tokenResponse):
                                    do {
                                        let tokenData = try tokenResponse.map(LoginModel.self)
                                        UserDefaults.standard.setValue(tokenData.accessToken, forKey: "accessToken")
                                        UserDefaults.standard.setValue(tokenData.refreshToken, forKey: "refreshToken")
                                        print(tokenData.accessToken)
                                        toastManager.showToast(message: "로그인 성공")
                                    } catch{
                                        toastManager.showToast(message: "로그인 실패", type: .error, detail:"네트워크 에러")
                                    }
                                    break
                                case .failure:
                                    toastManager.showToast(message: "로그인 실패", type: .error, detail:"네트워크 에러")
                                    break
                                }
                                loading = false
                            }
                            
                        } catch {
                            toastManager.showToast(message: "로그인 실패", type: .error, detail:"아이디, 비밀번호를 확인해주세요.")
                            loading = false
                        }
                        
                    case .failure:
                        toastManager.showToast(message: "로그인 실패", type: .error, detail:"네트워크 에러")
                        loading = false
                        break
                    }
                }
                
            } label: {
                HStack(alignment: .center) {
                    Text(loading ? "로그인 중..." : "로그인하기")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.white)
                }
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(dauthId.isEmpty || dauthPw.isEmpty || loading ? Color.grey : Color(hex: "0083F0"))
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.05), radius: 5)
            }
            .disabled(dauthId.isEmpty || dauthPw.isEmpty || loading)
            Spacer()
            Spacer()
            
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .navigationBarBackButtonHidden(true)
    }
    
}

#Preview {
    Login()
}
