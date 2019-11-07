import UIKit
import SceneKit
import ARKit

class FaceViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1
        //           labelView.layer.cornerRadius = 10
        
        sceneView.delegate = self
        sceneView.showsStatistics = false
        
        // 2
        guard ARFaceTrackingConfiguration.isSupported else {
            fatalError("Face tracking is not supported on this device")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARFaceTrackingConfiguration()
        
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

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry {
            faceGeometry.update(from: faceAnchor.geometry)
        }
    }
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let faceMesh = ARSCNFaceGeometry(device: sceneView.device!, fillMesh: true)
        //        let node = SCNNode(geometry: faceMesh)
       
        
//        let plane = SCNPlane(width: 2, height: 2)
//        let bundleURL = Bundle.main.url(forResource: "engine", withExtension: "gif")
        
        
        //        layer.add(animation, forKey: "contents")
        let tempView = MySketch()
        tempView.frame = CGRect(x: 0, y: 0, width: 1800, height: 1800)
        tempView.width = 1800
        tempView.height = 1800
        tempView.setup()
        tempView.layer.bounds = CGRect(x: 0, y: 0, width: 1800  , height: 1800)
        
        
        
        let newMaterial = SCNMaterial()
        newMaterial.isDoubleSided = true
        newMaterial.diffuse.contents = tempView.layer
        let scaleVal = SCNMatrix4MakeScale(0.5, 0.5, 0.5)
        newMaterial.diffuse.contentsTransform = scaleVal
        //        newMaterial.stre
        
        //        plane.materials = [newMaterial]
        let node = SCNNode(geometry: faceMesh)
       
        node.geometry?.materials = [newMaterial]
        node.geometry?.firstMaterial?.fillMode = .fill
        //        node.geometry?.firstMaterial = imageMaterial
        //        node.geometry?.firstMaterial = newMaterial
        
     
        
        return node
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
