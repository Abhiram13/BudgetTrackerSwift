import UIKit;

class CategoryAddController: UIViewController {
    let circle = UIView();
    let colorPicker: UIColorWell =  {
        let picker = UIColorWell();
        picker.title = "Pick a color for Category";
        picker.selectedColor = .cyan;
        picker.supportsAlpha = true;
        
        return picker;
    }();
    
    override func viewDidLoad() {
        view.backgroundColor = .red;
        view.addSubview(colorPicker);
        
        colorPicker.translatesAutoresizingMaskIntoConstraints = false;
        colorPicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true;
        colorPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true;
        colorPicker.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        colorPicker.heightAnchor.constraint(equalToConstant: 100).isActive = true;
        colorPicker.backgroundColor = .green;
        colorPicker.layer.cornerRadius = 50;
        colorPicker.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        colorPicker.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
    }
    
    @objc private func colorChanged() {
        view.backgroundColor = colorPicker.selectedColor;
        print("Selected color is: \(colorPicker.selectedColor)");
    }
}
