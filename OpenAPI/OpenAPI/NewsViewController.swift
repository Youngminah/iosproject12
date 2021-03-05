//
//  NewsViewController.swift
//  OpenAPI
//
//  Created by meng on 2021/03/04.
//

import UIKit
import Alamofire

class NewsViewController: UITableViewController{


    var news : Response?
    override func viewDidLoad() {
        super.viewDidLoad()
        getName()
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print(news)
        if let newsdata = news?.articles {
            return newsdata.count
        }
        else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else{
            return UITableViewCell()
        }
        guard let newsdata = news else {
            return UITableViewCell()
        }
        cell.updateUI(news: newsdata, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    func getName(){
        let url = "https://newsapi.org/v2/top-headlines?country=kr&apiKey=4a2e936c4da34186afc689f99e36bddf"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                switch response.result{
                case .success:
                    guard let result = response.data else { return }
                    do{
                        let response = try JSONDecoder().decode(Response.self, from: result)
                        DispatchQueue.main.async{
                            self.news = response
                            self.tableView.reloadData()
                        }
                    }catch{
    
                    }
                default:
                    return
                }

        }
    }
    

}

class NewsCell: UITableViewCell{
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsName: UILabel!
    
    func updateUI(news: Response, indexPath: IndexPath){
        
        guard let newsdata = news.articles else {
            return
        }
        newsTitle.text = newsdata[indexPath.row].title
        newsName.text = newsdata[indexPath.row].source.name
        guard let img = newsdata[indexPath.row].urlToImage else {
            return
        }
        guard let url = URL(string: img) else {
            return
        }
        if let data = try? Data(contentsOf: url) {
            DispatchQueue.main.async {
                self.newsImage.image = UIImage(data: data)
            }
        }
        
    }
}
