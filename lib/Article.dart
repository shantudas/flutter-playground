class Article{
  final int id;
  final String title;
  final String body;
  final String postedBy;
  final String postedAt;

  Article({this.id, this.title, this.body, this.postedBy, this.postedAt});

  factory Article.fromJson(Map<String, dynamic> parsedJson){
    return Article(
      id: parsedJson['id'],
      title: parsedJson['title'],
      body: parsedJson['body'],
      postedBy: parsedJson['posted_by'],
      postedAt: parsedJson['posted_at'],
    );
  }

}