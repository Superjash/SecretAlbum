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
    
    var endSelectItem: UIBarButtonItem!
    var beginSelectItem: UIBarButtonItem!
    var moreActionItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        defaultTitle = "相册"
//        view.backgroundColor = .white
//
//        endSelectItem = UIBarButtonItem(image: UIImage(named: "icon_close_black"), style: .done, target: self, action: #selector(endSelectButtonTapped(_:)))
//        endSelectItem.tintColor = .black
//        endSelectItem.isEnabled = false
//
//        beginSelectItem = UIBarButtonItem(image: UIImage(named: "icon_select_black"), style: .done, target: self, action: #selector(beginSelectButtonTapped(_:)))
//        beginSelectItem.tintColor = .black
//        beginSelectItem.isEnabled = true
//
//        moreActionItem = UIBarButtonItem(image: UIImage(named: "icon_3dots_black"), style: .done, target: self, action: #selector(beginSelectButtonTapped(_:)))
//        moreActionItem.tintColor = .black
//        moreActionItem.isEnabled = true
//
//        tabBarController?.navigationItem.leftBarButtonItem = endSelectItem
//        tabBarController?.navigationItem.rightBarButtonItem = beginSelectItem
        
        beginEditingHandler = { [weak self] in
            self?.endSelectItem.isEnabled = true
            self?.beginSelectItem.isEnabled = false
        }
        endEditingHandler = { [weak self] in
            self?.endSelectItem.isEnabled = false
            self?.beginSelectItem.isEnabled = true
        }
        
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
        collectionView.register(PhotoDisplayHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(PhotoDisplayHeader.self))
        collectionView.register(PhotoDisplayCell.self, forCellWithReuseIdentifier: NSStringFromClass(PhotoDisplayCell.self))
        view.addSubview(collectionView)
        addGesture()
        
        refreshTitle()
        
        checkAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshTitle()
    }
    
    @objc private func beginSelectButtonTapped(_ sender: UIBarButtonItem) {
        beginSelect()
    }
    
    @objc private func endSelectButtonTapped(_ sender: UIBarButtonItem) {
        endSelect()
    }
    
    @objc private func moreActionButtonTapped(_ sender: UIBarButtonItem) {
        let actionSheet = SAActionSheet()
        actionSheet.addAction(SAAction(title: "", style: .default, handler: { (_) in
            
        }))
        actionSheet.show()
    }
    
    override func refreshTitle() {
        if isEditing {
            tabBarController?.title = selectedCount > 0 ? String(selectedCount) + "张照片": "选择照片"
        } else {
            tabBarController?.title = defaultTitle
        }
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
        PhotoUtility.asyncLoadPhotos { [weak self] (phtots) in
            self?.dataSource = PhotoUtility.arrangePhotos(photos: phtots)
            self?.collectionView.reloadData()
        }
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
            updateHeader(header: header, indexpath: indexPath)
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(PhotoDisplayCell.self), for: indexPath) as! PhotoDisplayCell
        updateCell(cell: cell, indexpath: indexPath)
        return cell
    }
}
