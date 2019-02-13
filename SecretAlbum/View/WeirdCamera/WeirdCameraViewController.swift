//
//  WeirdCameraViewController.swift
//  SecretAlbum
//
//  Created by Jash on 2019/2/12.
//  Copyright © 2019 Jash. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

class WeirdCameraViewController: UIViewController {
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        view.addSubview(tableView)
        
        AVCaptureDevice.requestAccess(for: .video) { [weak self] (granted: Bool) -> Void in
            PHPhotoLibrary.requestAuthorization { [weak self] (status) in
                DispatchQueue.main.async {
                    if granted {
                        let gcVC = GPUCameraViewController()
                        gcVC.setupCamera(type: .douYin)
                        self?.navigationController?.pushViewController(gcVC, animated: true)
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.title = "Weird"
    }
}

extension WeirdCameraViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Red & Blue"
        case 1:
            cell.textLabel?.text = "Dou Yin"
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let gcVC = GPUCameraViewController()
        switch indexPath.row {
        case 0:
            gcVC.setupCamera(type: .redAndBlue)
        case 1:
            gcVC.setupCamera(type: .douYin)
        default:
            break
        }
        navigationController?.pushViewController(gcVC, animated: true)
    }
}
