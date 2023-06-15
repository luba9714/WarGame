

import UIKit

protocol InsertNameDelegate: AnyObject {
    func didEnterText(_ text: Any)
}

class InsertNameViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    weak var delegate: InsertNameDelegate?

    
    
    
    @IBAction func goBackButtonTapped(_ sender: Any) {
        storeTextInUserDefaults()
        delegate?.didEnterText(true)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    func storeTextInUserDefaults() {
        UserDefaults.standard.set(textField.text, forKey: "StoredTextKey")
    }
}







