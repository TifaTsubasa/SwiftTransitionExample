//
//  TTCustomFirstController.swift
//  SwiftTransitionExample
//
//  Created by TifaTsubasa on 16/1/13.
//  Copyright © 2016年 TifaTsubasa. All rights reserved.
//

import UIKit

class TTCustomFirstController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate {
    
    lazy var things: [TTThing] = {
        let arr = [
            TTThing(title
                : "Thing 1", image: UIImage(named: "thing01.jpg"), overview: "Drumstick cow beef fatback turkey boudin. Meatball leberkas boudin hamburger pork belly fatback."),
            TTThing(title: "Thing 2", image: UIImage(named: "thing02.jpg"), overview: "Shank pastrami sirloin, sausage prosciutto spare ribs kielbasa tri-tip doner."),
            TTThing(title: "Thing 3", image: UIImage(named: "thing03.jpg"), overview: "Frankfurter cow filet mignon short loin ham hock salami meatloaf biltong andouille bresaola prosciutto."),
            TTThing(title: "Thing 4", image: UIImage(named: "thing04.jpg"), overview: "Pastrami sausage turkey shank shankle corned beef."),
            TTThing(title: "Thing 5", image: UIImage(named: "thing05.jpg"), overview: "Tri-tip short loin pork belly, pastrami biltong ball tip ham hock. Shoulder ribeye turducken shankle.")
        ]
        return arr
    }()
    
    var selectedIndex: NSIndexPath?
    
    var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 155, height: 183)
        
        collection = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.dataSource = self
        collection.delegate = self
        collection.register(TTThingCell.self, forCellWithReuseIdentifier: "TTThingCell")
        self.view.addSubview(collection)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let _ = self.navigationController?.delegate {
            self.navigationController?.delegate = nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndexPath = collection.indexPathsForSelectedItems?.last
        let secondVc = segue.destination as! TTCustomSecondController
        secondVc.thing = things[(selectedIndexPath?.item)!]
    }
    
    // navigation
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if toVC is TTCustomSecondController {
            return TTCustomPushAnimation()
        }
        return nil
    }
    
    // collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return things.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "TTThingCell", for: indexPath as IndexPath) as! TTThingCell
        cell.thing = things[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondVc = TTCustomSecondController()
        selectedIndex = indexPath as NSIndexPath
        secondVc.thing = things[indexPath.item]
        secondVc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secondVc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

