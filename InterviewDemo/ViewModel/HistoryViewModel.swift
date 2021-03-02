//
//  HissoryViewModel.swift
//  InterviewDemo
//
//  Created by MacBook Pro on 2021/3/1.
//

import Foundation
class HistoryViewModel {
    var historyDataArr = [String]()
    weak var vc: HistoryLoadViewController?
    // MARK: -获取所有历史时间
    func queryHistoryTimes(){
        self.historyDataArr.removeAll()
        if UserDefaults.standard.object(forKey: "history") != nil {
            historyDataArr = UserDefaults.standard.object(forKey: "history") as! [String]
            vc?.tableView.reloadData()
        }
    }
}
