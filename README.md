# DigitalGate-iOS

Digitalgate provides integration to Turkcell login  systems. We have developed an SDK that is highly robust, secure, lightweight, configurable and very simple to embed.

The Digitalgate IOS SDK is compatible with IOS 9.0 and above. Swift 3.2 and above

## Getting Started

### Installation

Find Digitalgate.framework file under the framework folder and copy the file into the your project, add the framework to your Embedded Binaries

####Login Coordinator

Everything is handled through the LoginCoordinator class. You insantiate it and pass the root view controller which is the UIViewController from which the Login process will be started (presented) on.

```swift
class ViewController: UIViewController, LoginCoordinatorDelegate {
    lazy var loginCoordinator: LoginCoordinator = {
        let loginVC = LoginCoordinator( self)
        loginVC.delegate = self
        return loginVC
    }()

    ...


    @IBAction func startAction(_ sender: Any) {
        loginCoordinator.start(dgFlow: .login)
    }

    @IBAction func registerAction(_ sender: Any) {
        loginCoordinator.start(dgFlow: .register)
    }

    @IBAction func switchUserAction(_ sender: Any) {
        loginCoordinator.start(dgFlow: .change_user)
    }

    @IBAction func logoutAction(_ sender: Any) {
        loginCoordinator.logout()
    }

    ...
```

Afterwards call start on the coordinator. That's it!

### Customization

if you want to customize UI of the LoginCoordinator, you should provide the DGTheme object

Please refer to project document for details..

```swift

class LoginCoordinator: DigitalGate.DGLoginCoordinator {

}

```

### Start

Handle anything you want to happen when LoginCoordinator starts. Make sure to call super.

Before starting the Login process you should provide following parameters,

-appID: Application id which assigned to each app by DigitalGate admin
-language: Language of SDK default is TR
-useTestServer: using Test or Prod servers
-disableCellLogin: if true, cellular login functionality won’t work.
-autoLoginOnly: if true, only cellular login and remember me will work
-disableAutoLogin: if true, login process is forced to user.
-accessGroup: Keychain access group of applications if any,


```swift
override func start(dgFlow: DGFlow) {
    appID = "2"
    useTestServer = true
    disableAutoLogin = false
    autoLoginOnly = false
    disableCell = false
    language = DGLanguage(from: "TR")
    //accessGroup = ""
    super.start(dgFlow: dgFlow)
    configureAppearance()
}
```

### Completion Callbacks

Override these other 3 callback methods to handle what happens after the user tries to login,

Here you would call your own API.

```swift
override func login(token: String) {
    // Handle login via your API
    delegate?.loginSucceeded(token)
    print("Login with: email =\(token)")
}

override func configurationFailure(configError: String) {
    print(configError)
    delegate?.loginConfigurationFailure(configError: configError)
}

override func failure(_ reason: String, errorMessage: String) {

    if reason == dgKSessionTimeout as String {
        print(errorMessage)
    } else if reason == dgKUserExit as String {
        print(errorMessage)
    } else if reason == dgKNotLoginToLoginSDK as String {
        print(errorMessage)
    }
    delegate?.loginFailure(reason, errorMessage: errorMessage)
}
```

### Logout

You can call the logout() method to logout from SDK.

## Author

Nadir OZGURLER, nadir.ozgurler@turkcell.com.tr
