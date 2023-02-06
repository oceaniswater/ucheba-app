//
//  InstitutionsListViewController.swift
//  ucheba app
//
//  Created by Марк Голубев on 05.02.2023.
//

import UIKit

class InstitutionsListViewController: UIViewController {
    
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var institutionList: UITableView!
    
    var networkManager = NetworkManager()
    var list = [Institution]()
    var toDetailSegue = "toDetailSegue"
    
    var currentInstitution: Institution?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.delegate = self
        institutionList.delegate = self
        institutionList.dataSource = self
        
        networkManager.getInstitutions()

        // Do any additional setup after loading the view.
    }

    @IBAction func learnMoreTapped(_ sender: UIButton) {
        performSegue(withIdentifier: toDetailSegue, sender: self)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toDetailSegue {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.logoUrl = currentInstitution?.logoURL
            destinationVC.nameString = currentInstitution?.name
            destinationVC.descriptionText = currentInstitution?.description
        }
    }

    // MARK: - Update UI
    
    func updateUI(imageURLString: String, name: String) {
        let baseUrl = "https://ucheba.ru/"

        let imageUrl = URL(string: baseUrl + imageURLString)
        let name = name

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageUrl!)
            DispatchQueue.main.async {
                self.logo.image = UIImage(data: data!)
                self.name.text = name
            }
        }
    }

}
// MARK: - UITableViewDelegate and DataSource
extension InstitutionsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = list[indexPath.row].name
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = list[indexPath.row].logoURL ?? "/pix/logo_cache/18617.upto100x100.png"
        let name = list[indexPath.row].name ?? "No name"
        currentInstitution = list[indexPath.row]
        updateUI(imageURLString: urlString, name: name)
    }
    
    
}

// MARK: - NetworkManagerDelegate
extension InstitutionsListViewController: NetworkManagerDelegate {
    func didUpdateList(_ coinManager: NetworkManager, _ newList : [Institution]) {
        DispatchQueue.main.async {
            self.list = newList
            self.institutionList.reloadData()
            if let url = newList[1].logoURL,
               let name = newList[1].name {
                self.updateUI(imageURLString: url, name: name)
            }
            
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    
}
