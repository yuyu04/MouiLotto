//
//  MouiLottoEndpoint.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/28.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation
import Moya

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

enum ApiServer {
    case token
    case event
    case notification
    case mainPageEvents
}

extension ApiServer: TargetType {
    var baseURL: URL {
        return URL(string: "https://gateway.marvel.com/v1/public")!
    }
    
    var path: String {
        switch self {
        case .token:
            return "/users"
        case .event:
            return "/users"
        case .notification:
            return "/repos"
        case .mainPageEvents:
            return "/eventImages"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var sampleData: Data {
        switch self {
        case .token:
            return Data()
        case .event:
            return Data()
        case .notification:
            return Data()
        case .mainPageEvents:
            return Data()
        }
    }
    
    var task: Task {
        return .requestPlain
//        switch self {
//        case .mainPageEvents:
//          // 3
//          return .requestParameters(
//            parameters: [
//              "format": "comic",
//            encoding: URLEncoding.default)
//        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    public var headers: [String: String]? {
      return ["Content-Type": "application/json"]
    }

    // 7
    public var validationType: ValidationType {
      return .successCodes
    }
}
