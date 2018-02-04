
public protocol DKExtendedSplashViewControllerProtocol  {
    /**
     Reference to application window.
     */
    var rootWindow: UIWindow? { get }
    
    /**
     Reference to viewController object which will be presented after splash screen.
     */
    var targettedViewController: UIViewController { get }
    
    /**
     Method to invoke initialization using DKExtendedSplashQueueManager.
     
     - parameter operation: Operation which should be called during initialization.
     */
    func startInitialization(with operation: Operation)
    
    /**
     Method to invoke initialization using DKExtendedSplashQueueManager.
     
     - parameter operations: Operations which should be called during initialization.
     */
    func startInitialization(with operations: [Operation])
    
    /**
     Method to invoke initialization using DKExtendedSplashQueueManager.
     
     - parameter blockOperation: BlockOperation which should be called during initialization.
     */
    func startInitialization(with blockOperation: BlockOperation)
    
    /**
     Method to change rootViewController in rootWindow to desired targettedViewController.
     */
    func setTargettedViewControllerAsRootViewController()
    
    /**
     Method to change rootViewController in rootWindow to DKExtendedSplashViewController.
     */
    func setExtendedSplashAsRootViewController()
}

public extension DKExtendedSplashViewControllerProtocol where Self:  UIViewController {
    
    public func startInitialization(with operation: Operation) {
        let queueManager = DKExtendedSplashQueueManager(with: { [weak self] in
            self?.setTargettedViewControllerAsRootViewController()
        })
        
        queueManager.addOperations([operation])
    }
    
    public func startInitialization(with operations: [Operation]) {
        let queueManager = DKExtendedSplashQueueManager(with: { [weak self] in
            self?.setTargettedViewControllerAsRootViewController()
        })
        
        queueManager.addOperations(operations)
    }
    
    public func startInitialization(with blockOperation: BlockOperation) {
        let queueManager = DKExtendedSplashQueueManager(with: { [weak self] in
            self?.setTargettedViewControllerAsRootViewController()
        })
        
        queueManager.addOperations([blockOperation])
    }
    
    public func setTargettedViewControllerAsRootViewController() {
        DispatchQueue.main.async { [weak self] in
            let overlayView = UIScreen.main.snapshotView(afterScreenUpdates: false)
            self?.targettedViewController.view.addSubview(overlayView)
            self?.rootWindow?.rootViewController = self?.targettedViewController
            
            UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                overlayView.alpha = 0
            }, completion: { finished in
                overlayView.removeFromSuperview()
            })
        }
    }
    
    public func setExtendedSplashAsRootViewController() {
        rootWindow?.rootViewController = self
        rootWindow?.makeKeyAndVisible()
    }
}

