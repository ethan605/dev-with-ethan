func invokeTask(order: Int, inQueue queueNumber: Int) -> NSOperation {
  let operation = NSOperation()
  operation.queuePriority = .Normal
  operation.qualityOfService = .Background
  
  operation.completionBlock = { print("\t[Queue #\(queueNumber)] Task #\(order) completed!") }
  return operation
}

func createQueue(number: Int, taskOrders: Int...) -> NSOperationQueue {
  let queue = NSOperationQueue()
  queue.maxConcurrentOperationCount = 1
  
  print("Start queue #\(number)")
  taskOrders.forEach { queue.addOperation(invokeTask($0, inQueue: number)) }
  return queue
}

createQueue(1, taskOrders: 1, 5, 6, 7, 8)
createQueue(2, taskOrders: 2, 9, 10)
createQueue(3, taskOrders: 3)
createQueue(4, taskOrders: 4)
