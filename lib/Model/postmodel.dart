class PostModel {
  int? id;
  String? title;
  String? articleSummary;
  String? image;
  String? linkNews;

  PostModel(
      {this.id, this.title, this.articleSummary, this.image, this.linkNews});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    articleSummary = json['article_summary'];
    image = json['image'];
    linkNews = json['link_news'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['article_summary'] = this.articleSummary;
    data['image'] = this.image;
    data['link_news'] = this.linkNews;
    return data;
  }
}