//
//  LoginVC.swift
//  MachineTestByKiran
//
//  Created by Kiran PM on 20/06/23.
//

import UIKit
import FirebaseAuth
import MBProgressHUD
class LoginVC: UIViewController {

    @IBOutlet weak var mobileNumberBaseView: UIView!
        
    @IBOutlet weak var mobileNumberTxt: UITextField!
    
    var currentVerificationId = ""

    @IBOutlet weak var submitBtn: UIButton!
    
    //MARK: viewModel Declearation
    lazy var viewModel: AuthenticationVM = {
        return AuthenticationVM()
    }()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitBtn.layer.cornerRadius = 25
        
        initViewModel()
    }
    
    //MARK: Initalize ViewModel init
    func initViewModel(){
        viewModel.successClosure = { [weak self] () in
            guard let _self = self else { return }
            print("currentVerificationId",  _self.viewModel.currentVerificationId)
            
            let mobileNumber = _self.mobileNumberTxt.text ?? ""

            let vc = OtpVerificationVC.instantiate(fromAppStoryboard: .Main)
            vc.currentVerificationId = _self.viewModel.currentVerificationId
            vc.mobileNumber = "\(Constants.phone_code)\(mobileNumber)"
            _self.navigationController?.pushViewController(vc, animated: true)

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
    
    
    //MARK: Call Api for send OTP to Valid Mobile Number
    @IBAction func submitBtnAction(_ sender: Any) {
        
        let mobileNumber = self.mobileNumberTxt.text ?? ""
        
        if !self.mobileNumberTxt.mobileNumberValidation() {
            self.displayValidationMsg(withMessage: "Please Enter Valid Mobile number")
            return
        }
        
        viewModel.callSendOTP(mobileNumber: mobileNumber) // call api for sending OTP to the mobile number

    }
    
    

}


