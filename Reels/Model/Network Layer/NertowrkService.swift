//
//  NertowrkService.swift
//  Reels
//
//  Created by Hassan on 29/07/2022.
//

import Foundation
import Alamofire

class NetworkService {
    static let shared = NetworkService()
    
    private init(){}
    
    func fetchData<T: Decodable>(calssName: T.Type ,completionHandler: @escaping (Result<T? , Error>) -> ())
      {
          
          AF.request(Constants.API_URL).validate().responseDecodable(of: T.self) { response in
              switch response.result
              {
              case .success:
                  guard let data = response.value else {return}
                  print(data)
                  completionHandler( .success(data))

              case .failure(let error):
                  print(error)
                  completionHandler(.failure(error))
              }
          }
      }
    
}
