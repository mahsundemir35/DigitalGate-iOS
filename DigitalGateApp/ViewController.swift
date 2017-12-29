//
//  ViewController.swift
//  DigitalGateApp
//
//  Created by Nadir Ozgurler on 28.12.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LoginCoordinatorDelegate {
    lazy var loginCoordinator: LoginCoordinator = {
        let loginVC = LoginCoordinator( self)
        loginVC.delegate = self
        return loginVC
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    func loginSucceeded(_ token: String) {
        //handle login
    }
    
    func loginFailure(_ reason: String, errorMessage: String) {
        // error
    }
    
    func loginConfigurationFailure(configError: String) {
        // config error
    }
    
}

