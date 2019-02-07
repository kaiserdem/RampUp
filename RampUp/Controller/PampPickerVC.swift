//
//  PampPickerVC.swift
//  RampUp
//
//  Created by Kaiserdem on 07.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class PampPickerVC: UIViewController, ARSCNViewDelegate, UIPopoverPresentationControllerDelegate {

  var sceneView: SCNView!
  var size: CGSize!
  
  init(size: CGSize) {
    super.init(nibName: nil, bundle: nil)
    self.size = size
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.frame = CGRect(origin: CGPoint.zero, size: size)
      sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
      view.insertSubview(sceneView, at: 0)

      preferredContentSize = size
  }
 
}
