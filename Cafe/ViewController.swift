//
//  ViewController.swift
//  Cafe
//
//  Created by Luiz on 9/4/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - OutLets
    @IBOutlet weak var listTableView: UITableView!

    //MARK: - Properties
    //MARK: Variables
    var restaurantNames = ["Cafe Deadend", "Mallo Coffee & Bar", "De Mello Palheta Coffee Roasters", "Strange Love Coffee", "Quantum Coffee", "Hopper coffee", "Milkys Coffee", "Moonbean Coffee Company", "Balzacs Liberty Village", "Baddies", "The Absinthe Pub and Coffee Shop"]

    var cafes: [Cafe] = []
    //MARK: Constants
     let cellIdentifier = "cell"

    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        listTableView.delegate = self
        fetchData()
        configNavigationController()

    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.toolbar.isHidden = true
    }

    private func configNavigationController () {
        navigationItem.title = "Easy Food"
        navigationController?.navigationBar.tintColor = UIColor(named: "Clear_Light_Font")
        //        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.titleView?.tintColor = UIColor(named: "Clear_Light_Font")
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "Dark_Font")

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        navigationController?.toolbar.isHidden = true

    }

    private func configTableView() {
        listTableView.estimatedRowHeight = 80
        listTableView.rowHeight = UITableView.automaticDimension
    }

    private func animations() {
        let anin = UIViewPropertyAnimator()
        
        anin.addAnimations {

        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segue.showDetail.rawValue:
            if let indexPath = listTableView.indexPathForSelectedRow {
                if let destination = segue.destination as? DetailTableViewController {
                    destination.cafe = cafes[indexPath.row]
                    let cell = listTableView.cellForRow(at: indexPath) as! CafeTableViewCell
                    destination.image = cell.thumbnailImage.image
                }
            }
        default:
            print("No segue defined")
        }
    }

    //MARK: - Functions

    func fetchData(){
        let cafeManager = CafeManager()
        self.cafes = cafeManager.cafes
        dump(cafes)
        print(cafes.count)
    }
    //MARK: - Actions
}
//MARK: - Extensions

//MARK: TableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CafeTableViewCell
        let cafe = cafes[indexPath.row]
        cell.cafe = cafe
        //        cell.nameLabel.text = self.restaurantNames[indexPath.row]
//        cell.thumbnailImage.image = UIImage(named: "\(self.restaurantNames[indexPath.row])")
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: "Destak_Background")

        cell.selectedBackgroundView = backgroundView
        return cell
    }


}

//MARK: TableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "lets try", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        optionMenu.view.tintColor = UIColor(named: "Dark_Font")
//        present(optionMenu, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            restaurantNames.remove(at: indexPath.row)
            tableView.reloadData()
        default:
            //TODO: implement
            print("Todo")
        }
    }

    /*
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Sharing Button
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) -> Void in
            let defaultText = "Checking in at " + self.restaurantNames[indexPath.row]
            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            self.present(activityController, animated: true, completion: {

            })

        }

        shareAction.backgroundColor = UIColor(displayP3Red: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0)


        //Delete button
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) -> Void in
            self.restaurantNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteAction.backgroundColor = UIColor(displayP3Red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        return [deleteAction, shareAction]
    }
*/
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteButton = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let row = indexPath.row
            self.restaurantNames.remove(at: row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
        let image = UIImage(named: "gabarge")

        deleteButton.image = image

        deleteButton.title = "Delete"
        deleteButton.backgroundColor = UIColor(named: "Destak_Background")

        let shareButton = UIContextualAction(style: .normal, title: "Share") { (action, view, completion) in
            let defaultText = "Just checking in at \(self.restaurantNames[indexPath.row])"
            let defaultImage = UIImage(named: "\(self.restaurantNames[indexPath.row])")
            let activityController = UIActivityViewController(activityItems: [defaultText, defaultImage as Any], applicationActivities: nil)
            activityController.title = defaultText
            self.present(activityController, animated: true, completion: nil)
            completion(true)
        }

        shareButton.image = UIImage(named: "share")
        shareButton.title = "Share"
        shareButton.backgroundColor = UIColor(named: "Minor_Font")
        let configActions = UISwipeActionsConfiguration(actions: [shareButton, deleteButton])
        configActions.performsFirstActionWithFullSwipe = false

        return configActions
    }
}
