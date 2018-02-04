
public class DKExtendedSplashViewController: UIViewController, DKExtendedSplashViewControllerProtocol {
    
    private struct Constants {
        static let errorSplashViewNotExists: String = "DKExtendedSplashViewController: view is not initialized!"
    }
    private var extendedSplashView: UIView?
    public weak var rootWindow: UIWindow?
    public let targettedViewController: UIViewController
    
    public init(with customView: UIView, for targettedViewController: UIViewController, in rootWindow: UIWindow?) {
        self.rootWindow = rootWindow
        self.targettedViewController = targettedViewController
        
        super.init(nibName: nil, bundle: nil)
        
        extendedSplashView = customView
        setExtendedSplashAsRootViewController()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        guard let extendedSplashView = extendedSplashView else {
            assertionFailure(Constants.errorSplashViewNotExists)
            
            self.view = UIView()
            
            return
        }
        
        view = extendedSplashView
    }
}
