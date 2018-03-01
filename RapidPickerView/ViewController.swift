import UIKit

final class FirstViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var pickerView: UIPickerView?
    @IBOutlet weak var toolbar: UIToolbar?
    
    private var availableItems: [String] = ["iPhone", "iPad", "iPod"]
    private var selectedItems: [String] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    private var fakeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fakeTextField = UITextField(frame: .zero)
        guard let fakeTextField = fakeTextField else {
            return
        }
        self.view.addSubview(fakeTextField)
        fakeTextField.inputView = pickerView
        fakeTextField.inputAccessoryView = toolbar
    }
    
    @IBAction func onShow() {
        fakeTextField?.becomeFirstResponder()
    }
    
    @IBAction func onAdd() {
        fakeTextField?.resignFirstResponder()

        guard let index = pickerView?.selectedRow(inComponent: 0) else {
            return
        }
        selectedItems.append(availableItems[index])
    }
    
    @IBAction func onDismiss() {
        fakeTextField?.resignFirstResponder()
    }
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath)
        cell.textLabel?.text = selectedItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let remove = UITableViewRowAction(style: .normal, title: "Remove") { _, _ in
            self.selectedItems.remove(at: indexPath.row)
        }
        remove.backgroundColor = UIColor.red
        
        return [remove]
    }
}

extension FirstViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return availableItems[row]
    }
}

