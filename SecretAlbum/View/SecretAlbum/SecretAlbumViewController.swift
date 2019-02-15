//
//  SecretAlbumViewController.swift
//  SecretAlbum
//
//  Created by Jash on 2019/2/12.
//  Copyright © 2019 Jash. All rights reserved.
//

import UIKit

class SecretAlbumViewController: UIViewController {
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.title = "Secret"
    }
}

extension SecretAlbumViewController: UITableViewDataSource, UITableViewDelegate {
    
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
            cell.textLabel?.text = "System"
        case 1:
            cell.textLabel?.text = "Custom"
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.row {
        case 0:
            let saVC = SystemAlbumViewController()
            navigationController?.pushViewController(saVC, animated: true)
        case 1:
            let caVC = CustomAlbumViewController()
            navigationController?.pushViewController(caVC, animated: true)
        default:
            break
        }
    }
}
