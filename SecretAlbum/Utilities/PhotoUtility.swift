//
//  PhotoUtility.swift
//  SecretAlbum
//
//  Created by Jash on 2019/1/21.
//  Copyright © 2019 Jash. All rights reserved.
//

import Foundation
import Photos

class PhotoUtility {
    
    static let queue = DispatchQueue.init(label: "SecretAlbum.PhotoUtility.Queue")
    
    class func asyncLoadPhotos(completion: @escaping ([Photo]) -> Void) {
        queue.async {
            let options = PHFetchOptions()
            let result = PHAsset.fetchAssets(with: options)
            var photos: [Photo] = []
            result.enumerateObjects { (asset, index, _) in
                photos.append(Photo(asset: asset))
            }
            DispatchQueue.main.async {
                completion(photos)
            }
        }
    }

    class func arrangePhotos(photos: [Photo]) -> [PhotoGroup] {
        let sortedPhotos = photos.sorted(by: { (photo1, photo2) -> Bool in
            return photo1.creationDate.isLater(than: photo2.creationDate)
        })
        
        var groups: [PhotoGroup] = []
        let calendar = Calendar.autoupdatingCurrent
        var tempPhotos: [Photo] = []
        
        var nowDate = Date()
        if let sd = sortedPhotos.first?.creationDate {
            nowDate = sd
        }
        for photo in sortedPhotos {
            if photo.creationDate.isSameDay(date: nowDate, calendar: calendar) {
                tempPhotos.append(photo)
            } else {
                let group = PhotoGroup()
                group.date = nowDate
                group.photos = tempPhotos
                groups.append(group)
                
                tempPhotos.removeAll()
                tempPhotos.append(photo)
                nowDate = photo.creationDate
            }
        }
        if tempPhotos.count > 0 {
            let group = PhotoGroup()
            group.date = nowDate
            group.photos = tempPhotos
            groups.append(group)
            tempPhotos.removeAll()
        }
        return groups
    }
}
