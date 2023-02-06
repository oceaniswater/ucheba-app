//
//  DetailViewController.swift
//  ucheba app
//
//  Created by Марк Голубев on 05.02.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var nameString: String?
    var logoUrl:String?
    var descriptionText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI(imageURLString: logoUrl, name: nameString, description: descriptionText)
    }
    
    func updateUI(imageURLString: String?, name: String?, description: String?) {
        let baseUrl = "https://ucheba.ru/"
        guard let logoUrl = imageURLString,
              let name = name,
              let description = description else { return }

        let imageUrl = URL(string: baseUrl + logoUrl)
       

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageUrl!)
            DispatchQueue.main.async {
                self.logoView.image = UIImage(data: data!)
                self.nameLabel.text = name
                self.descriptionLabel.text = description
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
