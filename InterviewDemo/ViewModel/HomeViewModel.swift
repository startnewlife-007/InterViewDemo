//
//  HomeViewModel.swift
//  InterviewDemo
//
//  Created by MacBook Pro on 2021/3/1.
//

import UIKit
class HomeViewModel {
    var homeDataArr = [HomeData]()
    weak var vc: ViewController?
    private lazy var timer: DispatchSourceTimer? = {
        var t = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        t.schedule(deadline: .now(), repeating: DispatchTimeInterval.seconds(5), leeway: DispatchTimeInterval.seconds(0))
        return t
    }()
    /// 每隔5秒刷新一次数据
    func fetchData(url:String) {
        //根据得到的数据，刷新列表，本地数据和请求数据都会用到，为提高复用单独抽成一个函数
        func handleData(_ data: Dictionary<String, Any>) {
            self.homeDataArr.removeAll()
            for (key,value) in data {
                let m: HomeData = HomeData(key: key, value: value as! String)
                self.homeDataArr.append(m)
            }
            self.vc?.tableView.reloadData()
            self.cacheRequestData(data: data as AnyObject, key: url)
        }
        //先显示历史数据
        if let history = queryRequestData(key: url) as? Dictionary<String, Any> {
            handleData(history)
        }
        
        timer?.setEventHandler {
            self.cacheRequestTimeSquence()
            NetWorkHelper.shared.GET(url: url) {[weak self](dict, error) in
                handleData(dict!)
                
                
            }
        }
        timer?.resume()
    }
    /// 缓存请求的数据
    func cacheRequestData(data: AnyObject?,key: String) {
        guard let _ = data else {
            return
        }
        UserDefaults.standard.set(data,forKey: key)
    }
    /// 缓存请求的数据从缓存中取数据
    func queryRequestData(key: String) -> AnyObject {
        UserDefaults.standard.object(forKey: key) as AnyObject
    }
    /// 缓存每次请求的时间
    func cacheRequestTimeSquence() {
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyy-MM-dd' at 'HH:mm:ss"
        let strNowTime = timeFormatter.string(from: date) as String
        
        if UserDefaults.standard.object(forKey: "history") == nil {
            var historyArray = [String]()
            historyArray.append(strNowTime)
            UserDefaults.standard.set(historyArray, forKey: "history")
        } else {
            var historyArray = UserDefaults.standard.object(forKey: "history") as! [String]
            historyArray.append(strNowTime)
            UserDefaults.standard.set(historyArray, forKey: "history")
        }
    }
    
    
}
