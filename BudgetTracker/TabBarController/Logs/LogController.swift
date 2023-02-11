import UIKit;

class LogController: UIViewController {
    let scroller = UIScrollView();
    let stackView = UIStackView();
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white;
        
        view.addSubview(scroller);
        
        scroller.addSubview(stackView);
        scroller.translatesAutoresizingMaskIntoConstraints = false;
        scroller.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true;
        scroller.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true;
        scroller.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true;
        scroller.contentSize = CGSize(width: view.frame.width, height: 2000);
        
        stackView.axis = .vertical;
        stackView.alignment = .fill;
        stackView.spacing = 20;
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.topAnchor.constraint(equalTo: scroller.topAnchor).isActive = true;
        stackView.widthAnchor.constraint(equalTo: scroller.widthAnchor).isActive = true;
        stackView.addArrangedSubview(LogView());
        
        for _ in 0..<5 {
            stackView.addArrangedSubview(LogView());
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("HERE IT IS AGAIN");
        Logger.list();
    }
    
    
}

class LogView: UIView {
    override func didMoveToSuperview() {
        self.superview != nil ? self.initalise() : nil;
    }
    
    private func initalise() {
        let parent = self.superview!;
        let date = UILabel();
        let title = UILabel();
        let info = UILabel();
        
        addSubview(date);
        addSubview(title);
        addSubview(info);
        
        translatesAutoresizingMaskIntoConstraints = false;
        widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: 0.9).isActive = true;
        leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 20).isActive = true;
//        heightAnchor.constraint(equalToConstant: 60).isActive = true;
        layer.cornerRadius = 10;
        
        
        date.translatesAutoresizingMaskIntoConstraints = false;
        date.text = "Some date";
        date.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true;
        date.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true;
        
        title.translatesAutoresizingMaskIntoConstraints = false;
        title.text = "Error at some where";
        title.leadingAnchor.constraint(equalTo: date.trailingAnchor, constant: 10).isActive = true;
        title.topAnchor.constraint(equalTo: date.topAnchor).isActive = true;
        title.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true;
        info.numberOfLines = 0;
        
        info.translatesAutoresizingMaskIntoConstraints = false;
        info.text = "This is some sample description, asjdgajsgdjasga audausdasuygdus";
        info.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true;
        info.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5).isActive = true;
        info.widthAnchor.constraint(equalTo: title.widthAnchor).isActive = true;
        info.numberOfLines = 0;
        info.backgroundColor = .green;
        
        print("height of the info is \(info)");
        heightAnchor.constraint(equalToConstant: 100).isActive = true;
        backgroundColor = .cyan;
    }
}
