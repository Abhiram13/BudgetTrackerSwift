import UIKit;

class LogController: UIViewController {
    let scroller = UIScrollView();
    let stackView = UIStackView();
    let logs: [LoggerType] = [];
    let noLogsLabel = UILabel();
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white;
        
        view.addSubview(scroller);
        
        scroller.addSubview(stackView);
        scroller.translatesAutoresizingMaskIntoConstraints = false;
        scroller.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true;
        scroller.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true;
        scroller.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true;
        scroller.contentSize = CGSize(width: view.frame.width, height: 5000);
        
        stackView.axis = .vertical;
        stackView.alignment = .fill;
        stackView.spacing = 20;
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.topAnchor.constraint(equalTo: scroller.topAnchor).isActive = true;
        stackView.widthAnchor.constraint(equalTo: scroller.widthAnchor).isActive = true;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let logs: [LoggerType] = Logger.list();
        
        if logs.count > 0 {
            noLogsLabel.removeFromSuperview();
            for log in logs {
                stackView.addArrangedSubview(LogView(info: log.information, title: log.title, date: log.date));
            }
        } else {
            stackView.addArrangedSubview(noLogsLabel);
            
            noLogsLabel.translatesAutoresizingMaskIntoConstraints = false;
            noLogsLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 170).isActive = true;
            noLogsLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 250).isActive = true;
            noLogsLabel.text = "No Logs";
            noLogsLabel.font = .systemFont(ofSize: 20, weight: .medium);
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stackView.subviews.forEach { loggerView in
            loggerView.removeFromSuperview();
        }
    }
}

class LogView: UIView {
    var dateValue: String = "";
    var infoValue: String = "";
    var titleValue: String = "";
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!;
    }
    
    init(info: String, title: String, date: String) {
        super.init(frame: .zero);
        self.dateValue = date;
        self.infoValue = info;
        self.titleValue = title;
    }
    
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
        layer.cornerRadius = 10;
        
        date.translatesAutoresizingMaskIntoConstraints = false;
        date.text = self.dateValue;
        date.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true;
        date.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true;
        date.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true;
        date.numberOfLines = 0;
        date.font = .systemFont(ofSize: 15, weight: .light)
        
        title.translatesAutoresizingMaskIntoConstraints = false;
        title.text = self.titleValue
        title.leadingAnchor.constraint(equalTo: date.trailingAnchor, constant: 10).isActive = true;
        title.topAnchor.constraint(equalTo: date.topAnchor).isActive = true;
        title.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true;
        title.numberOfLines = 0;
        title.font = .systemFont(ofSize: 17, weight: .medium)
        
        info.translatesAutoresizingMaskIntoConstraints = false;
        info.text = self.infoValue;
        info.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true;
        info.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5).isActive = true;
        info.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true;
        info.widthAnchor.constraint(equalTo: title.widthAnchor).isActive = true;
        info.numberOfLines = 0;
        info.font = .systemFont(ofSize: 16, weight: .regular)
        info.textColor = .systemGray
    }
}
