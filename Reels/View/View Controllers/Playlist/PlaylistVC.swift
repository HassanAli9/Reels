//
//  PlaylistVC.swift
//  Reels
//
//  Created by Hassan on 29/07/2022.
//

import UIKit
import youtube_ios_player_helper
import SkeletonView

class PlaylistVC: UIViewController {
    
    
    //MARK: OUTLET
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var playlistVM : PlaylistViewModel!
    var model: PlaylistModel?
    var connectionImage: UIImageView!
  
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVM()
        setupCollectionView()
        collectionView.showAnimatedGradientSkeleton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let  image = UIImage(named: "Internet_connecion")
        connectionImage = UIImageView(image: image!)
        connectionImage.frame = view.bounds
        view.addSubview(connectionImage)
        connectionImage.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playlistVM.checkConnection()
    }
    
   
    

}


//MARK: CollectionView
extension PlaylistVC : UICollectionViewDelegate, SkeletonCollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return VideoCell.identefire
    }
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 5
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.items?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.identefire, for: indexPath) as! VideoCell
       
        if let snippet = model?.items?[indexPath.row].snippet {
            cell.setup(model: snippet)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let videoID = model?.items?[indexPath.row].snippet?.resourceID?.videoID {
            playVideo(videoID: videoID)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3 , height: collectionView.frame.height - 8)
    }
  
}

//MARK: Setup
extension PlaylistVC {
    
    func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(VideoCell.nib, forCellWithReuseIdentifier: VideoCell.identefire)
    }
    
    func setupVM() {
        playlistVM = PlaylistViewModel()
        
        playlistVM.bindDataFromVMToVC = onSuccess
        playlistVM.bindErrorFromVMToVC = onFailure
        playlistVM.bindConnectionState = checkConnection
    }
    
    func onSuccess() {
        
        model = playlistVM.playlistModel
        collectionView.reloadData()
        collectionView.stopSkeletonAnimation()
        view.hideSkeleton()
    }
    
    func onFailure() {
        let alert = UIAlertController(title: "Error", message: playlistVM.errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    func checkConnection() {
        if playlistVM.isConnected {
            connectionImage.isHidden = true
            playlistVM.getData()
            collectionView.reloadData()
        }else {
            connectionImage.isHidden = false

        }
        
    }
    
    
    func playVideo(videoID: String) {
        playerView.load(withVideoId: videoID)
        playerView.playVideo()

    }
    
}
