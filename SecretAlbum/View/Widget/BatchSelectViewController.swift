//
//  BatchSelectViewController.swift
//  SecretAlbum
//
//  Created by Jash on 2019/1/14.
//  Copyright © 2019 Jash. All rights reserved.
//

import UIKit

class BatchSelectViewController: UIViewController {
    
    var beginEditingHandler: (() -> Void)?
    var endEditingHandler: (() -> Void)?
    
    var defaultTitle: String = ""
    var dataSource: [PhotoGroup] = []
    var collectionView: UICollectionView!
    
    var selectedCount: Int {
        var count = 0
        dataSource.forEach { $0.photos.forEach { if ($0.selected) { count += 1 } } }
        return count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 外部调用，添加长按选择手势
    func addGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPress.delaysTouchesBegan = true
        collectionView.addGestureRecognizer(longPress)
    }
    
    // 外部调用，开始选择
    func beginSelect() {
        beginEditing()
    }
    
    // 外部调用，取消选择
    func endSelect() {
        endEditing()
    }
    
    // 外部调用，有可能需要重写
    func refreshTitle() {
        if isEditing {
            navigationController?.title = selectedCount > 0 ? String(selectedCount) + "张照片": "选择照片"
        } else {
            navigationController?.title = defaultTitle
        }
    }
    
    // 外部调用，collection view 构造 cell 使用
    func updateCell(cell: PhotoDisplayCell, indexpath: IndexPath) {
        cell.previewHandler = { [weak self] in
            self?.handleCellPreview(indexpath)
        }
        cell.selectHandler = { [weak self] in
            self?.handleCellSelect(indexpath)
        }
        cell.update(photo: dataSource[indexpath.section].photos[indexpath.row], enabled: isEditing) // - menuSectionNum
    }
    
    // 外部调用，collection view 构造 header 使用
    func updateHeader(header: PhotoDisplayHeader, indexpath: IndexPath) {
        header.headerSelectHandler = { [weak self] selected in
            guard let strongSelf = self else {
                return
            }
            strongSelf.handleHeaderSelect(selected, at: indexpath)
        }
        header.section = indexpath.section
        let photoGroup = dataSource[indexpath.section]
        header.update(group: photoGroup, enabled: isEditing)
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state != .began {
            return
        }
        let p = gesture.location(in: collectionView)
        if let indexPath = self.collectionView.indexPathForItem(at: p) {
            handleCellLongPress(indexPath)
        } else {
            print("***Jash*** couldn't find index path")
        }
    }
    
    private func beginEditing(_ indexPath: IndexPath? = nil) {
        if isEditing {
            return
        }
        isEditing = true
        
        beginEditingHandler?()
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        updateVisibleCell() // 数据源没有更新，不使用
        if let ip = indexPath {
            handleCellSelect(ip)
        } else {
            refreshTitle()
        }
    }
    
    private func endEditing() {
        if !isEditing {
            return
        }
        isEditing = false
        
        endEditingHandler?()
        
        dataSource.forEach {
            $0.selected = false
            $0.photos.forEach { $0.selected = false }
        }
        updateVisibleCell() // 数据源没有更新，不使用 reloaddata
    }
    
    // header cell 相关
    private func handleHeaderSelect(_ selected: Bool, at indexPath: IndexPath) {
        let group = dataSource[indexPath.section]
        group.selected = selected
        if selected {
            group.selectAll()
        } else {
            group.deselectAll()
        }
        var indexPathes: [IndexPath] = []
        for i in 0..<group.photos.count {
            indexPathes.append(IndexPath(item: i, section: indexPath.section))
        }
        collectionView.reloadItems(at: indexPathes)
        refreshTitle()
    }
    
    private func handleCellPreview(_ indexPath: IndexPath) {
        var allPhotos: [Photo] = []
        dataSource.forEach { group in
            allPhotos.append(contentsOf: group.photos.map { return $0 })
        }
        
//        let photo = dataSource[indexPath.section - menuSectionNum].photos[indexPath.row]
//
//        guard let index = allPhotos.index(where: { $0.photoIdentifier == photo.photoIdentifier }) else {
//            return
//        }
//        let previewController = PreviewViewController(photos: allPhotos, index: index, delegate: self)
//        present(previewController, animated: true, completion: nil)
    }
    
    private func handleCellSelect(_ indexPath: IndexPath) {
        let group = dataSource[indexPath.section]
        let photo = group.photos[indexPath.row]
        photo.selected = !photo.selected
        collectionView.reloadItems(at: [indexPath])
        let groupSelected = group.photos.filter { $0.selected == true }.count == group.photos.count
        if groupSelected != group.selected {
            group.selected = groupSelected
            let obj = (indexPath.section, groupSelected)
            NotificationCenter.default.post(name: NSNotification.Name.Photo.displayHeaderStatusChanged, object: obj)
        }
        refreshTitle()
    }
    
    private func handleCellLongPress(_ indexPath: IndexPath) {
        beginEditing(indexPath)
    }
    
    private func updateVisibleCell() {
        var indexpaths = collectionView.indexPathsForVisibleItems
        for indexpath in indexpaths {
            if let cell = collectionView.cellForItem(at: indexpath) as? PhotoDisplayCell {
                updateCell(cell: cell, indexpath: indexpath)
            }
        }
        
        indexpaths = collectionView.indexPathsForVisibleSupplementaryElements(ofKind: UICollectionView.elementKindSectionHeader)
        for indexpath in indexpaths {
            if let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexpath) as? PhotoDisplayHeader {
                updateHeader(header: header, indexpath: indexpath)
            }
        }
    }
}
