//
//  FirstScreenViewController.swift
//  bostaTask
//
//  Created by Mahmoud on 03/03/2023.
//

import UIKit

class ProfileScreenViewController: UIViewController {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var albumTableView: UITableView!
    {
        didSet{
            albumTableView.delegate = self
            albumTableView.dataSource = self
        }
    }
    let semaphore = DispatchSemaphore(value: 0)
    let group = DispatchGroup()
    var index : Int = -1
    var users  : [User]  = []
    var albums : [Album] = []
    var userId : Int?
    var queue = OperationQueue()
    var viewModel : ViewModel?
    var endPoint : EndPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()
        showUserData()
    }
  
    func showUserData(){
        endPoint = EndPoint.users
        let usersUrl = endPoint!.makeUrl(baseUrl: NetworkServiece.baseUrl)
        //MARK: Fetch Users and show one random
        
        semaphore.signal()
        viewModel?.fetchUsersData(url:usersUrl)
        group.enter()
        viewModel?.bindingUserResult = {
            self.users = self.viewModel?.usersResult ?? []
            let n = Int.random(in: 1..<(self.viewModel?.usersResult.count)!)
            self.index = n
            self.userId = self.users[self.index].id
            self.semaphore.wait()
            self.showAlbums()
            self.group.leave()
        }
        
       
    }

    func showAlbums(){
        //MARK: Fetch albums for specific user
        endPoint = EndPoint.albumId
        let albumsUrl = (endPoint?.makeUrlWithId(baseUrl: NetworkServiece.baseUrl, id: String(users[index].id ?? 0)))!
        viewModel?.fetchAlbumsData(url: albumsUrl)
        group.enter()
        viewModel?.bindingAlbumsResult = {
            self.albums = (self.viewModel?.albumsResult)!
            self.group.leave()
    }
    //MARK: apply changes on UI at once using Dispatch Group
    group.notify(queue: .main)
        {
            self.nameLabel.text = self.users[self.index ].name
            self.addressLabel.text = "\(self.users[self.index].address?.street ?? ""), \(self.users[self.index].address?.suite ?? ""), \(self.users[self.index].address?.city ?? ""), \(self.users[self.index].address?.zipcode ?? "")"
            self.albumTableView.reloadData()
        }
}
    
}

extension ProfileScreenViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Albums"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumViewController = self.storyboard?.instantiateViewController(withIdentifier: "albumDetails") as! AlbumDetailsScreenViewController
        albumViewController.albumTitle = albums[indexPath.row].title
        albumViewController.albumId = albums[indexPath.row].id
        self.navigationController?.pushViewController(albumViewController, animated: true)
    }
}
extension ProfileScreenViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
        cell.textLabel!.text = albums[indexPath.row].title
        
        return cell
    }
    
    
}
