

![Screenshot](fr2.png)
# LookKit SDK

This package is aim to make using Computer Vision simple as possible.
LookKit use 2 main features.
1. Creating a Image Analyzing Operation Pipe.
2. Creating a Stack Operations over batch of photos.

We have 3 main API's:
1. ```Recognition``` - For face recognition/grouping.
2. ```Detector``` - For using many available image detection operations.
3.  ```ImageProcessor``` - For Image Processing like align faces, crop, rotation etc.

# Requirement
- iOS 13.0+
- Swift 5.3+
- Xcode 12.0+

# Install
### SPM:
```
dependencies: [
  .package(
      url:  "https://github.com/LA-Labs/LookKit_Package.git",
      .branch("master")
  )
]
```
## Import
```swift 
import LookKit
```
# Usage

## Basic Usage Face Location

### Create Action
Firstly, LookKit provides useful initializers to create face location request with ```Actions```. 
```swift 
// Create face location request (Action)
let faceLocation = Actions.faceLocation
````

### Face Location
Call Vision detecotor with the Action request and fetch images options.
```swift 
Detector.analyze(faceLocation, with: options) { (result) in
   switch result {
      case .success(let photos):
         // The result type is ```ProcessedAsset```
         // Containt normilized face recatangle location
         // photos[0].boundingBoxes
      case .failure(let error):
          print(error)
   }
}
```

### Fetch options
 asset fetching options using ```AssetFetchingOptions```
```swift 
// Create default fetch options
let options = AssetFetchingOptions()
```

We can custom ```AssetFetchingOptions``` with 3 properties:
- sortDescriptors: Ascending\Descending.
- assetCollection: Photos source.
- fetchLimit: Limit the amount of photos we are fetching.
```swift
let options = AssetFetchingOptions(sortDescriptors: [NSSortDescriptor]?,
                                   assetCollection: AssetCollection,
                                   fetchLimit: Int)
```

### Asset Collections
```swift
public enum AssetCollection {
    case allAssets
    case albumName(_ name: String)
    case assetCollection(_ collection: PHAssetCollection)
    case identifiers(_ ids: [String])
}
```


## Multiple Requests
### Creating a pipe process
```swift
// Create Face rectangle dection
let faceRectangle = VFilter.faceRectangle()
        
// Create Object Detection.
// Sky, flower, water etc.
let objectDetecting = VFilter.objectDetecting()

// Combine 2 process to one pipe.
// Every image in the batch images will go through the pipe.
let pipeProcessing = faceRectangle |>> objectDetecting

// Start detecting
Detector.detect(pipeProcessing, with: options) { (result) in
switch result {
   // The result type is ProcessedAsset
   // Containt all photos with face recatangle detection
   // photos[0].boundingBoxes
   // photos[0].tags
      case .success(let photos):
          print(photos)
      case .failure(let error):
          print(error)
   }
}
```

# Face Grouping

![](face_group.gif)

### Collect people faces into groups
```swift
// Create photo fetech options
let options = AssetFetchingOptions()
        
// Create cluster options
let clusterOptions = ClusterOptions()

// Start clustering
Recognition.cluster(fetchOptions: options,
               culsterOptions: clusterOptions) { (result) in
     // Result contian groups of faces
     // [[Face]]
     switch result {
        case .success(let faces):
           print(faces)
        case .failure(_):
           break
     }
}
```

# Demo Project 
Just plug and play.
Make sure you have enough photos with faces before running the project on iDevice/Simulator.

https://github.com/LA-Labs/LookKit_Demo

# Contributing
We don't have any contributing guidelines at the moment, but feel free to submit pull requests & file issues within GitHub!
