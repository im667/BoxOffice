////
////  BoxAPIManager.swift
////  BoxOffice
////
////  Created by mac on 2021/10/28.
////
//
//import Foundation
//import Alamofire
//import SwiftyJSON
//
//class BoxAPIManager {
//    static let shared = BoxAPIManager()
//    
//    func DateType2String() -> String{
//            let current = Date()-86400
//            
//            let formatter = DateFormatter()
//            //한국 시간으로 표시
//            formatter.locale = Locale(identifier: "ko_kr")
//            formatter.timeZone = TimeZone(abbreviation: "KST")
//            //형태 변환
//            formatter.dateFormat = "yyyymmdd"
//            
//            return formatter.string(from: current)
//        
//        }
//   
//    
//    func fetchBoxData(text:String, result: @escaping (Int, JSON)->() ) {
//
//        
//        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=3e0d05d7c5213aa072b4e3cfa2e595ec&targetDt=\(DateType2String())"
//      
//        
//        let parameters = [
//            "key":"3e0d05d7c5213aa072b4e3cfa2e595ec",
//            "targetDt":DateType2String(),
//        ]
//        
//        
//        //1. 상태코드 :.validate(statusCode: 200...500)
//        //2. 상태코드 분기
//        AF.request(url, method: .get, parameters: parameters).validate(statusCode: 200...500).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("json: \(json)")
//                
//                let code = response.response?.statusCode ?? 500
//                
//                
//                result(code, json)
//                
//                print("JSON: \(json)")
//            case .failure(let error):
//                print(error) //네트워크 통신 자체가 안되는 경우
//            }
//        }
//        
//        
//    }
//    
//}
//
//
