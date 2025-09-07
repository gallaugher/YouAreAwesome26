import UIKit

var imageNumber = 0
var imageName = ""

//imageName = "image" + String(imageNumber)
imageName = "image\(imageNumber)"
print(imageName)

let milesRun: Double = 3
let kmPerMile = 1.609

//let kmRun = Double(milesRun) * kmPerMile
let kmRun = milesRun * kmPerMile
print(kmRun)
