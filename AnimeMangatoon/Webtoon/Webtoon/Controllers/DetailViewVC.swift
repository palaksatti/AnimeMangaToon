//
//  DetailViewVC.swift
//  Webtoon
//
//  Created by Palak Satti on 14/10/24.
//

import UIKit
import CoreData

class DetailViewVC: UIViewController {

    @IBOutlet weak var btnAddToFav: UIButton!
    @IBOutlet weak var imgDisplay: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    
    var isFavorite: Bool = false
    var receivedImg: UIImage?
    var receivedTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgDisplay.image = receivedImg
        lblDescription.text = receivedTitle
        btnAddToFav.addTarget(self, action: #selector(addFavPressed), for: .touchUpInside)
        checkIfFavorited()
    }
    
    @objc func addFavPressed() {
        isFavorite.toggle()
        updateBtn()
        
        if isFavorite {
            saveFav()
        } else {
            removeFav()
        }
    }
    
    func updateBtn() {
        let img = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        btnAddToFav.setImage(img, for: .normal)
    }
    
    func saveFav() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newFav = FavModel(context: context)
        newFav.title = receivedTitle
        if let image = receivedImg {
            newFav.imageData = image.pngData()
        }
        
        do {
            try context.save()
            print("Webtoon saved as favorite")
        } catch {
            print("Failed to save favorite: \(error)")
        }
    }
    
  
    func removeFav() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<FavModel>(entityName: "FavModel")  // Ensure the entity name matches
        request.predicate = NSPredicate(format: "title == %@", receivedTitle ?? "")
        
        do {
            let results = try context.fetch(request)
            if let favToDelete = results.first {
                context.delete(favToDelete)
                try context.save()
                print("Webtoon removed from favorites")
            }
        } catch {
            print("Error deleting favorite webtoon: \(error)")
        }
    }

    func checkIfFavorited() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<FavModel>(entityName: "FavModel")  
        request.predicate = NSPredicate(format: "title == %@", receivedTitle ?? "")
        
        do {
            let results = try context.fetch(request)
            if !results.isEmpty {
                isFavorite = true
                updateBtn()
            }
        } catch {
            print("Error fetching favorite webtoon: \(error)")
        }
    }
}
