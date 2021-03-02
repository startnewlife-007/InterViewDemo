//
//  ViewController.swift
//  InterviewDemo
//
//  Created by MacBook Pro on 2021/3/1.
//

import UIKit

class ViewController: UIViewController {
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.dataSource = self
        table.delegate = self
        table.tableFooterView = UIView()
        table.register(HomeCell.self, forCellReuseIdentifier: "HomeCell")
        return table
    }()
    var viewmmodel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        viewmmodel.vc = self
        viewmmodel.fetchData(url: "https://api.github.com/")
    }
    // MARK: - 初始化UI
    func configUI()   {
        self.navigationItem.title = "Home"
        tableView.frame = self.view.bounds;
        self.view.addSubview(tableView)
        //设置右边的跳转按钮
        let LogButton = UIButton(type: .custom)
        LogButton.setTitle("History", for: .normal)
        LogButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        LogButton.setTitleColor(.black, for: .normal)
        LogButton.contentHorizontalAlignment = .left
        LogButton.sizeToFit()
        LogButton.addTarget(self, action: #selector(logClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: LogButton)
    }
    // MARK: - 点击跳转历史调用界面
    @objc func logClick() {
        
        let historyVc = HistoryLoadViewController()
        navigationController?.pushViewController(historyVc, animated: true)
        
    }

}

// MARK: - UITableView 数据源和代理方法
extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmmodel.homeDataArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.data = viewmmodel.homeDataArr[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}


