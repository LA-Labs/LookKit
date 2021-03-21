
# LookKit SDK

LookKit is a very light weight package aim to make using Computer Vision simple as possible, Inspired by great Dlib and Deepface frameworks.
LookKit is written in 100% pure Swift and contain no external dependency like openCV, Dlib, etc.

It use 2 main concepts:
1. Image Analyzing Operation Pipeline.
2. Stack Operations over batch of photos.

It has 3 main API's:
1. ```Recognition``` - For face recognition/grouping.
2. ```Detector``` - For using many available image detection operations.
3.  ```ImageProcessor``` - For Image Processing like align faces, crop, rotation etc.


## Features

- [x] Face Location, Face Landmarks, Face Quality and much more.
- [x] 100% pure Swift. No external dependency like openCV, Dlib, etc.
- [x] Chainable Request.
- [x] Image processing, Crop and align faces for creation faces data base.
- [x] Fully integrated to work with user photo library out of the box.
- [x] Suppoted both iDevices and macOS.

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
Call ```Detector``` with the Action request and the source image.
```swift 
Detector.analyze(faceLocation, 
                 sourceImage: UIImage(named: "image1.jpg")) { (result) in
        switch result {
            case .success(let result):
              // The result type is ProcessOutput
              // Containt normilized face recatangle location
              // result[0].boundingBoxes
            case .failure(let error):
              print(error)
        }
}
```

## Chain Requests
### Create a pipeline process
```swift
// Create face location request (Action)
let faceLocation = Actions.faceLocation
        
// Create Object Detection request (Action).
// Sky, flower, water etc.
let objectDetection = Actions.objectDetecting

// Combine 2 requests to one pipeline.
// Every photo will go through the pipeline. both actions will be processed
let pipelineProcess = faceLocation --> objectDetecting

// Start detecting
Detector.detect(pipelineProcess, 
                sourceImage: UIImage(named: "image1.jpg")) { (result) in
// You can path it as a function 
// Detector.detect(faceLocation --> objectDetecting, with: options) { (result) in
           switch result {
              case .success(let result):
                  // The result type is ProcessOutput
                  // Containt normilized face recatangle location and object detected.
                  // result[0].boundingBoxes
                  // result[0].tags
              case .failure(let error):
                print(error)
          }
}
```


### Fetch options
Sometime we want to work with more then one source image. LookKit SDK has 2 options.
We can path array of images
```swift

// User photos
let images = [UIImage(named: "image1.jpg"), UIImage(named: "image2.jpg"), UIImage(named: "image3.jpg")]

// Start detecting
Detector.detect(faceLocation, 
                sourceImage: images) { (result) in
```
But this is not recommand for large amount of photos due to high memory allocation.
LookKit SDK provice usful fetch options to work with user photo gallery and let you focus on your user experience.
It's start with creation of asset fetching options using ```AssetFetchingOptions```
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
