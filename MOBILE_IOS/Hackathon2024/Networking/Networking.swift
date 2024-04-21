//
//  Networking.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 20.04.2024.
//

import Foundation
import Alamofire
import SwiftyJSON

final class Networking {
    static func prepareURL(endpoint: Endpoint) -> URL? {
        let urlString = baseURL + endpoint.rawValue
        return URL(string: urlString)
    }
    
    static func performRequest(method: HTTPMethod, endPoint: Endpoint, params: [String: Any]?, withToken: Bool, completion: @escaping (JSON?) -> Void) {
        
        OverlayIndicator.present()
        
        let parameterEncoding: ParameterEncoding
        if method == .post || method == .put {
            parameterEncoding = JSONEncoding.default
        } else {
            parameterEncoding = URLEncoding.default
        }
        
        guard let url = prepareURL(endpoint: endPoint) else { return }
        let request = AF.request(url,
                   method: method,
                   parameters: params,
                   encoding: parameterEncoding,
                   headers: getHeaders(withToken: withToken))
        .cURLDescription { description in
            if endPoint != .signUp {
                debugPrint(description)
            }
        }
        
        request.responseJSON { response in
            
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let json = try JSON(data: data)
                        completion(json)
                    } catch let error {
                        debugPrint(error.localizedDescription)
                        debugPrint(response.response?.statusCode)
                    }
                }
            case .failure(let error):
                debugPrint(response.response?.statusCode)
                completion(nil)
            }
            OverlayIndicator.hide()
        }
    }
}

extension Networking {
    static func getHeaders(withToken: Bool) -> HTTPHeaders {
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Неизвестная версия"

        if withToken {
            return HTTPHeaders(["Accept": "application/json",
                                "Content-Type": "application/json",
                                "Authorization": "Bearer \(token)"])
        } else {
            return HTTPHeaders(["Accept": "application/json",
                                "Content-Type": "application/json"
                               ]
            )
        }
    }
}
