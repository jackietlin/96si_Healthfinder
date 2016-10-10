//
//  HealthFinderViewController.swift
//  HealthFinder
//
//  Created by Jacqueline Lin on 10/9/16.
//  Copyright © 2016 CS96SI. All rights reserved.
//

import UIKit
import AFNetworking

class HealthFinderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    // call Class variables with self.variablename >>> for example, self.topics
    var topics:[NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 160

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        let url = URL(string: "https://healthfinder.gov/developer/MyHFSearch.json?api_key=demo_api_key&who=child&age=16&gender=male")
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        // Send a request w dataTask, get a response back with (dataOrNil, response, err)
        let task = session.dataTask(with: request) { (dataOrNil, response, err) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    // responseDictionary exists
                    if let results = responseDictionary["Result"] as? NSDictionary {
                        print("response \(results)")
                        //must call self here because topics is a Class variable, but Swift is too dumb to remember that
                        self.topics = results["Topics"] as? [NSDictionary]
                        //reload the view after downloading data!
                        self.tableView.reloadData()
                    }
                }
            }
        }//.resume()
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let topics = self.topics {
            return topics.count
        }
        return 0
    }
    
    /*
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
     */
    
    // -> returns UITableViewCell type
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") // "cell" in withIdentifier is the file that determines how the cell is laid out
        if (cell != nil) {
            cell?.textLabel?.text = "\(indexPath.row)" //indexPath contains sections(sec) and rows
            return cell!
        }
        let newCell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        // newCell.textLabel?.text = "\(indexPath.row)"
        newCell.textLabel?.text = topics![indexPath.row]["Title"] as? String
        return newCell
        */
        
        
        // now that we know how many times to dequeue reusable cells, we can specify indexPath instead of random guessing
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = topics![indexPath.row]["Title"] as? String
        return cell
        */
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HealthFinderTableViewCell
        cell.titleLabel.text = topics![indexPath.row]["Title"] as? String
        let url = URL(string: topics![indexPath.row]["ImageUrl"] as! String)
        cell.imageView?.setImageWith(url!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AccessContent", sender: tableView.cellForRow(at: indexPath)) // we're passing indexPath here, so we know in "prepare
    }
    
    //this happens with the "AccessContent" segue after performSegue before reaches VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AccessContent") {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell) // cellForRow vs indexPath methods
            let destination = segue.destination as! ContentViewController
            destination.content = topics![indexPath!.row]["Sections"] as? [NSDictionary]
        }
    }
 

}
