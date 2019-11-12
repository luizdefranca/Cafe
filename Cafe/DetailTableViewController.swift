//
//  DetailTableViewController.swift
//  Cafe
//
//  Created by Luiz on 9/11/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

import UIKit
import MapKit


class DetailTableViewController: UITableViewController {

    //MARK: - Outlets

    @IBOutlet weak var detailImageView: UIImageView!
    var checkButton : UIButton  {

        let checkImage = UIImage(named: "check")
        let imageSize = checkImage?.size
        let origin = CGPoint(x: self.detailImageView.frame.maxX
            -
            ((imageSize?.width ?? 0 ) + 16)
            , y: detailImageView.frame.minY +  16 )

        let bt = UIButton(frame: CGRect(origin: origin, size: imageSize ?? CGSize(width: 32, height: 32)))
        bt.setImage(checkImage, for: .normal)
        bt.layer.shadowRadius = 6
        bt.layer.shadowOpacity = 1
        bt.layer.shadowOffset = CGSize(width: 0, height: 3)
        bt.layer.shadowColor = UIColor.black.cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(showRatingView))
        bt.addGestureRecognizer(tap)

        return bt
    }

    //MARK: - Properties
    var cafe : Cafe?
    var image: UIImage?
    var isCheckButtonActivated: Bool = false {
        didSet {
            self.checkButton.setImage(UIImage(named: self.isCheckButtonActivated == true ? "cross" : "check"), for: .normal)
        }
    }
    let cellReuseIdentifier = "detailCellIndentifier"
    override func viewDidLoad() {
        super.viewDidLoad()
       self.navigationItem.title = "Cafe"
        if let image = image {
            detailImageView.image = image
        }

        self.title = cafe?.name
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.title = cafe?.name
        configTable()
        self.view.addSubview(checkButton)
        addMap()
        createMapButtonItem()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setToolbarHidden(false, animated: true)
        navigationController?.toolbar.isHidden = true
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    func configTable() {
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.backgroundColor = UIColor(named: "Clear_Light_Font")
        self.tableView.separatorColor = UIColor.red
        tableView.estimatedRowHeight = 36
        tableView.rowHeight = UITableView.automaticDimension
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! DetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.fieldLb.text = "Name"
            cell.valueLb.text = cafe?.name
            cell.isUserInteractionEnabled = false
        case 1:
            cell.fieldLb.text = "Title"
            cell.valueLb.text = cafe?.title
        case 2:
            cell.fieldLb.text = "Address"
            if let address = self.cafe?.address, let postalCode = self.cafe?.postalCode, let city = self.cafe?.city {
                let fullAddress = "\(address), \(postalCode) - \(city)"
                cell.valueLb.text = fullAddress
                //                    self.cafe?.address
            }
//            cell.valueLb.text = cafe?.address
        case 3:
            cell.fieldLb.text = "Phone"
            cell.valueLb.text = cafe?.phone
        case 4:
            cell.fieldLb.text = "Price"
            cell.valueLb.text = cafe?.price
        default:
            cell.fieldLb.text = "Rating"
            cell.valueLb.text =  cafe?.rating.description
        }

        // Configure the cell...
        cell.backgroundColor = UIColor.clear
        return cell
    }

    //MARK: - Subviews Methods

    //MARK: - ShowRatingView


    @objc private func showRatingView(){
        print("check button ativated")

        if let ratingView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RatingViewController") as? RatingViewController {
            ratingView.cafe = cafe
            ratingView.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            present(ratingView, animated: true, completion: nil)
        }

//        let storyBoard = UIStoryboard(name: "Main" , bundle: nil)
//        let ratingView = storyBoard.instantiateViewController(withIdentifier: "RatingViewController") as! RatingViewController
//
//        ratingView.modalPresentationStyle = UIModalPresentationStyle.fullScreen
//        present(ratingView, animated: true, completion: nil)

//        self.present(ratingView, animated: true, completion: nil)

    }
    private func createCheckButton() {

    }

    private func createMapButtonItem() {
        let mapButtonItem = UIBarButtonItem(image: UIImage(named: "maps"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMapView))
        self.navigationItem.rightBarButtonItem = mapButtonItem
    }

    private func addMap() {

        let map = MKMapView()
        map.frame = CGRect(origin: CGPoint(x: 0, y: 0  ), size: CGSize(width: self.view.bounds.width, height: 300))
        self.tableView.tableFooterView?.addSubview(map)
    }

   @objc private func showMapView() {

    print("show maps")


        if let mapView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapViewController") as? DetailMapViewController {
            mapView.modalPresentationStyle = .fullScreen
//            mapView.modalTransitionStyle = .coverVertical
            mapView.cafe = cafe

            self.navigationController?.pushViewController(mapView, animated: true)
//            present(mapView, animated: true, completion: nil)
        }

    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
