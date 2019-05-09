
import UIKit
import Alamofire

class DangKy_ViewController: UIViewController {
    
    let urlString = "http://3.1.50.154:3000/users/create"
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRePassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
    }
    
    @IBAction func btnRegister(_ sender: Any)
    {
        if (txtEmail.text?.isEmpty)!
        {
            displayAlert(massage: "Chưa nhập Email")
        }
        else if (txtUsername.text?.isEmpty)!
        {
            displayAlert(massage: "Chưa nhập Username")
        }
        else if (txtPassword.text?.isEmpty)!
        {
            displayAlert(massage: "Chưa nhập mật khẩu")
        }
        else if (txtRePassword.text?.isEmpty)!
        {
            displayAlert(massage: "Chưa xác nhận mật khẩu")
            
        }
        else if txtRePassword.text != txtPassword.text
        {
            displayAlert(massage: "Nhập lại mật khẩu sai")
        }
        else
        {
            let parameters : [String: Any] =
            [
                "name" : txtUsername.text as Any,
                "email" : txtEmail.text as Any,
                "password" : txtPassword.text as Any
            ]
            
            let headers: HTTPHeaders =
            [
                "Content-Type": "application/json"
            ]
            Alamofire.request(urlString, method:.post, parameters:parameters as Parameters,encoding: JSONEncoding.default , headers:headers).responseJSON { response in
                if let responeseValue = response.result.value as! [String: Any]? {
                    
                    if responeseValue["error"] as! Int == 0 {
                        self.displayAlert1(massage: "Đăng ký thành công, Quay lại đăng nhập")
                        self.txtEmail.text = ""
                        self.txtPassword.text = ""
                        self.txtUsername.text = ""
                        self.txtRePassword.text = ""
                        print(responeseValue["error"] as Any)
                    }
                    else
                    {
                        let alertString:[String] = responeseValue["message"] as! [String]
                        let string:String =  alertString.joined(separator: ",")
                        self.displayAlert(massage: string)
                    }
                }
            }
        }
    }
    
    @IBAction func btnBackToLogin(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    // validate Email
    func isValidEmail(emailID:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    //display alert
    func displayAlert (massage: String){
        let alert = UIAlertController(title: "Alert", message: massage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    // validate Password
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$")
        return passwordTest.evaluate(with: password)
    }
    
    func displayAlert1 (massage: String){
        let alert = UIAlertController(title: "Alert", message: massage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: ok)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    func ok(alert: UIAlertAction)
    {
        self.performSegue(withIdentifier: "registerTomain", sender: nil)
    }
}
