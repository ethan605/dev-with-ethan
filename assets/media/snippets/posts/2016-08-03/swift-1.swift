let delay = 3.0           // 3 seconds
let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))

print("Start waiting")
dispatch_after(dispatchTime, dispatch_get_main_queue()) { 
  print("Perform after \(delay) seconds")
  print("End waiting")
}
