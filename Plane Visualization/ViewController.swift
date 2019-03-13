// Copyright © 2019 Ricky Munz. All rights reserved.

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        sceneView.session.run(configuration)
    }

    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // Cast ARAnchor to ARPlaneAnchor
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }

        // Create SCNGeometry from ARPlaneAnchor details
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let planeGeometry = SCNPlane(width: width, height: height)

        // Create a SCNNode from the SCNPlane geometry
        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.position = SCNVector3(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)

        // Add the newly created plane node as a child of the node created for the ARAnchor
        node.addChildNode(planeNode)
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {

    }
}
