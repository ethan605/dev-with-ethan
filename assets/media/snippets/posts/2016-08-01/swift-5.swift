var mutualData: Int = 0
    
let lockedThread = dispatch_queue_create("dev.ethanify.me.locked_queue", nil)
func writeSync(inc: Int) { dispatch_sync(lockedThread) { mutualData += inc } }

let loop = 0..<10_000

func A() { writeSync(1); print("A - mutualData = \(mutualData)") }
func B() { var i = 1.0; for _ in loop { i *= 2 }; writeSync(2); print("B - mutualData = \(mutualData)") }
func C() { writeSync(3); print("C - mutualData = \(mutualData)") }
func D() { writeSync(4); print("D - mutualData = \(mutualData)") }

let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
let backgroundThread = dispatch_get_global_queue(priority, 0)
A()
dispatch_async(backgroundThread) { B() }
C()
D()
