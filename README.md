DKExtendedSplashViewController
==============================
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
# TODOs:
- add more ways to create splash screen view (via nib file, using .png file)
- local/push notifications and launchOptions handling using Incubators pattern
- unit tests
