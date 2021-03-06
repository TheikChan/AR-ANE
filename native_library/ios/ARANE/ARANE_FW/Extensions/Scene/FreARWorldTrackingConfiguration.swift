/* Copyright 2017 Tua Rua Ltd.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
 Additional Terms
 No part, or derivative of this Air Native Extensions's code is permitted
 to be sold as the basis of a commercially packaged Air Native Extension which
 undertakes the same purpose as this software. That is an ARKit wrapper for iOS.
 All Rights Reserved. Tua Rua Ltd.
 */

import Foundation
import ARKit
public extension ARWorldTrackingConfiguration {
    convenience init?(_ freObject: FREObject?) {
        guard let rv = freObject, let planeDetection = [Int](rv["planeDetection"]) else { return nil }
        let fre = FreObjectSwift(rv)
        self.init()
        var planeDetectionSet: ARWorldTrackingConfiguration.PlaneDetection = []
        for pd in planeDetection {
            if UInt(pd) == ARWorldTrackingConfiguration.PlaneDetection.horizontal.rawValue {
                planeDetectionSet.formUnion(ARWorldTrackingConfiguration.PlaneDetection.horizontal)
            }
            if #available(iOS 11.3, *) {
                if UInt(pd) == ARWorldTrackingConfiguration.PlaneDetection.vertical.rawValue {
                    planeDetectionSet.formUnion(ARWorldTrackingConfiguration.PlaneDetection.vertical)
                }
            }
        }
        
        self.planeDetection = planeDetectionSet
        self.isLightEstimationEnabled = fre.isLightEstimationEnabled
        self.worldAlignment = WorldAlignment(rawValue: fre.worldAlignment) ?? .gravity
        
        if #available(iOS 11.3, *) {
            self.isAutoFocusEnabled = fre.isAutoFocusEnabled
            if let referenceImages: Set<ARReferenceImage> = Set(fre.detectionImages) {
                self.detectionImages = referenceImages
            }
        }
        
        if #available(iOS 12.0, *) {
            self.maximumNumberOfTrackedImages = fre.maximumNumberOfTrackedImages
            if let freInitialWorldMapFile = rv["initialWorldMap"],
                let initialWorldMap = String(freInitialWorldMapFile["nativePath"]) {
                let worldMapURL = URL(fileURLWithPath: initialWorldMap)
                if let worldMapData = retrieveWorldMapData(from: worldMapURL),
                     let worldMap = unarchiveARWorldMap(worldMapData: worldMapData) {
                    self.initialWorldMap = worldMap
                }
            }
            self.environmentTexturing = EnvironmentTexturing(rawValue: fre.environmentTexturing) ?? .none
            if let referenceObjects: Set<ARReferenceObject> = Set(fre.detectionObjects) {
                self.detectionObjects = referenceObjects
            }
        }
    }
    @available(iOS 12.0, *)
    private func unarchiveARWorldMap(worldMapData data: Data) -> ARWorldMap? {
        guard let unarchievedObject = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data),
            let worldMap = unarchievedObject else { return nil }
        return worldMap
    }
    
    @available(iOS 12.0, *)
    private func retrieveWorldMapData(from url: URL) -> Data? {
        return try? Data(contentsOf: url)
    }
}
