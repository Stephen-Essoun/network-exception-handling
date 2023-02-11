class Post {
  final int? userId;
  final int? id;
  final String? title;
  final String? description;

  Post({
     this.userId,
     this.id,
     this.title,
     this.description,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
