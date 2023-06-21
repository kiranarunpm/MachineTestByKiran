//
//  RegisterUserVC.swift
//  MachineTestByKiran
//
//  Created by Kiran PM on 20/06/23.
//

import UIKit
import FirebaseFirestore
import FirebaseDatabase
import MBProgressHUD
import FirebaseAuth
class RegisterUserVC: UIViewController {

    var ref: DatabaseReference!

    @IBOutlet weak var usernameBaseView: UIView!
    @IBOutlet weak var firstnameBaseView: UIView!
    @IBOutlet weak var lastnameBaseView: UIView!
    @IBOutlet weak var emailBaseView: UIView!

    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var firstnameTxt: UITextField!
    @IBOutlet weak var lastnametxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    
    var userID : String = ""
    var mobileNumber : String = ""
    
    //MARK: viewModel Declearation
    lazy var viewModel: StoreDataVM = {
        return StoreDataVM()
    }()

    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCodeBaseViewUI(usernameBaseView)
        setupCodeBaseViewUI(firstnameBaseView)
        setupCodeBaseViewUI(lastnameBaseView)
        setupCodeBaseViewUI(emailBaseView)
        
        registerBtn.layer.cornerRadius = 25
        
        initViewModel()

    }
    
    //MARK: Initalise ViewModel init
    func initViewModel(){
        viewModel.successClosure = { [weak self] () in
            guard let _self = self else { return }
            
            let alertController = UIAlertController(title: "Success",
                                          message: "Registration Completed",
                                          preferredStyle: .alert)
 
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                _self.navigationController?.listOfUsersVC()
            })

            _self.present(alertController, animated: true)
    

        }
        
        viewModel.loadingStatus = { [weak self] () in
            
            guard let _self = self else { return }
            
            DispatchQueue.main.async {
                
                let isLoading = _self.viewModel.isLoading ?? false
                
                if isLoading {
                    MBProgressHUD.showAdded(to: _self.view, animated: true)
                    
                }else {
                    MBProgressHUD.hide(for: _self.view, animated: true)
                }
            }
        }
        
        viewModel.failureClosure = { [weak self] () in
            
            guard let _self = self else { return }
            
            DispatchQueue.main.async {
                
                if let alertMessage = _self.viewModel.alertMessage {
                    print("alertMessage", alertMessage)
                    _self.displayValidationMsg(withMessage: alertMessage)
                }
            }
        }
        
        
    }

    func setupCodeBaseViewUI(_ view: UIView){
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 25
    }
    
    //MARK: Register New user
    @IBAction func registerBtn(_ sender: Any) {
        
        guard let username = self.usernameTxt.text, username != "" , username.isReallyEmpty == false else {
            self.displayValidationMsg(withMessage: "Please Enter Username")
            return
        }
        
        guard let firstName = self.firstnameTxt.text, firstName != "" , firstName.isReallyEmpty == false else {
            self.displayValidationMsg(withMessage: "Please Enter First Name")
            return
        }
        
        guard let lastName = self.lastnametxt.text, lastName != "" , lastName.isReallyEmpty == false else {
            self.displayValidationMsg(withMessage: "Please Enter Last Name")
            return
        }
        
        guard let email = self.emailTxt.text, email != "" , email.isReallyEmpty == false else {
            self.displayValidationMsg(withMessage: "Please Enter Email Address")
            return
        }
        
        if !(self.emailTxt.text?.isValidEmail() ?? false){
            self.displayValidationMsg(withMessage: "Please enter valid email address")
            return
        }
        
        
        ref = Database.database().reference()
        let params = ["username": username,
                      "firstname": firstName,
                      "lastname": lastName,
                      "email": email, "userID": Auth.auth().currentUser?.uid ?? "", "mobile": mobileNumber]
        
        viewModel.callRegisterNewUser(params: params) // call register new user


        
    }
    
    
}
