//
//  HomeCell.swift
//  InterviewDemo
//
//  Created by MacBook Pro on 2021/3/1.
//

import UIKit
class HomeCell: UITableViewCell {
    var data:HomeData?{
        didSet {
            manageData()
        }
    }
    var key:String{
        get {
            ""
        }
        set(new) {
            keyLabel.text = new
            
        }
       
    }
    
    var value:String {
        get{
            ""
        }
        set(new) {
            valueLabel.text = new
        }
    }
    
    let keyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label;
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.numberOfLines = 0
        return label;
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        keyLabel.frame = CGRect(x: 10, y: 5, width: bounds.width-20, height: 17)
        valueLabel.frame = CGRect(x: 10, y: 20, width: bounds.width-20, height: 45)
    }
    func configureUI(){
        addSubview(keyLabel)
        addSubview(valueLabel)
    }
    
    
    
    func manageData()  {
        keyLabel.text = data?.key
        valueLabel.text = data?.value
    }
}
