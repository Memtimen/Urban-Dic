//
//  TableViewController.swift
//  Urban Dic
//
//  Created by Maimaitiming Abudukadier on 1/24/16.
//  Copyright © 2016 Maimaitiming Abudukadier. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {
    var didLoadDataFromServer = false
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var placeHolder: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateData", name: "update Data", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    
    //MARK: - Search Bar
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        DataManager.sharedInstance.getData(searchBar.text!)
        didLoadDataFromServer = false
        dicData = NSDictionary()
        self.tableView.reloadData()
//        searchBar.resignFirstResponder()
    }


    func updateData(){
        didLoadDataFromServer = true
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if dicData["sounds"]?.count > 0 {
            return 2
        }else{
            return 1
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if didLoadDataFromServer == true && dicData["list"]?.count == 0 {
            placeHolder.center = CGPointMake(view.center.x, 120)
            tableView.addSubview(placeHolder)
            return 0
        }else{
            placeHolder.removeFromSuperview()
            if section == 0 {
                return dicData["list"]?.count ?? 0
            }else{
                return dicData["sounds"]?.count ?? 0
            }
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "Sounds"
        default:
            return nil
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DefinitionTableViewCell
            let def = dicData["list"]?[indexPath.row]["definition"] as? String
            cell.textViewDef.text = def
            if let author = dicData["list"]?[indexPath.row]["author"] as? String {
                cell.labelAuthor?.text = "By: " + author
            }else{
                cell.labelAuthor?.text = "Author unkown"
            }
            if let upCount = dicData["list"]?[indexPath.row]["thumbs_up"] as? Int {
                cell.labelUp.text = "\(upCount)"
            }
            if let dwonCount = dicData["list"]?[indexPath.row]["thumbs_down"] as? Int {
                cell.labelDown.text = "\(dwonCount)"
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("sound", forIndexPath: indexPath) as! SoundTableViewCell
            cell.labelName.text = "Sound \(indexPath.row+1)"
            if let array:[String] = dicData["sounds"] as? Array{
                if let urlpath:String = array[indexPath.row] {
                    if let url = NSURL(string: urlpath) {
                        cell.url = url
                    }
                }
            }
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            if let cell = tableView.cellForRowAtIndexPath(indexPath) as? SoundTableViewCell {
                cell.imageViewplayerStatus.image = nil
                cell.activityIndicator.startAnimating()
                cell.playSound()
            }
        }else{
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            if let cell = tableView.cellForRowAtIndexPath(indexPath) as? SoundTableViewCell {
                cell.stopPlaySound()
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
