//
//  ListOfUsersVC.swift
//  MachineTestByKiran
//
//  Created by Kiran PM on 20/06/23.
//

import UIKit
import Firebase
import FirebaseDatabase
import MBProgressHUD
class ListOfUsersVC: UIViewController {
    var ref: DatabaseReference!

    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: viewModel Declearation
    lazy var viewModel: StoreDataVM = {
        return StoreDataVM()
    }()
    
    var currentUserDetails = [UserModel]()
    
    var registeredUserArr = [UserModel]()
    
    var sectionTitles = ["Current User Details", "All Registed Users Details"]
    
    var isContainAnotherUsers : Bool = false
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isHidden = true

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: RegistedUserCell.identifire, bundle: nil), forCellReuseIdentifier: RegistedUserCell.identifire)
        
        initViewModel()
   
    }
    
    //MARK: Initalise ViewModel init
    func initViewModel(){
        viewModel.successClosure = { [weak self] () in
            guard let _self = self else { return }
            
            if let users = _self.viewModel.dataSnapshot?.value as? [String: Any]{

                for (_, userData) in users {
                    if let user = userData as? [String: Any] {
                        
                        let userID = user["userID"] as? String
                        let name = user["username"] as? String
                        let firstname = user["firstname"] as? String
                        let lastname = user["lastname"] as? String
                        let email = user["email"] as? String
                        let mobile = user["mobile"] as? String
                        
                        if userID == Auth.auth().currentUser?.uid{
                            self?.currentUserDetails = [UserModel(email: email ?? "", firstname: firstname ?? "", lastname: lastname ?? "", username: name ?? "", userID: userID ?? "", mobile: mobile ?? "")]
                        }else{
                            self?.registeredUserArr.append(UserModel(email: email ?? "", firstname: firstname ?? "", lastname: lastname ?? "", username: name ?? "", userID: userID ?? "", mobile: mobile ?? ""))
                        }
                        
                        if _self.registeredUserArr.count <= 0{
                            print("No other users found")
                            _self.isContainAnotherUsers = false
                        }else{
                            print("Other users found")
                            _self.isContainAnotherUsers = true


                        }
                        
                    }
                }
                
                DispatchQueue.main.async {
                    _self.tableView.isHidden = false
                    _self.tableView.reloadData()
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
        
        viewModel.callFetchAllUsers()
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        
        self.popupAlert(title: "Logout", message: "Do you want to Logout?", actionTitles: ["Cancel","Yes"], actions:[
                    {action1 in
                        
                    },
                    {action2 in
                        let firebaseAuth = Auth.auth()
                        do {
                          try firebaseAuth.signOut()
                            self.navigationController?.toLoginVC()
                        } catch let signOutError as NSError {
                          print("Error signing out: %@", signOutError)
                        }
                    }, nil])}
}

extension ListOfUsersVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Return the title for the specified section
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return currentUserDetails.count
        }else{
            if self.isContainAnotherUsers{
                return registeredUserArr.count
            }else{
                return 1
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegistedUserCell.identifire, for: indexPath) as! RegistedUserCell
        if indexPath.section == 0{
            let index = currentUserDetails[indexPath.row]
            cell.fullnameTxt.text = "Full Name: \(index.fullname)"
            cell.emailTxt.text = "Email Address: \(index.email)"
            cell.mobileTxt.text = "Mobile Number: \(index.mobile)"
            cell.usernameTxt.text = "Username: \(index.username)"
        }else{
            if self.isContainAnotherUsers{
                let index = registeredUserArr[indexPath.row]
                cell.fullnameTxt.text = "Full Name: \(index.fullname)"
                cell.emailTxt.text = "Email Address: \(index.email)"
                cell.mobileTxt.text = "Mobile Number: \(index.mobile)"
                cell.usernameTxt.text = "Username: \(index.username)"
            }else{
                let cell2 = tableView.dequeueReusableCell(withIdentifier: RegistedUserCell.identifire, for: indexPath) as! RegistedUserCell
                cell2.usernameTxt.text = "No Other Users Found"
                cell2.fullnameTxt.isHidden = true
                cell2.mobileTxt.isHidden = true
                cell2.emailTxt.isHidden = true
                return cell2

            }
        }
        cell.fullnameTxt.isHidden = false
        cell.mobileTxt.isHidden = false
        cell.emailTxt.isHidden = false
        return cell
    }
    
    
}
