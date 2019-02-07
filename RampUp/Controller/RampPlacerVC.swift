//
//  ViewController.swift
//  RampUp
//
//  Created by Kaiserdem on 07.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class RampPlacerVC: UIViewController, ARSCNViewDelegate, UIPopoverPresentationControllerDelegate {
  
  @IBOutlet var sceneView: ARSCNView!
  var selectedRamp: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Set the view's delegate
    sceneView.delegate = self
    
    // Show statistics such as fps and timing information
    sceneView.showsStatistics = true
    
    // Create a new scene
    let scene = SCNScene(named: "art.scnassets/main.scn")!
    sceneView.automaticallyUpdatesLighting = true
    
    // Set the scene to the view
    sceneView.scene = scene
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Create a session configuration
    let configuration = ARWorldTrackingConfiguration()
    
    // Run the view's session
    sceneView.session.run(configuration)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // Pause the view's session
    sceneView.session.pause()
  }
  
  // MARK: - ARSCNViewDelegate
  
  /*
   // Override to create and configure nodes for anchors added to the view's session.
   func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
   let node = SCNNode()
   
   return node
   }
   */
  
  func session(_ session: ARSession, didFailWithError error: Error) {
    // Present an error message to the user
    
  }
  
  func sessionWasInterrupted(_ session: ARSession) {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
  }
  
  func sessionInterruptionEnded(_ session: ARSession) {
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let results = sceneView.hitTest(touch.location(in: sceneView), types: [.featurePoint])
    guard let hitFeature = results.last else { return }
    let hitTransfotm = SCNMatrix4(hitFeature.worldTransform)
    let hitPosition = SCNVector3Make(hitTransfotm.m41, hitTransfotm.m42, hitTransfotm.m43)

    placeRamp(position: hitPosition)
    }
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .none
  }
  
  @IBAction func onRampBtnPressed(_ sender: UIButton) {
    let rampPickerVC = PampPickerVC(size: CGSize(width: 250, height: 500))
    rampPickerVC.rampPlacerVC = self
    rampPickerVC.modalPresentationStyle = .popover
    rampPickerVC.popoverPresentationController?.delegate = self
    present(rampPickerVC, animated: true, completion: nil)
    rampPickerVC.popoverPresentationController?.sourceView = sender
    
  }
  func onRampSelected(_ rampName: String) {
    selectedRamp = rampName
  }
  func placeRamp(position: SCNVector3) {
    if let rampName = selectedRamp {
      let ramp = Ramp.getRampForName(rampName: rampName)
      ramp.position = position
      ramp.scale = SCNVector3Make(0.01, 0.01, 0.01)
      sceneView.scene.rootNode.addChildNode(ramp)

    }
  }
}
