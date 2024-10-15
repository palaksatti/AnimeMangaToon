//
//  FavouriteVC.swift
//  Webtoon
//
//  Created by Palak Satti on 16/10/24.
//

import UIKit
import CoreData

class FavouriteVC: UIViewController {
    
    @IBOutlet weak var tblvFavs: UITableView!
    
    var favoriteWebtoons: [FavModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblvFavs.delegate = self
        tblvFavs.dataSource = self
        tblvFavs.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")

        
        fetchFavorites()
    }
    
    func fetchFavorites() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<FavModel> = FavModel.fetchRequest()

        do {
            favoriteWebtoons = try context.fetch(request)
            for favorite in favoriteWebtoons {
                print("Fetched title: \(favorite.title ?? "nil")")
            }
            tblvFavs.reloadData()
        } catch {
            print("Failed to fetch favorite webtoons: \(error)")
        }
    }
}

extension FavouriteVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteWebtoons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }

        let favorite = favoriteWebtoons[indexPath.row]
        cell.lblTitle.text = favorite.title ?? "No Title"
        if let imageData = favorite.imageData, let image = UIImage(data: imageData) {
            cell.imgImage.image = image
        } else {
            cell.imgImage.image = nil
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
