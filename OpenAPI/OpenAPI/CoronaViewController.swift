//
//  CoronaViewController.swift
//  OpenAPI
//
//  Created by meng on 2021/03/04.
//

import Charts
import UIKit
import Alamofire


class CoronaViewController: UIViewController, ChartViewDelegate {
    

    @IBOutlet weak var titleInfo: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var totalInfectedCase: UILabel!
    @IBOutlet weak var totalRecovered: UILabel!
    @IBOutlet weak var totalDeath: UILabel!
    @IBOutlet weak var totalTreating: UILabel!
    
    @IBOutlet weak var beforeToTodayRecover: UILabel!
    @IBOutlet weak var beforeToTodayDeath: UILabel!
    @IBOutlet weak var beforeToTodayTreating: UILabel!
    
    var entries = [PieChartDataEntry]()
    var totalInfo: TotalCorona?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
        getName()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let name1 = totalInfo?.city1n, let name2 = totalInfo?.city2n, let name3 = totalInfo?.city3n , let name4 = totalInfo?.city4n , let name5 = totalInfo?.city5n else {
            return
        }
        guard let tmp1 = totalInfo?.city1p, let tmp2 = totalInfo?.city2p, let tmp3 = totalInfo?.city3p , let tmp4 = totalInfo?.city4p , let tmp5 = totalInfo?.city5p else {
            return
        }
        guard let v1 = Double(tmp1), let v2 = Double(tmp2), let v3 = Double(tmp3), let v4 = Double(tmp4), let v5 = Double(tmp5) else {
            return
        }
        let entry1 = PieChartDataEntry(value: v1, label: name1)
        let entry2 = PieChartDataEntry(value: v2, label: name2)
        let entry3 = PieChartDataEntry(value: v3, label: name3)
        let entry4 = PieChartDataEntry(value: v4, label: name4)
        let entry5 = PieChartDataEntry(value: v5, label: name5)
        entries = [entry1, entry3, entry4, entry5, entry2]
        updateChartUI()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let labelText = entry.value(forKey: "label")! as! String
        let num = Double(entry.value(forKey: "value")! as! Double)
        pieChart.centerText = """
        \(labelText)
        \(num) %
        """
    }
    
    func getName(){
        let url = "https://api.corona-19.kr/korea/?serviceKey=bTZ1HjtMvm27FlYq3Lr8u4ihk6x5wDXzn"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result{
                case .success:
                    guard let result = response.data else { return }
                    do{
                        let response = try JSONDecoder().decode(TotalCorona.self, from: result)
                        DispatchQueue.main.async{
                            self.totalInfo = response
                            self.updateUI(totalCoronaInfo: response)
                        }
                    }catch{
                        print(error)
                    }
                default:
                    return
                }
        }
    }
    
    func updateUI(totalCoronaInfo : TotalCorona){
        self.titleInfo.text = totalCoronaInfo.updateTime
        self.totalInfectedCase.text = totalCoronaInfo.TotalCase + "명"
        self.totalRecovered.text = totalCoronaInfo.TotalRecovered + "명"
        self.totalDeath.text = totalCoronaInfo.TotalDeath + "명"
        self.totalTreating.text = totalCoronaInfo.NowCase + "명"
        self.beforeToTodayRecover.text = totalCoronaInfo.TodayRecovered + "명"
        self.beforeToTodayDeath.text = totalCoronaInfo.TodayDeath + "명"
        self.beforeToTodayTreating.text = totalCoronaInfo.TotalCaseBefore + "명"
        if(totalCoronaInfo.TodayRecovered[totalCoronaInfo.TodayRecovered.startIndex] != "-"){
            self.beforeToTodayRecover.text = "+" + (self.beforeToTodayRecover.text ?? "")
        }

        if(totalCoronaInfo.TodayDeath[totalCoronaInfo.TodayDeath.startIndex] != "-"){
            self.beforeToTodayDeath.text = "+" + (self.beforeToTodayDeath.text ?? "")
        }
        if(totalCoronaInfo.TotalCaseBefore[totalCoronaInfo.TotalCaseBefore.startIndex] != "-"){
            self.beforeToTodayTreating.text = "+" + (self.beforeToTodayTreating.text ?? "")
        }
    }
    
    func updateChartUI(){
        let set = PieChartDataSet(entries: entries, label: nil)
        set.colors = ChartColorTemplates.colorful()
        let chartData = PieChartData(dataSet: set)
        pieChart.data = chartData
        //pieChart.backgroundColor = UIColor.systemBackground
        pieChart.holeColor = UIColor.systemGray6
    }
    
}
