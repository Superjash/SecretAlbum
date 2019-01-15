//
//  SystemAlbumViewController.swift
//  SecretAlbum
//
//  Created by Jash on 2018/12/24.
//  Copyright © 2018 Jash. All rights reserved.
//

import UIKit
import Photos
import SnapKit

class SystemAlbumViewController: BatchSelectViewController {
    
    var dataSource: [PhotoGroup] = []
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: view.bounds.width, height: 50)
        let width = (view.bounds.width-6)/4
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoDisplayHeader.self, forCellWithReuseIdentifier: NSStringFromClass(PhotoDisplayHeader.self))
        collectionView.register(PhotoDisplayCell.self, forCellWithReuseIdentifier: NSStringFromClass(PhotoDisplayCell.self))
        view.addSubview(collectionView)
        
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(handleCellLongPress(_:)))
        collectionView.addGestureRecognizer(longPress)
        
        checkAuthorization()
    }
    
    @objc private func handleCellLongPress(_ gesture: UILongPressGestureRecognizer) {
        
    }
    
    private func checkAuthorization() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            loadAlbum()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        self.loadAlbum()
                    default:
                        self.showPlaceHolder()
                    }
                }
            }
        case .denied, .restricted:
            Utilities.openOSSetting(title: "相册")
        }
    }
    
    private func loadAlbum() {
        let options = PHFetchOptions()
        let result = PHAsset.fetchAssets(with: options)
        var photos: [Photo] = []
        result.enumerateObjects { (asset, index, _) in
            photos.append(Photo(asset: asset))
        }
        self.dataSource = Utilities.arrangePhotos(photos: photos)
        collectionView.reloadData()
    }
    
    private func showPlaceHolder() {
        let label = UILabel()
        label.text = "没有相册权限无法使用"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.snp.makeConstraints { (make) in
            make.center.size.equalToSuperview()
        }
    }
}

extension SystemAlbumViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(PhotoDisplayHeader.self), for: indexPath) as! PhotoDisplayHeader
            header.update(group: <#T##PhotoGroup#>, enabled: <#T##Bool#>)
            updateHeader(header: header, indexpath: indexPath)
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(PhotoDisplayCell.self), for: indexPath) as! PhotoDisplayCell
        cell.update(photo: dataSource[indexPath.section].photos[indexPath.row])
        return cell
    }
}
