//
//  Photo.swift
//  SecretAlbum
//
//  Created by Jash on 2019/1/2.
//  Copyright © 2019 Jash. All rights reserved.
//

import Foundation
import Photos

class Photo {
    
    var asset: PHAsset!
    var creationDate: Date!
    var selected = false
    
    init(asset: PHAsset) {
        self.asset = asset
        if let date = asset.creationDate {
            self.creationDate = date
        } else {
            self.creationDate = Date()
        }
    }
}

class PhotoGroup {
    
    var date: Date!
    var photos: [Photo] = []
    var selected = false
    
    init() {
        
    }
    
    func selectAll() {
        photos.forEach { (p) in
            p.selected = true
        }
    }
    
    func deselectAll() {
        photos.forEach { (p) in
            p.selected = false
        }
    }
}

class File {
    
    enum FileType {
        case folder
        case photo
    }
    
    var fullName: String
    var name: String
    var ext: String
    var type: FileType
    
    init(fullName: String) {
        self.fullName = fullName
        self.name = ""
        self.ext = ""
        self.type = .folder
    }
}
