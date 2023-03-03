//
//  SecondScreenViewController.swift
//  bostaTask
//
//  Created by Mahmoud on 03/03/2023.
//

import UIKit
import Kingfisher
class AlbumDetailsScreenViewController: UIViewController {

    @IBOutlet weak var seachBar: UISearchBar!
    @IBOutlet weak var albumImagesCollection: UICollectionView!{
        didSet{
            let nib = UINib(nibName: "AlbuamCollectionViewCell", bundle: nil)
            albumImagesCollection.register(nib, forCellWithReuseIdentifier: "collectionCell")
            albumImagesCollection.delegate = self
            albumImagesCollection.dataSource = self
        }
    }
    @IBOutlet weak var albumTitleLabel: UILabel!
    var viewModel : ViewModel?
    var albumId : Int?
    var albumTitle : String?
    var photosResult : [Photo] = []
    var filteredResult : [Photo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()
        
       albumTitleLabel.text = albumTitle
       showPhotosData()
    }
    func showPhotosData(){
        let endPoint = EndPoint.photoId
        let usersUrl = endPoint.makeUrlWithId(baseUrl: NetworkServiece.baseUrl, id: "\(albumId!)")
        //MARK: Fetch Photos and show one random
        
        viewModel?.fetchPhotosData(url:usersUrl)
        viewModel?.bindingPhotosResult = {
            self.photosResult = self.viewModel!.photosResult
            self.filteredResult = self.photosResult
            self.albumImagesCollection.reloadData()
        }
    }
}
extension AlbumDetailsScreenViewController : UICollectionViewDelegate{
    
}
extension AlbumDetailsScreenViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! AlbuamCollectionViewCell
        cell.configImage(url: filteredResult[indexPath.row].url!)
        return cell
    }
    
    
}
extension AlbumDetailsScreenViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return 0.0
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
          return CGSize(width: UIScreen.main.bounds.width / 3 ,height: UIScreen.main.bounds.width / 3 )
      }
      
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 0.0
      }
}
extension AlbumDetailsScreenViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""
        {
            filteredResult = photosResult
        }
        else{
            filteredResult = photosResult.filter({ $0 .title!.uppercased().contains(searchText.uppercased())
            })
            
        }
        albumImagesCollection.reloadData()
    }
    
}
