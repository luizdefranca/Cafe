//
//  ViewController.swift
//  Cafe
//
//  Created by Luiz on 9/4/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var listTableView: UITableView!

    var restaurantNames = ["Cafe Deadend", "Mallo Coffee & Bar", "De Mello Palheta Coffee Roasters", "Strange Love Coffee", "Quantum Coffee", "Hopper coffee", "Milkys Coffee", "Moonbean Coffee Company", "Balzacs Liberty Village", "Baddies", "The Absinthe Pub and Coffee Shop"]

     let cellIdentifier = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        listTableView.delegate = self
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = self.restaurantNames[indexPath.row]
        cell.imageView?.image = UIImage(named: "\(self.restaurantNames[indexPath.row])")
        return cell
    }


}

extension ViewController: UITableViewDelegate {

}
