//
//  ViewController.swift
//  Webtoon
//
//  Created by Palak Satti on 14/10/24.
//

import UIKit


class HomeViewController: UIViewController, UITabBarDelegate {
    
    //MARK: - IB OUTLETS
    @IBOutlet weak var tblvData: UITableView!
    @IBOutlet weak var homeTabbar: UITabBarItem!
    @IBOutlet weak var favouritesTabbar: UITabBarItem!
    @IBOutlet weak var tabBar: UITabBar!
    
    
    var webtoonData: [WebtoonModel?] = [
        WebtoonModel(image: "i5", title: "Popular Webtoons: Hello Baby"),
        WebtoonModel(image: "i6", title: "The Alpha King’s Claim"),
        WebtoonModel(image: "i5", title: "Popular Webtoons: Bitten Contract"),
        WebtoonModel(image: "i6", title: "Tricked into Becoming the Heroine’s Stepmother"),
        WebtoonModel(image: "i5", title: "The Guy Upstairs"),
        WebtoonModel(image: "i6", title: "The Runaway"),
        WebtoonModel(image: "i5", title: "Popular Webtoons: Your Smile Is A Trap"),
        WebtoonModel(image: "i6", title: "There Must Be Happy Endings"),
        WebtoonModel(image: "i5", title: "Seasons of Blossom"),
        WebtoonModel(image: "i6", title: "Popular Webtoons: Romance 101")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblvData.dataSource = self
        tblvData.delegate = self
        tblvData.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tabBar.delegate = self
        tabBar.selectedItem = homeTabbar
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .lightGray
    
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == favouritesTabbar {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let favVC = storyboard.instantiateViewController(withIdentifier: "FavouriteVC") as? FavouriteVC {
                self.navigationController?.pushViewController(favVC, animated: true)
                
            }
            
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webtoonData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        let webtoon = webtoonData[indexPath.row]
        cell.imgImage.image = UIImage(named: webtoon?.image ?? "")
        cell.lblTitle.text = webtoon?.title ?? ""
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let webtoon = webtoonData[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewVC") as? DetailViewVC {
            
            if let imageName = webtoon?.image {
                detailVC.receivedImg = UIImage(named: imageName)
            } else {
                detailVC.receivedImg = UIImage(systemName: "photo") 
            }

            detailVC.receivedTitle = webtoon?.title ?? ""
    
            self.navigationController?.pushViewController(detailVC, animated: true)
            
        }
    }
    
    
}


