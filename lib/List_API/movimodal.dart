class movimodal {
  int? id;
  String? title;
  String? author;
  String? datePublished;
  String? content;

  movimodal(
      {this.id, this.title, this.author, this.datePublished, this.content});

  movimodal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    datePublished = json['date_published'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author'] = this.author;
    data['date_published'] = this.datePublished;
    data['content'] = this.content;
    return data;
  }
}