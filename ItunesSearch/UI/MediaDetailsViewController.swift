//
//  MediaDetailsViewController.swift
//  ItunesSearch
//
//  Created by Florian Praile on 30/08/2018.
//  Copyright © 2018 Underside. All rights reserved.
//

import UIKit

class MediaDetailsViewController: UIViewController {

    var media:  StoreItem?{
        didSet{
            guard let media = media else {
                return
            }
            
            self.loadViewIfNeeded()
            self.navigationItem.title = media.name
            self.mediaLabel.text = "\(media)"
        }
    }
    
    @IBOutlet weak var mediaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
