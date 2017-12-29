import Foundation
import DigitalGate

protocol LoginCoordinatorDelegate: class {
    func loginSucceeded(_ token: String)
    func loginFailure(_ reason: String, errorMessage: String)
    func loginConfigurationFailure(configError: String)
}

class LoginCoordinator: DigitalGate.DGLoginCoordinator {

    // MARK: - LoginCoordinator

    weak var delegate: LoginCoordinatorDelegate?
    override func start(dgFlow: DGFlow) {
        appID = "2"
        useTestServer = true
        disableAutoLogin = false
        autoLoginOnly = false
        disableCell = false
        language = DGLanguage(from: "EN")
        //accessGroup = "F49E5GW326.com.smobi.login.suite"
        super.start(dgFlow: dgFlow)
        configureAppearance()
    }
//
//    override func finish() {
//        super.finish()
//    }

    // MARK: - Setup

    func configureAppearance() {
        
        // Customize the look with background & logo images
        //theme.mainLogoImage = #imageLiteral(resourceName: "Background")
        // mainLogoImage =
        // secondaryLogoImage =

        // Change colors
//        style.tintColor = UIColor(red: 52.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1)
//        style.errorTintColor = UIColor(red: 253.0/255.0, green: 227.0/255.0, blue: 167.0/255.0, alpha: 1)

        // Change placeholder & button texts, useful for different marketing style or language.
//        style.loginButtonText = "Sign In"
//        style.signupButtonText = "Create Account"
//        style.facebookButtonText = "Login with Facebook"
//        style.forgotPasswordButtonText = "Forgot password?"
//        style.recoverPasswordButtonText = "Recover"
//        style.namePlaceholder = "Name"
//        style.emailPlaceholder = "E-Mail"
//        style.passwordPlaceholder = "Password!"
//        style.repeatPasswordPlaceholder = "Confirm password!"
    }

    // MARK: - Completion Callbacks

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
}
