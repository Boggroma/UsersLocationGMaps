//
//  ViewController.swift
//  UsersLocationGMaps
//
//  Created by мак on 15.09.2020.
//  Copyright © 2020 viktorsafonov. All rights reserved.
//

import UIKit
import GoogleMaps
import GoogleMapsUtils

class ViewController: UIViewController, GMUClusterManagerDelegate, GMSMapViewDelegate {
    
    let networkService = NetworkService()
    var client: [ClientData] = []
    var clusterManager: GMUClusterManager!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    let latitude = 55.97914218
    let longitude = 37.40417579
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMap()
        styleMap()
        initCluster()
        
        
        let urlString = "https://run.mocky.io/v3/96149d36-4ce8-4d4b-a3ac-f937068a1d35"
        
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let clients):
                self.client = clients
                self.setupMarker()
            case .failure(let error):
                print("Error is:", error)
            }
        }
        
        
        
    }
    
    func setupMap() {
        let camera = GMSCameraPosition(latitude: 0, longitude: 0, zoom: 3.0)
        mapView.camera = camera
    }
    
    func styleMap() {
        do {
        if let styleUrl = Bundle.main.url(forResource: "gmsDarkStyle", withExtension: "json") {
            mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleUrl)
        } else {
            print("file not found")
            }
        } catch {
            print("unable to load file")
        }
    }

     func setupMarker() {
            for x in client {
                
                let position = CLLocationCoordinate2D(latitude: x.latitude, longitude: x.longitude)
                let marker = GMSMarker(position: position)
                marker.title = x.clientCode
                marker.map = mapView
                clusterManager.add(marker)
            }
        clusterManager.cluster()
    }
    
    func initCluster () {
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUGridBasedClusterAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        clusterManager.setMapDelegate(self)
    }

}

