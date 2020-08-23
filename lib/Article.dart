class Article{
  final String title;
  final String body;
  final String postedBy;
  final String postedAt;

  Article({this.title, this.body, this.postedBy, this.postedAt});

  factory Article.fromJson(Map<String, dynamic> parsedJson){
    return Article(
      title: parsedJson['title'],
      body: parsedJson['body'],
      postedBy: parsedJson['posted_by'],
      postedAt: parsedJson['posted_at'],
    );
  }

}