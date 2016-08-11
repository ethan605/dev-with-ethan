let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
let thread = dispatch_get_global_queue(priority, 0)

A()
dispatch_async(thread) { B() }
C()
D()
