//
//  MainTableViewController.swift
//  JSONListDetail
//
//  Created by Vitor Dinis on 01/08/2017.
//  Copyright © 2017 Vitor Dinis. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var users:[[String:Any]] = []
    var selectedUser:UserModel? = nil
    
    var currentDataTask:URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = true
        
        activityIndicator.startAnimating()
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: Any]]
//                print(json)
                // Save it up there and reload data
                self.users = json
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            } catch let error as NSError {
                print(error)
            }
        }).resume()
        
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = nil
        let nameLabel = cell.viewWithTag(2) as! UILabel
        nameLabel.text = ""
        let emailLabel = cell.viewWithTag(3) as! UILabel
        emailLabel.text = ""
        
        let user = users[indexPath.row];
        let userName = user["username"] as! String
        let url = URL(string: "https://via.placeholder.com/200x200?text=\(userName)")
        imageView.downloadedFrom(url: url!, contentMode: .scaleAspectFill)
        
        nameLabel.text = user["name"] as? String
        emailLabel.text = user["email"] as? String
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentDataTask?.cancel()
        
        activityIndicator.startAnimating()
        selectedUser = UserModel(data: users[indexPath.row])

        let userId = users[indexPath.row]["id"] as! Int
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userId)")
        currentDataTask = URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:Any]]
                self.selectedUser?.comments = json
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "DetailSegue", sender: self)
                }
            } catch let error as NSError {
                print(error)
            }
        })
        currentDataTask!.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailView = segue.destination as? DetailViewController else { return }
        detailView.currentUser = selectedUser
        activityIndicator.stopAnimating()
    }
    
}
