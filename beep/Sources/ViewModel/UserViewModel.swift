import Foundation
import Moya

class UserViewModel: ObservableObject {
    @Published var userData: UserModel?
    private let provider = MoyaProvider<Api>(session: Session(interceptor: ApiInterceptor()))

    func fetchUserData() {
        provider.request(.getMe) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try response.map(UserModel.self)
                    print(data)
                    DispatchQueue.main.async {
                        self.userData = data
                    }
                } catch {
                    print("❌ JSON 디코딩 실패: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("❌ API 호출 실패: \(error.localizedDescription)")
            }
        }
    }
}
