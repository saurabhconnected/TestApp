//
//  LoginViewController.swift
//  TestApp
//
//  Created by Saurabh Shukla on 22/08/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    enum StringConstant {
        static let usernameErrorMessage = "Username must be at least 3 character long"
        static let passwordErrorMessage = "Password must not be empty"
        static let countryErrorMessage = "Country not selected"
    }
    
    @IBOutlet weak private var usernameTextField: CustomTextField!
    @IBOutlet weak private var passwordTextField: CustomTextField!
    @IBOutlet weak private var countryTextField: CustomTextField!
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet private var countryPickerContainer: UIView!
    @IBOutlet weak private var countryPickerView: UIPickerView!
    
    var viewModel: LoginViewModelProtocal = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        loginButton.layer.cornerRadius = 4
        loginButton.layer.masksToBounds = true
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
        
        usernameTextField.placeholderColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        passwordTextField.placeholderColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        countryTextField.placeholderColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
    }
    
    private func validateInput() -> Bool {
        var valid = true
        if (usernameTextField.text ?? "").count < 3 {
            usernameTextField.showError(message: StringConstant.usernameErrorMessage)
            valid = false
        }
        if (passwordTextField.text ?? "").isEmpty {
            passwordTextField.showError(message: StringConstant.passwordErrorMessage)
            valid = false
        }
        if (countryTextField.text ?? "").isEmpty {
            countryTextField.showError(message: StringConstant.countryErrorMessage)
            valid = false
        }
        return valid
    }
    
    private func openPicker() {
        view.addSubview(countryPickerContainer)
        let height: CGFloat = 266
        self.countryPickerContainer.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.size.width, height: height)
        self.countryPickerView.frame = CGRect(x: 0, y: 44, width: self.view.bounds.size.width, height:  self.countryPickerContainer.bounds.height-44-safeArea.bottom)
        
        UIView.animate(withDuration: 0.3) {[weak self] in
            guard let self = self else { return }
            self.countryPickerContainer.frame = CGRect(x: 0, y: self.view.bounds.height-height, width: self.view.bounds.size.width, height: height)
        }
    }
    
    private func closePicker() {
        UIView.animate(withDuration: 0.3) {[weak self] in
            guard let self = self else { return }
            self.countryPickerContainer.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.size.width, height: 266)
        } completion: {[weak self] _ in
            guard let self = self else { return }
            self.countryPickerContainer.removeFromSuperview()
        }
    }
    
    @IBAction private func login(_ sender: Any) {
        closePicker()
        view.endEditing(true)
        
        if validateInput() {
            guard viewModel.userExists(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "") else {
                
                let title = "User does not exists!"
                let detail = "Either User '\(usernameTextField.text ?? "")' does not exist in database or the password is incorrect"
                
                let alert = UIAlertController(title: title, message: detail,  preferredStyle: UIAlertController.Style.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
                alert.addAction(ok)
                present(alert, animated: true)
                return
            }
            
            let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    @IBAction private func donePickerTapped(_ sender: Any) {
        closePicker()
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField === countryTextField {
            openPicker()
            return false
        }
        closePicker()
        return true
    }
}

extension LoginViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return viewModel.countryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.countryList[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        countryTextField.text = viewModel.countryList[row].name
        viewModel.selectedCountry = viewModel.countryList[row]
    }
}
