class Note {
  int? _id;
  late String _title;
  String? _description;
  late String _date;
  late int _priority;

  // Constructor with optional description
  Note(this._title, this._date, this._priority, [this._description]);

  // Constructor with id
  Note.withId(this._id, this._title, this._date, this._priority, [this._description]);

  // Getters
  int? get id => _id;
  String get title => _title;
  String? get description => _description;
  int get priority => _priority;
  String get date => _date;

  // Setters with validation
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  set description(String? newDescription) {
    if (newDescription == null || newDescription.length <= 255) {
      _description = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      _priority = newPriority;
    }
  }

  set date(String newDate) {
    _date = newDate;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'title': _title,
      'description': _description,
      'priority': _priority,
      'date': _date,
    };
  }

  // Extract a Note object from a Map object
  factory Note.fromMapObject(Map<String, dynamic> map) {
    return Note.withId(
      map['id'] as int?,
      map['title'] as String,
      map['date'] as String,
      map['priority'] as int,
      map['description'] as String?,
    );
  }
}
