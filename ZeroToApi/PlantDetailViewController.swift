//
//  PlantDetailViewController.swift
//  ZeroToApi
//
//  Created by Madison, Jon on 9/9/15.
//  Copyright (c) 2015 Madison, Jon. All rights reserved.
//

import UIKit
import Foundation

class PlantDetailViewController: UIViewController {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelScientificName: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    
    var plantId = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let postEndpoint: String = "https://ftapi-ex.herokuapp.com/v1/plants"
                var postEndpoint: String = "http://localhost:3000/v1/plants"
        let requestString = "\(postEndpoint)/\(plantId)"
        let urlRequest = NSURLRequest(URL: NSURL(string: requestString)!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue()) { (response:NSURLResponse?, data:NSData?, err:NSError? ) -> Void in
            if let anError = err
            {
                print("error calling GET on /plants")
                print(anError)
            } else {
                var jsonError: NSError?
                
                let result = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! NSDictionary
                
                if let aJSONError = jsonError
                {
                    print("error parsing /plants")
                    print(aJSONError)
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.updateUI(result)
                    })
                }
            }
        }
        
    }

    func updateUI(plant:NSDictionary) {
        if let name = plant["name"] as? String {
            labelName.text = name
        }
        
        if let scientificName = plant["scientific_name"] as? String {
            labelScientificName.text = scientificName
        }
        
        
        if let duration = plant["duration"] as? String {
            labelDuration.text = duration
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
