import UIKit

extension UIViewController{
    func dismissKeyBoardWhenTappingAround() {
       let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dissmissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dissmissKeyboard(){
        view.endEditing(false)
    }
    
}

class ViewController: UIViewController {
    
    var submitted :Bool = false

    @IBOutlet weak var Classtext: UITextView!
    
    @IBOutlet weak var ClassYearTextField: UITextField!
    
    @IBOutlet weak var Nametext: UITextView!
  
    @IBOutlet weak var NameTextField: UITextField!
    
    @IBOutlet weak var SubmitButton: UIButton!
    
    @IBOutlet weak var DisplayLabel: UILabel!
    
    func enterClearMode() -> Void {
        Nametext.isHidden = true
        Classtext.isHidden = true
        NameTextField.isHidden = true
        ClassYearTextField.isHidden = true
        DisplayLabel.isHidden = false
        SubmitButton.setTitle("Clear", for: .normal)
        submitted = true
    }
    
    func enterSubmitMode() -> Void {
        Nametext.isHidden = false
        Classtext.isHidden = false
        NameTextField.isHidden = false
        ClassYearTextField.isHidden = false
        DisplayLabel.isHidden = true
        SubmitButton.setTitle("Submit", for: .normal)
        submitted = false
    }
    
    @IBAction func SubmitButtonTapped(_ sender: Any) {
        if (submitted){
            UserDefaults.standard.removeObject(forKey: "name")
            UserDefaults.standard.removeObject(forKey: "class")
            enterSubmitMode()
        }else{
            let name = NameTextField.text ?? ""
            let classYr = ClassYearTextField.text ?? ""
            DisplayLabel.text = "Welcome " + name + " of " + classYr + "!"
            NameTextField.text = ""
            ClassYearTextField.text = ""
            UserDefaults.standard.set(name, forKey:"name")
            UserDefaults.standard.set(classYr, forKey:"class")
            enterClearMode()
        }
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyBoardWhenTappingAround()
        if (UserDefaults.standard.object(forKey: "name") != nil){
            let name = UserDefaults.standard.string(forKey: "name")
            let classYr = UserDefaults.standard.string(forKey: "class")
            DisplayLabel.text = "Welcome, " + name! + "of " + classYr! + "!"
            enterClearMode()
        }else{
            enterSubmitMode()
        }
        
        if (Cat.count == 0){
            Cat.loadCats { (result) in
                for dict in result {
                    let imageURL = URL(string: dict["image"]!)
                    let image = UIImage(data: try! Data(contentsOf: imageURL!))
                    Cat.addCat(catName: dict["name"]!, catImage: image!, catAge: Int(dict["age"]!)!, catType: dict["type"]!)
                    
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

