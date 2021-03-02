//
//  NetWorkHelper.swift
//  InterviewDemo
//
//  Created by MacBook Pro on 2021/3/1.
//

import Foundation

class NetWorkHelper {
    static let shared = NetWorkHelper()
    /// get请求方法
    ///
    /// - Parameter url: 接口
    /// - Parameter completion: 回调结果的闭包
    func GET(url:String,completion:@escaping(Dictionary<String, Any>?,Error?)->()){
        guard let requestUrl = URL(string: url) else {
            return
        }
        let httpRequest = URLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15)
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {(data, response, error) in
            guard let _ = data,let _ = response else{
                
                return
        }
            DispatchQueue.main.async {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    let dict = json as! Dictionary<String, Any>
                    UserDefaults.standard.set(dict, forKey: url)
                    completion(dict,error)
                }
                catch _ {
                    print("请求失败")
                    
                }
            }
    }
        dataTask.resume()
        
}}

