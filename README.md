# DKExtendedSplashViewController

## History

Once upon a time there was an iOS Developer who's got a task to implement something. It was scarier than all bosses from Dark Souls 2 but he was young and brave with his heart more pure than Uncle's Bob Code. 
A Knight from The Order of POs said:
We need to have AB Tests on the very first screen of the app so configuration should be ready right after launch screen. A lot has fallen on this task but you... you have something more than the others... you just don't know that it can not be done.

## What Apple says about Launch Screens:

> "A launch screen appears instantly when your app starts up. The launch screen is quickly replaced with the first screen of your app, giving the impression that your app is fast and responsive. The launch screen isn’t an opportunity for artistic expression. It’s solely intended to enhance the perception of your app as quick to launch and immediately ready for use. Every app must supply a launch screen."

It's your choice how to interpret these words. 
1. Just follow the rules (https://developer.apple.com/ios/human-interface-guidelines/icons-and-images/launch-screen/) and you'll be fine. 
2. Don't hold user on the launch screen for more than 2-3 seconds more (in extreme cases max 10 seconds). During that time you can download remote configuration, make database migration and take one sip of a coffee. And user will have full working app after that. 
3. Be smart. As Facebook currently does make sure that your extended splash view is different than a default launch screen. 
4. Regarding Apple words I do agree completly. But "I can't change the direction of the wind, but I can adjust my sails to always reach my destination."

------------------------------

# Example usage:

> 1. With BlockOperation

```
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        // 1. Create TargettedViewController
        let targettedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!

        // 2. Create your custom splash screen view
        let customView = CustomSplashScreenView()
        
        // 3. Put your splash screen into DKExtendedSplashViewController
        let extendedSplashViewController = DKExtendedSplashViewController(with: customView, for: viewController, in: window)
        
        // 4. Start initialization 
        extendedSplashViewController.startInitialization(with: BlockOperation(block: {
            for i in 0..<500000 {
                print(i*i)
            }
        }))
        
        return true
    }
}
```

> 2. With separated Operatation/Operations

```
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        // 1. Create TargettedViewController
        let targettedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!

        // 2. Create your custom splash screen view
        let customView = CustomSplashScreenView()
        
        // 3. Put your splash screen into DKExtendedSplashViewController
        let extendedSplashViewController = DKExtendedSplashViewController(with: customView, for: viewController, in: window)
        
        // 4. Create some expensive operations
        let operation1 = ExpensiveOperation()
        let operation2 = ExpensiveOperation()
        
        // 5. Start initialization 
        extendedSplashViewController.startInitialization(with: [operation1, operation2])
        
        return true
    }
}
```
> 3. You can also create own SplashViewController using DKExtendedSplashViewControllerProtocol (All methods below have default implementation):
```
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
```

# TODOs:
- add more ways to create splash screen view (via nib file, using .png file)
- local/push notifications and launchOptions handling using Incubators pattern
- unit tests
- timeout operations
