//
//  FileUtility.swift
//  SecretAlbum
//
//  Created by Jash on 2019/1/21.
//  Copyright © 2019 Jash. All rights reserved.
//

import Foundation

class FileUtility {
    
    static let queue = "SecretAlbum.FileUtility.Queue"
    
    class func getFilesInDirectory(directory: String) -> [File] {
        return []
    }
    
    private class func findFiles(path: String, filterTypes: [String]) -> [String] {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: path)
            if filterTypes.count == 0 {
                return files
            } else {
                let filteredfiles = NSArray(array: files).pathsMatchingExtensions(filterTypes)
                return filteredfiles
            }
        } catch {
            return []
        }
    }
}
