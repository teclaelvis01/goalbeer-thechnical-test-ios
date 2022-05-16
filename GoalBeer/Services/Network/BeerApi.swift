//
//  BeerApi.swift
//  GoalBeer
//
//  Created by Elvis Reyes on 14/5/22.
//

import Foundation
import Moya

enum ApiUrl: String {
    case beers = "https://api.punkapi.com/v2"
}

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

let beerProvider = MoyaProvider<BeerApi>(plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter),logOptions: .verbose))])

public enum BeerApi{
    case beers(parameters: [String:Any])
}

extension BeerApi: TargetType{
    public var baseURL: URL {
        return URL(string: ApiUrl.beers.rawValue)!
    }
    
    public var path: String {
        switch self {
        case .beers:
            return "/beers"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .beers:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .beers(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var validationType: ValidationType{
        switch self {
        case .beers:
            return .successCodes
        }
    }
    
    
}
