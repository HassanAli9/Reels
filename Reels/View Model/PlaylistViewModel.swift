//
//  PlaylistViewModel.swift
//  Reels
//
//  Created by Hassan on 29/07/2022.
//

import Foundation
import Reachability

class PlaylistViewModel: NSObject {
    let networkService = NetworkService.shared
    let reachability = try! Reachability()
    
    // MARK: Binders

    var bindDataFromVMToVC: ()->() = {}
    var bindErrorFromVMToVC: ()->() = {}
    var bindConnectionState: ()->() = {}
   
    var isConnected: Bool! {
        didSet {
            bindConnectionState()
        }
    }
    
    var playlistModel: PlaylistModel! {
        didSet {
            bindDataFromVMToVC()
        }
    }
    
    var errorMessage: String! {
        didSet {
            bindErrorFromVMToVC()
        }
    }
    
    override init() {
        super.init()
        getData()
    }
    
    // MARK: Connection Status

    func checkConnection() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            isConnected = true
        case .cellular:
            print("Reachable via Cellular")
            isConnected = true
        case .unavailable:
            print("Network not reachable")
            isConnected = false
        case .none:
            print("")
            isConnected = false
        }
    }
    
    // MARK: GET Data From API

    func getData() {
        networkService.fetchData(className: PlaylistModel.self) { response in
            
            switch response {
            case .success(let playlistModel):
                if let playlistModel = playlistModel {
                    self.playlistModel = playlistModel
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
