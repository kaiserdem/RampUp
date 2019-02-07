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
  weak var rampPlacerVC: RampPlacerVC!
  
  init(size: CGSize) {
    super.init(nibName: nil, bundle: nil)
    self.size = size
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.frame = CGRect(origin: CGPoint.zero, size: size) // скрин на экран
      sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
      view.insertSubview(sceneView, at: 0)
      preferredContentSize = size

      let scene = SCNScene(named: "art.scnassets/ramps.scn")! // 
      sceneView.scene = scene
      
      let camera = SCNCamera()
      camera.usesOrthographicProjection = true
      scene.rootNode.camera = camera
      // нажали на обьект
      let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_ :)))
      sceneView.addGestureRecognizer(tap)
      
      let pipe = Ramp.getPipe()
      Ramp.startRotation(node: pipe)
      scene.rootNode.addChildNode(pipe)
      
      let pyramid = Ramp.getPyramid()
      Ramp.startRotation(node: pyramid)
      scene.rootNode.addChildNode(pyramid)
      
      let quarter = Ramp.getQuarter()
      Ramp.startRotation(node: quarter)
      scene.rootNode.addChildNode(quarter)
  }
  @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
    
    let p = gestureRecognizer.location(in: sceneView)
    let hitResults = sceneView.hitTest(p, options: [ : ])
    if hitResults.count > 0 {
      let node = hitResults[0].node

      rampPlacerVC.onRampSelected(node.name!)
      
    }
  }
}
