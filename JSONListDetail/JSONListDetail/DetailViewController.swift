//
//  DetailViewController.swift
//  JSONListDetail
//
//  Created by Vitor Dinis on 01/08/2017.
//  Copyright © 2017 Vitor Dinis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    var currentUser:UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = currentUser?.name ?? "User"
        emailLabel.text = "Email: \(currentUser!.email)"
        phoneLabel.text = "Phone: \(currentUser!.phone)"
        websiteLabel.text = "Website: \(currentUser!.website)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(currentUser?.comments.count ?? 0, 10)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let comment = currentUser!.comments[indexPath.row]
        let title = comment["title"] as? String
        let text = comment["body"] as? String
        // Configure the cell
        let titleLabel = cell.viewWithTag(1) as! UILabel
        let bodyLabel = cell.viewWithTag(2) as! UILabel
        
        titleLabel.text = title
        bodyLabel.text = text
        
        return cell
    }
}
