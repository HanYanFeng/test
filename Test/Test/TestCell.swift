//
//  TestCell.swift
//  Test
//
//  Created by Apple on 2018/6/14.
//  Copyright © 2018年 test. All rights reserved.
//
import SnapKit
import UIKit
import SDWebImage

class TestCell: UITableViewCell {

    var myImageView: UIImageView!
    var aBtn: UIButton!
    var bBtn: UIButton!
    var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.myImageView = UIImageView()
        self.addSubview(myImageView)
        self.aBtn = UIButton()
        self.aBtn.backgroundColor = UIColor.blue
        self.aBtn.setTitle("A", for: .normal)
        self.aBtn.addTarget(self, action: #selector(TestCell.btnTap(sender:)), for: .touchUpInside)
        self.addSubview(aBtn)
        self.bBtn = UIButton()
        self.bBtn.backgroundColor = UIColor.blue
        self.bBtn.setTitle("B", for: .normal)
        self.bBtn.addTarget(self, action: #selector(TestCell.btnTap(sender:)), for: .touchUpInside)
        self.addSubview(bBtn)
        self.label = UILabel()
        self.label.numberOfLines = 2
        self.addSubview(label)

        self.myImageView.snp.makeConstraints { (maker) in
            maker.left.top.equalTo(10)
            maker.right.equalToSuperview().offset(-10)
            maker.width.equalTo(self.myImageView.snp.height).multipliedBy(2)
        }

        self.aBtn.snp.makeConstraints { (maker) in
            maker.left.equalTo(10)
            maker.right.equalTo(self.snp.centerX).offset(-5)
            maker.top.equalTo(self.myImageView.snp.bottom).offset(10)
            maker.height.equalTo(44)
        }
        self.bBtn.snp.makeConstraints { (maker) in
            maker.right.equalTo(self.snp.right).offset(-10)
            maker.left.equalTo(self.snp.centerX).offset(5)
            maker.top.equalTo(self.myImageView.snp.bottom).offset(10)
            maker.height.equalTo(44)
        }
        
        self.label.snp.makeConstraints { (maker) in
            maker.left.equalTo(10)
            maker.right.equalToSuperview().offset(-10)
            maker.top.equalTo(self.aBtn.snp.bottom).offset(10)
            maker.bottom.equalToSuperview().offset(-10)
        }
    }
    func setData(data: [String: String]) {
        self.myImageView.sd_setImage(with: URL(string: data["image"]!))
        self.label.text = data["text"]
        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnTap(sender: UIButton) {
        if self.aBtn === sender {
            NotificationCenter.default.post(name: NSNotification.Name.init("tipAction"), object: "A")
        }else{
            NotificationCenter.default.post(name: NSNotification.Name.init("tipAction"), object: "B")
        }
    }
}
