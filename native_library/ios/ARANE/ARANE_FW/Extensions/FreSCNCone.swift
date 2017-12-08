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

public extension SCNCone {
    convenience init?(_ freObject: FREObject?) {
        guard let rv = freObject,
            let freTopRadius:FREObject = rv["topRadius"],
            let freBottomRadius:FREObject = rv["bottomRadius"],
            let freHeight:FREObject = rv["height"],
            let freRadialSegmentCount:FREObject = rv["radialSegmentCount"],
            let freHeightSegmentCount:FREObject = rv["heightSegmentCount"]
            else {
                return nil
        }
        
        guard
            let topRadius = CGFloat(freTopRadius),
            let bottomRadius = CGFloat(freBottomRadius),
            let height = CGFloat(freHeight),
            let radialSegmentCount = Int(freRadialSegmentCount),
            let heightSegmentCount = Int(freHeightSegmentCount)
            else {
                return nil
        }
        
        self.init()
        self.topRadius = topRadius
        self.bottomRadius = bottomRadius
        self.height = height
        self.radialSegmentCount = radialSegmentCount
        self.heightSegmentCount = heightSegmentCount
        
    }
    
    func setProp(name:String, value:FREObject) {
        switch name {
        case "topRadius":
            self.topRadius = CGFloat(value) ?? self.topRadius
            break
        case "bottomRadius":
            self.bottomRadius = CGFloat(value) ?? self.bottomRadius
            break
        case "height":
            self.height = CGFloat(value) ?? self.height
            break
        case "radialSegmentCount":
            self.radialSegmentCount = Int(value) ?? self.radialSegmentCount
            break
        case "height":
            self.heightSegmentCount = Int(value) ?? self.heightSegmentCount
            break
        default:
            break
        }
    }
}
