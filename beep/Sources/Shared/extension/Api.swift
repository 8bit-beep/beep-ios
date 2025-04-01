import Moya
import Foundation

enum Api {
    case getMe
    case login(dauthId: String, dauthPw: String)
    case getToken(code: String)
}

extension Api: TargetType {
    var baseURL: URL {
        switch self {
        case .login: return URL(string: "https://dauth.b1nd.com/api")!
        default: return URL(string: "https://beepapi.com")!
        }
        
    }
    
    var path: String {
        switch self {
        case .getMe:
            return "/users"
        case .login:
            return "/auth/login"
        case .getToken:
            return "/dauth/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMe:
            return .get
        case .login, .getToken:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getMe:
            return .requestPlain
        case .login(let dauthId, let duathPw):
            return .requestParameters(
                parameters: [
                    "id": dauthId,
                    "pw": duathPw,
                    "clientId": "575fe863c46f4126a9c17e4af4b82d5d351bdff5507d454086a88edd19afa723",
                    "redirectUrl": "https://beep.cher1shrxd.me/callback/dauth"
                ], encoding: JSONEncoding.default)
        case .getToken(let code):
            return .requestParameters(
                parameters: [
                    "code": code,
                ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}

