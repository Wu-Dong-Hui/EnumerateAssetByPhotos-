//
//  PhotoCollectionController.swift
//  PhotoFrameworkDemo
//
//  Created by Roy on 15/9/25.
//  Copyright © 2015年 Pixshow. All rights reserved.
//

import UIKit
import Photos

class PhotoCollectionController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate {
    var assetMediaType: PHAssetMediaType = .Image
    var collectionView: UICollectionView!
    var models = [Model]()
    
    convenience init(mediaType: PHAssetMediaType) {
        self.init()
        self.assetMediaType = mediaType
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.whiteColor()
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: view.bounds.width / 2, height: view.bounds.width / 2)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.registerClass(Cell.self, forCellWithReuseIdentifier: NSStringFromClass(Cell))
        collectionView.delegate = self
        collectionView.dataSource = self
        self.enumPhotos()
    }
    func enumPhotos() {
//        let smartResult = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.SmartAlbum, subtype: PHAssetCollectionSubtype.SmartAlbumUserLibrary, options: nil)
//        NSLog("smart result : \(smartResult)")
//        smartResult.enumerateObjectsUsingBlock { (assetCollection, index, finished) -> Void in
//            NSLog("assetCollection : \(assetCollection), index : \(index), finished : \(finished)")
//        }
//
//        let topLevelResult = PHCollectionList.fetchTopLevelUserCollectionsWithOptions(nil)
//        NSLog("top level result: \(topLevelResult)")
//        topLevelResult.enumerateObjectsUsingBlock { (assetCollection, index, finished) -> Void in
//            NSLog("assetCollection : \(assetCollection), index : \(index), finished : \(finished)")
//        }
        
        let imageAssets = PHAsset.fetchAssetsWithMediaType(self.assetMediaType, options: nil)
        imageAssets.enumerateObjectsUsingBlock { [weak self] (assetCollection, index, finished) -> Void in
//            NSLog("assetCollection : \(assetCollection), index : \(index), finished : \(finished)")
            let model = Model()
            model.asset = assetCollection as! PHAsset
            self?.models.append(model)
            if index == imageAssets.count - 1 {
                self?.collectionView.reloadData()
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(NSStringFromClass(Cell), forIndexPath: indexPath) as! Cell
        cell.setupWithModel(model)
        return cell
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//**********
class Model: NSObject {
    var asset: PHAsset!
}
//***********
class Cell: UICollectionViewCell {
    var model: Model!
    var imageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: self.bounds)
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    func setupWithModel(model: Model) {
        self.model = model
        let imageRequestOption = PHImageRequestOptions()
        imageRequestOption.resizeMode = .Exact
        imageRequestOption.deliveryMode = .HighQualityFormat
        imageRequestOption.normalizedCropRect = CGRect(origin: CGPointZero, size: self.bounds.size)
        PHImageManager.defaultManager().requestImageForAsset(model.asset, targetSize: self.bounds.size, contentMode: PHImageContentMode.AspectFill, options: imageRequestOption) { [weak self] (image, dict) -> Void in
            self?.imageView.image = image
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
