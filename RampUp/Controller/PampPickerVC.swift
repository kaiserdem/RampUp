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

      let scene = SCNScene(named: "art.scnassets/ramps.scn")!
      sceneView.scene = scene
      
      let camera = SCNCamera()
      camera.usesOrthographicProjection = true
      scene.rootNode.camera = camera
      
      var obj = SCNScene(named: "art.scnassets/pipe.dae")
      var node = obj?.rootNode.childNode(withName: "pipe", recursively: true)!
      node?.scale = SCNVector3Make(0.0018, 0.0018, 0.0018)
      node?.position = SCNVector3Make(0, 0.9, -0.5)
      scene.rootNode.addChildNode(node!)
      
      obj = SCNScene(named: "art.scnassets/pyramid.dae")
      node = obj?.rootNode.childNode(withName: "pyramid", recursively: true)!
      node?.scale = SCNVector3Make(0.0052, 0.0052, 0.0052)
      node?.position = SCNVector3Make(0, 0.1, -0.5)
      scene.rootNode.addChildNode(node!)

      obj = SCNScene(named: "art.scnassets/quarter.dae")
      node = obj?.rootNode.childNode(withName: "quarter", recursively: true)!
      node?.scale = SCNVector3Make(0.0032, 0.0032, 0.0032)
      node?.position = SCNVector3Make(0, -0.8, -0.5)
      scene.rootNode.addChildNode(node!)
  }
 
}
