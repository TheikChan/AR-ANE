/* Copyright 2018 Tua Rua Ltd.

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
package com.tuarua.arane {
import flash.geom.Vector3D;

[RemoteClass(alias="com.tuarua.arane.ReferenceObject")]
public class ReferenceObject {
    /**
     * The center of the object in the object’s local coordinate space.
     */
    public var center:Vector3D;
    /**
     * The extent of the object in the object’s local coordinate space.
     */
    public var extent:Vector3D;
    /**
     * The scale of the object’s local coordinate space.
     * <p>Multiplying the extent by this scale will result in the physical extent of the object, measured in meters.</p>
     */
    public var scale:Vector3D;
    /**
     * An optional name used to identify the object.
     */
    public var name:String;

    public function ReferenceObject() {
    }
}
}
