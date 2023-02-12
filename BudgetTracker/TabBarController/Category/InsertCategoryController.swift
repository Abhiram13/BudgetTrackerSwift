import UIKit;

extension UIColor {
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgba: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0 ;
        return String(format:"#%06x", rgba)
    }
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

class CategoryAddController: UIViewController {
    let circle = UIView();
    let textField = UITextField();
    let emojiField = UITextField();
    let descriptionField = UITextField();
    let button = UIButton();
    let colorPicker: UIColorWell =  {
        let picker = UIColorWell();
        picker.title = "Pick a color for Category";
        picker.selectedColor = .cyan;
        picker.supportsAlpha = true;
        
        return picker;
    }();
    
    override func viewDidLoad() {
        view.backgroundColor = .white;
        view.addSubview(colorPicker);
        view.addSubview(textField);
        view.addSubview(emojiField);
        view.addSubview(descriptionField);
        view.addSubview(button);                
        
        colorPicker.translatesAutoresizingMaskIntoConstraints = false;
        colorPicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true;
        colorPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true;
        colorPicker.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        colorPicker.heightAnchor.constraint(equalToConstant: 100).isActive = true;
        colorPicker.backgroundColor = .green;
        colorPicker.layer.cornerRadius = 50;
        colorPicker.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        colorPicker.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
        
        textField.translatesAutoresizingMaskIntoConstraints = false;
        textField.topAnchor.constraint(equalTo: colorPicker.bottomAnchor, constant: 20).isActive = true;
        textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true;
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        textField.placeholder = "Category name";
        
        emojiField.translatesAutoresizingMaskIntoConstraints = false;
        emojiField.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20).isActive = true;
        emojiField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true;
        emojiField.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        emojiField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        emojiField.placeholder = "🏠";
        
        descriptionField.translatesAutoresizingMaskIntoConstraints = false;
        descriptionField.topAnchor.constraint(equalTo: emojiField.bottomAnchor, constant: 20).isActive = true;
        descriptionField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true;
        descriptionField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        descriptionField.heightAnchor.constraint(equalToConstant: 100).isActive = true;
        descriptionField.placeholder = "Category description";
        
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 20).isActive = true;
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true;
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .systemBlue;
        button.titleLabel?.textColor = .white;
        button.addTarget(self, action: #selector(submit), for: .touchUpInside);
    }
    
    @objc private func colorChanged() {
        colorPicker.backgroundColor = colorPicker.selectedColor;
        print("Selected color is: \(colorPicker.selectedColor!)");
    }
    
    @objc private func submit() {
        print("Category color: \(colorPicker.selectedColor!.toHexString())");
        print("Category name: \(textField.text!)");
        print("Category icon: \(emojiField.text!.decode())");
        print("Category description: \(descriptionField.text!)");
        
        let _: StatusCode = Categories.insert(payload: Category(
            name: textField.text!,
            description: descriptionField.text!,
            icon: emojiField.text!.encode(),
            color: colorPicker.selectedColor!.toHexString()
        ));
        
        self.dismiss(animated: true);
    }
}
