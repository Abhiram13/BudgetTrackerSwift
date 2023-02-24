class Category {
    let name: String;
    let description: String;
    let icon: String;
    let color: String;
    
    init(name: String, description: String, icon: String, color: String) {
        self.name = name
        self.description = description
        self.icon = icon
        self.color = color
    }
}

class CategoryWithId: Category {
    let id: Int;
    let rowId: String;
    
    init(id: Int, rowId: String, name: String, description: String, icon: String, color: String) {
        self.id = id
        self.rowId = rowId;
        super.init(name: name, description: description, icon: icon, color: color);
    }
}

struct CategorySelectableList: Decodable, Hashable {
    let rowId: String;
    let name: String;
}
