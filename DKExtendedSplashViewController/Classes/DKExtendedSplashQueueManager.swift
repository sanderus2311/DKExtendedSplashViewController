
internal class DKExtendedSplashQueueManager {
    
    private struct Constants {
        static let queueName = "ExtendedSplashOperationQueue"
    }
    
    private let operationQueue: OperationQueue
    private let allOperationsFinishedCallback: (() -> ())
    
    internal init(with allOperationsFinishedCallback: @escaping ()->()) {
        self.allOperationsFinishedCallback = allOperationsFinishedCallback
        
        operationQueue = OperationQueue()
        operationQueue.name = Constants.queueName
    }
    
    internal func addOperations(_ operations: [Operation]) {
        let finishOperation = BlockOperation(block: allOperationsFinishedCallback)
        
        operations.forEach { finishOperation.addDependency($0) }
        
        operationQueue.addOperations(operations, waitUntilFinished: false)
        operationQueue.addOperation(finishOperation)
    }
}

