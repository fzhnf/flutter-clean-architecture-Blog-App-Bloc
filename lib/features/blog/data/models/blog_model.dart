import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel(
      {required super.id,
      required super.posterId,
      required super.title,
      required super.content,
      required super.topics,
      required super.imageUrl,
      required super.updatedAt,
      super.posterName});
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': super.id,
      'poster_id': super.posterId,
      'title': super.title,
      'content': super.content,
      'topics': super.topics,
      'image_url': super.imageUrl,
      'updated_at': super.updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['poster_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] as String,
      topics: List<String>.from(map['topics'] ?? []),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(),
    );
  }

  BlogModel copyWith(
      {String? id,
      String? posterId,
      String? title,
      String? content,
      List<String>? topics,
      String? imageUrl,
      DateTime? updatedAt,
      String? posterName}) {
    return BlogModel(
        id: id ?? this.id,
        posterId: posterId ?? this.posterId,
        title: title ?? this.title,
        content: content ?? this.content,
        topics: topics ?? this.topics,
        imageUrl: imageUrl ?? this.imageUrl,
        updatedAt: updatedAt ?? this.updatedAt,
        posterName: posterName ?? this.posterName);
  }
}
