//
//  PhotoDisplayHeader.swift
//  SecretAlbum
//
//  Created by Jash on 2019/1/14.
//  Copyright © 2019 Jash. All rights reserved.
//

import UIKit

class PhotoDisplayHeader: UICollectionReusableView {
    
    var section: Int = 0
    var headerSelectHandler: ((Bool) -> Void)?
    
    private var selectButton: UIButton!
    private var titleLabel: UILabel!
    private var bgButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        selectButton = UIButton(type: .custom)
        selectButton.setImage(UIImage(named: "photo_header_unselected"), for: .normal)
        selectButton.setImage(UIImage(named: "photo_header_selected"), for: .selected)
        selectButton.isUserInteractionEnabled = false
        addSubview(selectButton)
        selectButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.saGray(1)
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().offset(-60)
            make.height.equalTo(22)
        }
        
        bgButton = UIButton(type: .custom)
        bgButton.addTarget(self, action: #selector(bgButtonTapped(_:)), for: .touchUpInside)
        addSubview(bgButton)
        bgButton.snp.makeConstraints { make in
            make.center.size.equalToSuperview()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(headerStatusChanged(_:)), name: NSNotification.Name.Photo.displayHeaderStatusChanged, object: nil)
    }
    
    @objc private func bgButtonTapped(_ sender: UIButton) {
        headerSelectHandler?(!sender.isSelected)
        selectButton.isSelected = !sender.isSelected
        bgButton.isSelected = !sender.isSelected
    }
    
    @objc private func headerStatusChanged(_ notification: Notification) {
        if let info = notification.object as? (Int, Bool), section == info.0 {
            selectButton.isSelected = info.1
            bgButton.isSelected = info.1
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func update(group: PhotoGroup, enabled: Bool) {
        selectButton.isHidden = !enabled
        selectButton.isEnabled = enabled
        bgButton.isEnabled = enabled
        
        selectButton.isSelected = group.selected
        bgButton.isSelected = group.selected
        
        var left: CGFloat = 16
        if enabled {
            left = 40
        }
        titleLabel.snp.updateConstraints { make in
            make.left.equalTo(left)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().offset(-60)
            make.height.equalTo(22)
        }
        
        titleLabel.text = Utilities.formatDate(group: group)
    }
}
