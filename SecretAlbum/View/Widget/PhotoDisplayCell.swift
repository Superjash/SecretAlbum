//
//  PhotoDisplayCell.swift
//  SecretAlbum
//
//  Created by Jash on 2019/1/2.
//  Copyright © 2019 Jash. All rights reserved.
//

import UIKit
import Photos

class PhotoDisplayCell: UICollectionViewCell {
    
    var previewHandler: (() -> Void)? // 预览
    var selectHandler: (() -> Void)? // 选择
    
    private var imageView: UIImageView!
    private var previewButton: UIButton!
    private var selectButton: UIButton!
    
    private var assetIdentifier = ""
    private var phID: PHImageRequestID?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        previewButton = UIButton(type: .custom)
        previewButton.addTarget(self, action: #selector(previewButtonTapped(_:)), for: .touchUpInside)
        contentView.addSubview(previewButton)
        previewButton.snp.makeConstraints { make in
            make.center.size.equalToSuperview()
        }
        
        selectButton = UIButton(type: .custom)
        selectButton.addTarget(self, action: #selector(selectionButtonTapped(_:)), for: .touchUpInside)
        selectButton.setImage(UIImage(named: "photo_cell_unselected"), for: .normal)
        selectButton.setImage(UIImage(named: "photo_cell_selected"), for: .selected)
        selectButton.imageEdgeInsets = UIEdgeInsets(top: -20, left: -20, bottom: 0, right: 0)
        contentView.addSubview(selectButton)
        selectButton.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.height.width.equalTo(50)
        }
    }
    
    @objc private func previewButtonTapped(_ sender: UIButton) {
        self.previewHandler?()
    }
    
    @objc private func selectionButtonTapped(_ sender: UIButton) {
        self.selectHandler?()
    }
    
    override func prepareForReuse() {
        assetIdentifier = ""
        if let id = phID {
            PHImageManager.default().cancelImageRequest(id)
        }
    }
    
    func update(photo: Photo, enabled: Bool) {
        selectButton.isHidden = !enabled
        selectButton.isEnabled = enabled
        selectButton.isSelected = photo.selected
        if photo.selected {
            UIView.animate(withDuration: 0.15) {
                self.imageView.transform = CGAffineTransform(scaleX: 0.82, y: 0.82)
            }
        } else {
            self.imageView.transform = .identity
        }
        
        assetIdentifier = photo.asset.localIdentifier
        let options = PHImageRequestOptions()
        let scale = UIScreen.main.scale
        let boundSize = contentView.bounds.size
        let targetSize = CGSize(width: boundSize.width * scale, height: boundSize.height * scale)
        phID = PHImageManager.default().requestImage(for: photo.asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { [weak self] (image, info) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.phID = nil
            if strongSelf.assetIdentifier == photo.asset.localIdentifier {
                strongSelf.imageView.image = image
            }
        }
    }
}
