//
//  HistoryLoadViewController.swift
//  InterviewDemo
//
//  Created by MacBook Pro on 2021/3/1.
//

import Foundation
import UIKit
class HistoryLoadViewController: UIViewController {
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.dataSource = self
        table.delegate = self
        table.tableFooterView = UIView()
        table.register(HomeCell.self, forCellReuseIdentifier: "HomeCell")
        return table
    }()
    var viewmmodel = HistoryViewModel()
    override func viewDidLoad() {
        configUI()
        viewmmodel.vc = self
        viewmmodel.queryHistoryTimes()
    }
    
    func configUI()   {
        self.navigationItem.title = "History"
        tableView.frame = self.view.bounds;
        self.view.addSubview(tableView)
    }
}

extension HistoryLoadViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmmodel.historyDataArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        cell.key = "调用时间：\(viewmmodel.historyDataArr[indexPath.row])"
        cell.value = "调用次数：\(indexPath.row+1)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

