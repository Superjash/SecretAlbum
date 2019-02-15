//
//  DouYinImageViewController.swift
//  SecretAlbum
//
//  Created by Jash on 2019/2/14.
//  Copyright © 2019 Jash. All rights reserved.
//

import UIKit

class DouYinImageViewController: UIViewController {
    
    private var displayLink: CADisplayLink!
    private var picture: GPUImagePicture!
    private var filter: GPUImage3DFilter!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func setupImage(image: UIImage) {
        let imageView = GPUImageView.init(frame: view.bounds)
        view.addSubview(imageView)
        
        picture = GPUImagePicture.init(image: image)
        filter = GPUImage3DFilter.init()
        filter.useNextFrameForImageCapture()
        picture.addTarget(filter)
        filter.addTarget(imageView)
        
        displayLink = CADisplayLink.init(target: self, selector: #selector(update))
        displayLink.add(to: RunLoop.main, forMode: .default)
    }
    
    @objc private func update() {
        let x = arc4random() % 10
        let y = arc4random() % 10
        
        filter.offset = CGPoint(x: Int(x), y: Int(y))
        picture.processImage()
        
//        print("\(Int(x), Int(y))")
    }
}
