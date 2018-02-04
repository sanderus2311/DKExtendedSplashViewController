
import XCTest
@testable import DKExtendedSplashViewController

class DKExtendedSplashQueueManagerTests: XCTestCase {

    func testAddFinishOperation() {
        let operationQueue = OperationQueue()
        operationQueue.isSuspended = true
        let operation1 = Operation()
        let operation2 = Operation()
        
        let splashQueueManager = DKExtendedSplashQueueManager(with: {}, in: operationQueue)
        
        splashQueueManager.addOperations([operation1, operation2])
        let finishOperation = operationQueue.operations.filter { $0 != operation1 && $0 != operation2 }.first!
        
        XCTAssertEqual(operationQueue.operations.count, 3)
        XCTAssertEqual(finishOperation.dependencies.count, 2)
    }
}
