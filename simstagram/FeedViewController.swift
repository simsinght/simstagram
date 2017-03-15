//
//  FeedViewController.swift
//  simstagram
//
//  Created by Simrandeep Singh on 3/15/17.
//  Copyright © 2017 Sim Singh. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 520
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        // construct query
        var query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                // save fetched data
                self.posts = posts
                self.tableView.reloadData()
            } else {
                // handle error by just printing it cuz we lame
                print(error?.localizedDescription)
            }
        }
        
        // The getObjectInBackgroundWithId methods are asynchronous, so any code after this will run
        // immediately.  Any code that depends on the query result should be moved
        // inside the completion block above.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* functions for creating the cell */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! feedCell
        
        cell.post = posts[indexPath.row]
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
