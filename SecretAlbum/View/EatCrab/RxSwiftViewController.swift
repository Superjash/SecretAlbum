//
//  RxSwiftViewController.swift
//  SecretAlbum
//
//  Created by Jash on 2019/2/15.
//  Copyright © 2019 Jash. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Photos

class RxSwiftViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var originY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        let button = UIButton(type: .system)
//        button.frame = CGRect(x: 0, y: 0, width: view.bounds.width/2, height: view.bounds.height/2)
//        button.backgroundColor = .red
//        view.addSubview(button)
        
//        button.rx.tap
//            .subscribe(onNext: {
//                print("button Tapped")
//            })
//            .disposed(by: disposeBag)
        
//        button.rx.tap
//            .subscribe(onNext: {
//                print("...")
//            })
//            .disposed(by: DisposeBag)
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = .lightGray
        view.addSubview(scrollView)
        
        PhotoUtility.asyncLoadPhotos { [weak self] (phtots) in
            let photoGroups = PhotoUtility.arrangePhotos(photos: phtots)
            if let photo = photoGroups.first?.photos.first {
                self?.requestImage(asset: photo.asset, width: 0.25)
                self?.requestImage(asset: photo.asset, width: 0.5)
                self?.requestImage(asset: photo.asset, width: 1)
                self?.requestImage(asset: photo.asset, width: 1.5)
                self?.requestImage(asset: photo.asset, width: 2)
                self?.requestImage(asset: photo.asset, width: 2.5)
                self?.requestImage(asset: photo.asset, width: 3)
                self?.requestImage(asset: photo.asset, width: 3.5)
                self?.requestImage(asset: photo.asset, width: 4)
                self?.requestImage(asset: photo.asset, width: 4.5)
                self?.requestImage(asset: photo.asset, width: 5)
                self?.requestImage(asset: photo.asset, width: 10)
                self?.requestImage(asset: photo.asset, width: 20)
                self?.requestImage(asset: photo.asset, width: 30)
                self?.requestImage(asset: photo.asset, width: 40)
                self?.requestImage(asset: photo.asset, width: 50)
                self?.requestImage(asset: photo.asset, width: 200)
                self?.requestImage(asset: photo.asset, width: 1000)
            }
        }
    }
    
    private func requestImage(asset: PHAsset, width: CGFloat) {
        let options = PHImageRequestOptions()
        options.resizeMode = .none
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        let scale: CGFloat = 1 // UIScreen.main.scale
        let targetSize = width >= 1000 ? PHImageManagerMaximumSize: CGSize(width: width*100*scale, height: width*100*scale)
        let time1 = CACurrentMediaTime()
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { [weak self] (image, info) in
            let time2 = CACurrentMediaTime()
            if let img = image, let data = img.jpegData(compressionQuality: 1) {
//                print(".. square \(width*width), bytes \(data.count), ratio \(CGFloat(data.count)/(width*width))")
//                print(".... target \(targetSize.width) x \(targetSize.height), real \(img.size.width) x \(img.size.height)")
                print("...... time cost \(time2 - time1)")
                DispatchQueue.main.async {
                    self?.addImage(image: img)
                }
            }
        }
    }
    
    private func addImage(image: UIImage) {
        let imageView = UIImageView(image: image)
        var width = image.size.width
        var height = image.size.height
        var scale: CGFloat = 1
        while width/scale > view.bounds.width {
            scale += 1
        }
        width = CGFloat(floorf(Float(width/scale)))
        height = CGFloat(floorf(Float(height/scale)))
        imageView.frame = CGRect(x: 0, y: originY, width: width, height: height)
        scrollView.addSubview(imageView)
        originY += height + 20
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: originY)
        
        let label = UILabel()
        label.backgroundColor = .black
        label.text = String(Int(image.size.width)) + " x " + String(Int(image.size.height))
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        label.frame = CGRect(x: imageView.bounds.width - label.bounds.width, y: imageView.bounds.height - label.bounds.height, width: label.bounds.width, height: label.bounds.height)
        imageView.addSubview(label)
    }
}

/*
 none
 ...... time cost 0.014728249996551313
 ...... time cost 0.02079129166668281
 ...... time cost 0.019336958343046717
 ...... time cost 0.02029983332613483
 ...... time cost 0.02371754166961182
 ...... time cost 0.0264081666682614
 ...... time cost 0.029304958326974884
 ...... time cost 0.03193458332680166
 ...... time cost 0.0992709166748682
 ...... time cost 0.1293699166708393
 ...... time cost 0.16268266667611897
 ...... time cost 0.19528687500860542
 ...... time cost 0.2279032083315542
 ...... time cost 0.25961649999953806
 ...... time cost 0.2919895833329065
 ...... time cost 0.3236774999968475
 ...... time cost 0.35632395833090413
 ...... time cost 0.38876258333039004
 
 fast
 ...... time cost 0.01606704166624695
 ...... time cost 0.018334333333768882
 ...... time cost 0.019006166665349156
 ...... time cost 0.019977708332589827
 ...... time cost 0.021335708341212012
 ...... time cost 0.022615791676798835
 ...... time cost 0.02390270834439434
 ...... time cost 0.02531345833267551
 ...... time cost 0.0969408749951981
 ...... time cost 0.10030233333236538
 ...... time cost 0.10669495833280962
 ...... time cost 0.11325166666938458
 ...... time cost 0.1196055833279388
 ...... time cost 0.23461691667034756
 ...... time cost 0.3480262916709762
 ...... time cost 0.5705149999994319
 ...... time cost 0.784762374998536
 ...... time cost 1.0013070416607661
 
 exact
 ...... time cost 0.01542312499077525
 ...... time cost 0.017420999996829778
 ...... time cost 0.017716791669954546
 ...... time cost 0.018854999987524934
 ...... time cost 0.019966083331382833
 ...... time cost 0.02185429165547248
 ...... time cost 0.024411083330051042
 ...... time cost 0.02818841666157823
 ...... time cost 0.10077170834119897
 ...... time cost 0.22445058332232293
 ...... time cost 0.40478783333674073
 ...... time cost 0.40758679166901857
 ...... time cost 0.4131445000093663
 ...... time cost 0.4218854166683741
 ...... time cost 0.5168187916715397
 ...... time cost 0.8926095416682074
 ...... time cost 1.3039009583444567
 ...... time cost 1.530220291679143
 */
