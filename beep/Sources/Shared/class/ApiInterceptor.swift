import Alamofire
import Moya
import Foundation

final class ApiInterceptor: RequestInterceptor, @unchecked Sendable {
    private var isRefreshing = false
    let provider = MoyaProvider<Api>()
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var urlRequest = urlRequest
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            print("저장")
        } else {
            print("엑세스 저장 x")
        }
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        guard request.task?.response is HTTPURLResponse else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        guard let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        if isRefreshing {
            return
        }
        
        self.isRefreshing = true
        
        provider.request(.reissueToken(refreshToken: refreshToken)) { result in
            switch result {
            case .success(let response):
                do {
                    let tokenData = try response.map(LoginModel.self)
                    UserDefaults.standard.set(tokenData.accessToken, forKey: "accessToken")
                    completion(.retry)
                } catch {
                    print("❌ 토큰 파싱 실패: \(error.localizedDescription)")
                    completion(.doNotRetryWithError(error))
                    UserDefaults.standard.removeObject(forKey: "accessToken")
                    UserDefaults.standard.removeObject(forKey: "refreshToken")
                }
            case .failure(let error):
                print("❌ 토큰 재발급 실패: \(error.localizedDescription)")
                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")
                completion(.doNotRetryWithError(error))
            }
            
            self.isRefreshing = false
        }
    }
}
