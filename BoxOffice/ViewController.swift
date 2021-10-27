//
//  ViewController.swift
//  BoxOffice
//
//  Created by mac on 2021/10/28.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var movieData:[MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchMovieData()
        
        self.dateLabel.text = DateType2String()
        print(DateType2String())
    }


}




extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 115
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as?
                TableViewCell else {return UITableViewCell()}
    
        let row = movieData[indexPath.row]
        
        cell.movieNmLabel.text = row.movieNm
        cell.openDtLabel.sizeToFit()
        cell.openDtLabel.text = row.openDt
        
        cell.rankLabel.text = row.rank
        return cell
    }
    
    
    func DateType2String() -> String{
            let current = Date()-86400
            
            let formatter = DateFormatter()
            //한국 시간으로 표시
            formatter.locale = Locale(identifier: "ko_kr")
            formatter.timeZone = TimeZone(abbreviation: "KST")
            //형태 변환
            formatter.dateFormat = "yyyyMMdd"
            
            return formatter.string(from: current)
        
        }
    
    
    func fetchMovieData() {
        
      
           let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=\(DateType2String())"
           
//        let parameters = [
//               "key":"3e0d05d7c5213aa072b4e3cfa2e595ec",
//               "targetDt":DateType2String(),
//           ]
        
           
        AF.request(url, method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    
                    let openDtData = item["openDt"].stringValue
                    let movieNmData = item["movieNm"].stringValue
                    let rankData = item["rank"].stringValue
                    
                    let data = MovieModel(openDt: openDtData, movieNm: movieNmData, rank: rankData)
                    
                    self.movieData.append(data)
                    
                }
                //중요!
                self.tableView.reloadData()
            
            case .failure(let error):
                print(error)
                }
            }

        }
    }
    

