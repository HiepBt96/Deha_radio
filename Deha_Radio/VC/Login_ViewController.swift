
import UIKit
import Alamofire

class Login_ViewController: UIViewController {
    let urlString = "http://3.1.50.154:3000/users/login"
    
    @IBOutlet weak var txtPassWord: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnLoginOutlet: UIButton!
    
    @IBAction func btnLogin(_ sender: Any) {
       
        if (txtEmail.text?.isEmpty)!
            {
                displayAlert(massage: "Chưa nhập Email")
            }
        else if  (txtPassWord.text?.isEmpty)!
            {
                displayAlert(massage: "Chưa nhập mật khẩu")
            }
       else
        {
            let parameters : [String: Any] = [
                "name": txtEmail.text as Any,
                "password" : txtPassWord.text as Any
            ]
    
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            Alamofire.request(urlString, method:.post, parameters:parameters as Parameters,encoding: JSONEncoding.default , headers:headers).responseJSON { response in
                if let responeseValue = response.result.value as! [String: Any]? {
                    if responeseValue["error"] as! Int == 0 {
                        self.performSegue(withIdentifier: "LoginToMain", sender: nil)
                    }
                    else{
                        let alertString:String = responeseValue["message"] as! String
                        self.displayAlert(massage: alertString)
                        print(alertString)
                    }
                }
            }
        }
    
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        let registerUser = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUser") as! DangKy_ViewController
        self.present(registerUser, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "background.png")!)
        btnLoginOutlet.layer.borderColor = UIColor.white.cgColor
        btnLoginOutlet.layer.borderWidth = 1
    }

    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$")
        return passwordTest.evaluate(with: password)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func displayAlert (massage: String){
        let alert = UIAlertController(title: "Alert", message: massage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
}

