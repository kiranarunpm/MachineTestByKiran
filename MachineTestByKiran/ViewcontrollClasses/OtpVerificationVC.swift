//
//  OtpVerificationVC.swift
//  MachineTestByKiran
//
//  Created by Kiran PM on 20/06/23.
//

import UIKit
import FirebaseAuth
import MBProgressHUD
class OtpVerificationVC: UIViewController {
    
    var currentVerificationId = ""
    
    @IBOutlet weak var verifyBtn: UIButton!

    
    @IBOutlet weak var sendnumberLbl: UILabel!
    
    @IBOutlet weak var code1: UITextField!
    @IBOutlet weak var code2: UITextField!
    @IBOutlet weak var code3: UITextField!
    @IBOutlet weak var code4: UITextField!
    @IBOutlet weak var code5: UITextField!
    @IBOutlet weak var code6: UITextField!
    
    var mobileNumber : String = ""
    
    //MARK: viewModel Declearation
    lazy var viewModel: AuthenticationVM = {
        return AuthenticationVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyBtn.layer.cornerRadius = 25
        

        
        if #available(iOS 12.0, *) {
            code1.textContentType = .oneTimeCode
            code2.textContentType = .oneTimeCode
            code3.textContentType = .oneTimeCode
            code4.textContentType = .oneTimeCode
            code5.textContentType = .oneTimeCode
            code6.textContentType = .oneTimeCode
            
        }
        
        code1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        code2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        code3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        code4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        code5.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        code6.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        sendnumberLbl.text = "Enter the 6-digit code just sent to your Mobile \(mobileNumber)"
        
        initViewModel()
    }
    
    //MARK: Initalise ViewModel init
    func initViewModel(){
        viewModel.successClosure = { [weak self] () in
            guard let _self = self else { return }
            let userID = _self.viewModel.userID
            
            // Check user already Registed or Not
            _self.viewModel.checkRegistedUser(userID: userID){status in
                print("isUserExist",status)
                if status{
                    _self.navigationController?.listOfUsersVC()

                }else{
                    let vc = RegisterUserVC.instantiate(fromAppStoryboard: .Main)
                    vc.userID = userID
                    vc.mobileNumber = _self.mobileNumber
                    _self.navigationController?.pushViewController(vc, animated: true)

                }
            }

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
    
    
    //MARK: TextField Delegate Menthods
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text ?? ""
        if  text.utf16.count == 1 {
            switch textField{
            case code1:
                code2.becomeFirstResponder()
            case code2:
                code3.becomeFirstResponder()
            case code3:
                code4.becomeFirstResponder()
            case code4:
                code5.becomeFirstResponder()
            case code5:
                code6.becomeFirstResponder()
            case code6:
                self.view.endEditing(true)
            default:
                break
            }
        }
        
        if  text.count == 0 {
            if let char = textField.text!.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                if (isBackSpace == -92) {
                    switch textField{
                    case code1:
                        code1.becomeFirstResponder()
                    case code2:
                        code1.becomeFirstResponder()
                    case code3:
                        code2.becomeFirstResponder()
                    case code4:
                        code3.becomeFirstResponder()
                    case code5:
                        code4.becomeFirstResponder()
                    case code6:
                        code5.becomeFirstResponder()
                    default:
                        break
                    }
                }
            }
            
        }
        
    }
    
    //MARK: Send Verification
    @IBAction func verifyBtnAction(_ sender: Any) {
        let code1 = self.code1.text ?? ""
        let code2 = self.code2.text ?? ""
        let code3 = self.code3.text ?? ""
        let code4 = self.code4.text ?? ""
        let code5 = self.code5.text ?? ""
        let code6 = self.code6.text ?? ""
        
        
        let number = code1 + code2 + code3 + code4 + code5 + code6
        if number.count < 6{
            self.displayValidationMsg(withMessage: "Please Enter Valid Verification code")
            return
        }
        
        viewModel.callVerifyOTP(withVerificationID: currentVerificationId, verificationCode: number) // Call Verify OTP with verification ID and OTP
                
    }
    
}
