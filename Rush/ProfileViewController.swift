//
//  ProfileViewController.swift
//  Rush
//
//  Created by Jiwoo Lee on 5/24/17.
//  Copyright © 2017 DolphinDevs. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    var profilePictureURL: URL? {
        didSet {
            profileImage.image = nil
            fetchImage()
        }
    }
    
    private func fetchImage() {
        if let url = profilePictureURL {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                if let imageData = urlContents, url == self?.profilePictureURL {
                    DispatchQueue.main.async {
                        self?.profileImage.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        profilePictureURL = URL(string: defaults.string(forKey: "proPicURL")!)
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
