//
//  ViewController.swift
//  Test
//
//  Created by Apple on 2018/6/14.
//  Copyright © 2018年 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView?
    var dataSource: [[String:String]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页"
        
        let url = URL(string: "http://static.youshikoudai.com/mockapi/data")
        
        let session = URLSession.shared
        let request = URLRequest(url: url!)
        
        let dataTask = session.dataTask(with: request) { (data, respond, error) in
            if let data = data {
                
                if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: String]]{
                    self.dataSource = result
                    DispatchQueue.main.async {
                        self.tableView?.reloadData()
                    }
                }
            }
        }
        dataTask.resume()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.tipAction(sender:)), name: NSNotification.Name("tipAction"), object: nil)
    }
    
    @objc func tipAction(sender: NSNotification) {
        if let obj = sender.object as? String {
            if obj == "A" {
                self.navigationController?.pushViewController(AViewController(), animated: true)
            }else{
               self.navigationController?.pushViewController(BViewController(), animated: true)
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(TestCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
        self.view.backgroundColor = UIColor.gray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TestCell
        cell.setData(data: self.dataSource[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

