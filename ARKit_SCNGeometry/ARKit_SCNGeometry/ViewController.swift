//
//  ViewController.swift
//  ARKit_SCNGeometry
//
//  Created by 杨孟强 on 2017/9/6.
//  Copyright © 2017年 杨孟强. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var nodeBeganScale:Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

        let scene = SCNScene()
        
 //-----------------------线----------------------
//        let geometrySources = SCNGeometrySource(vertices: [
//            SCNVector3(x: 0.1, y: 0.0, z: -0.1),
//            SCNVector3(x: 0.1, y: 0.1, z: -0.1),
//            SCNVector3(x: 0.0, y: 0.1, z: -0.1),
//            ])
//
//        let indices: [UInt8] = [0, 1, 1, 2]
//        let geometryElement = SCNGeometryElement(indices: indices, primitiveType: .line)
//
//        let geometry = SCNGeometry(sources: [geometrySources], elements: [geometryElement])
        
//---------------------绘制曲线------------------------//
//        var vertices: [SCNVector3]! = []
//        var indices: [UInt32]! = []
//
//        //        px[0] = 50;  px[1] = 140; px[2]=400;px[3]=600;
//        //        py[0] = 400; py[1] = 20;  py[2]=40; py[3]=400;
//        ASGetASBezierPoint({ ( n, x, y) in
//            if n == 0 || n == 1 {
//                indices.append(UInt32(n))
//            } else {
//                indices.append(UInt32(n-1))
//                indices.append(UInt32(n))
//            }
//            vertices.append(SCNVector3(x: Float(x)/1000.0,y: Float(y)/1000.0,z: 0))
//        })
//
//        let geometrySources = SCNGeometrySource(vertices:vertices)
//        let geometryElement = SCNGeometryElement(indices: indices, primitiveType: .line)
//
//        let geometry = SCNGeometry(sources: [geometrySources], elements: [geometryElement])
        
//-------------------三角形------------------------//
//        let geometrySources = SCNGeometrySource(vertices: [
//            SCNVector3(x:  0.1, y: 0.0, z: -0.1),
//            SCNVector3(x:  0.1, y: 0.1, z: -0.1),
//            SCNVector3(x: -0.1, y: 0.0, z: -0.1),
//            ])
//
//        let indices: [UInt8] = [0, 1, 2]
//
//        let geometryElement = SCNGeometryElement(indices: indices, primitiveType: .triangles)
//
//        let geometry = SCNGeometry(sources: [geometrySources], elements: [geometryElement])
        
////-------------------四边形triangles------------------------//
//        let geometrySources = SCNGeometrySource(vertices: [
//            SCNVector3(x:  0.1, y: 0.0, z: -0.1),
//            SCNVector3(x:  0.1, y: 0.1, z: -0.1),
//            SCNVector3(x: -0.1, y: 0.0, z: -0.1),
//            SCNVector3(x: -0.1, y: 0.1, z: -0.1),
//            ])
//
//        let indices: [UInt8] = [0, 1, 2,
//                                2, 1, 3]
//
//        let geometryElement = SCNGeometryElement(indices: indices, primitiveType: .triangles)
//
//        let geometry = SCNGeometry(sources: [geometrySources], elements: [geometryElement])
        
//-------------------两个 四边形triangleStrip------------------------//
//        let geometrySources = SCNGeometrySource(vertices: [
//            SCNVector3(x:  0.1, y: 0.0, z: -0.1),
//            SCNVector3(x:  0.1, y: 0.1, z: -0.1),
//            SCNVector3(x: -0.1, y: 0.0, z: -0.1),
//            SCNVector3(x: -0.1, y: 0.1, z: -0.1),
//
//            SCNVector3(x: -0.1, y: 0.0, z: 0.0),
//            SCNVector3(x: -0.1, y: 0.1, z: 0.0),
//            ])
//
//        let indices: [UInt8] = [0, 1, 2,  3,  4,  5]
//
//        let geometryElement = SCNGeometryElement(indices: indices, primitiveType: .triangleStrip)
//
//        let geometry = SCNGeometry(sources: [geometrySources], elements: [geometryElement])

        
//        //自定义几何体
////---------------四棱锥------------------
        let geometrySources = SCNGeometrySource(vertices: [
            SCNVector3(x: -0.1, y: 0.0, z:  0.1),
            SCNVector3(x:  0.1, y: 0.0, z:  0.1),
            SCNVector3(x: -0.1, y: 0.0, z: -0.1),
            SCNVector3(x:  0.1, y: 0.0, z: -0.1),
            SCNVector3(x:  0.0, y: 0.2, z:  0.0),
            ])

        let indices: [UInt8] = [
            0, 2, 1, 2, 1, 3,//底
            2, 3, 4,//后
            3, 1, 4,//右
            1, 0, 4,//前
            0, 2, 4//左
        ]

        let geometryElement = SCNGeometryElement(indices: indices, primitiveType: .triangleStrip)

        let geometry = SCNGeometry(sources: [geometrySources], elements: [geometryElement])
        

//------------------------------
        //渲染
        let material = SCNMaterial()
//        material.diffuse.contents = UIColor.red
        geometry.firstMaterial = material
//        geometry.firstMaterial?.isDoubleSided = true
        
        //创建节点
        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.position = SCNVector3(0, -0.2, -0.2)
        
        scene.rootNode.addChildNode(geometryNode);
        
        sceneView.scene = scene
        
        //-----------------

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
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
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
