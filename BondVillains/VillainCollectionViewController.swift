//
//  VillainCollectionViewController.swift
//  BondVillains
//
//  Created by Gabrielle Miller-Messner on 2/3/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit

// MARK: - VillainCollectionViewController: UICollectionViewController

class VillainCollectionViewController: UICollectionViewController {
    
    // MARK: Properties   collectionviewflowlayout class
    
    // TODO: Add outlet to flowLayout here.
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // Get ahold of some villains, for the table
    // This is an array of Villain instances
    let allVillains = Villain.allVillains
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Implement flowLayout here.
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space))/3.0

        flowLayout.minimumLineSpacing = space    // change row distance
        flowLayout.minimumInteritemSpacing = space/2    // change distance between cell within row
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
    }
//    One way to do it is to use the collectionView:layout:sizeForItemAtIndexPath: method. Here, you can use the dimensions of your collection view as a base:
//    
//    let frameSize = collectionView?.frame.size
//    
//    and with that, you can work out what the shorter side is.
//    
//    let shorterSide = min(frameSize!.height, frameSize!.width)
//    
//    Then you can set the dimensions of the cell to be, say, 1/3 or 1/4 of the shorter side minus a few points for padding. That should give you a reasonable number of cells in your view.
//    
//    viewWillTransitionToSize:withTransitionCoordinator: to automate a change in layout when the user changes the orientation of the device. By invalidating the existing layout you will force the collection view to call collectionView:layout:sizeForItemAtIndexPath: again to recalculate.
//    According to the answer on that post, you need to call invalidateLayout on the collection view layout. Since a collection view needs a layout object, this will force it to recalculate a new one, which will force it to call sizeForItemAtIndexPath.
//    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) { adjustFlowLayout(size) }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let frameSize = collectionView.frame.size
        let shortSide = min(frameSize.height, frameSize.width) // see which side is short
        
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
        
        let dimension = shortSide/4
        let space: CGFloat = 3.0
        
        flowLayout.minimumLineSpacing = space    // change row distance
        flowLayout.minimumInteritemSpacing = space/2    // change distance between cell within row
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        flowLayout.invalidateLayout()
        
        return
    }
    
    // MARK: Collection View Data Source
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allVillains.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("VillainCollectionViewCell", forIndexPath: indexPath) as! VillainCollectionViewCell
        let villain = self.allVillains[indexPath.row]
        
        // Set the name and image
        cell.nameLabel.text = villain.name
        cell.villainImageView?.image = UIImage(named: villain.imageName)
        //cell.schemeLabel.text = "Scheme: \(villain.evilScheme)"
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("VillainDetailViewController") as! VillainDetailViewController
        detailController.villain = self.allVillains[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }    
}
