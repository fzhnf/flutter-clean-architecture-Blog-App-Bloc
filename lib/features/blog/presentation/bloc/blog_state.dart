part of 'blog_bloc.dart';

final class BlogFailure extends BlogState {
  final String error;
  BlogFailure(this.error);
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

@immutable
sealed class BlogState {}

final class BlogUploadSuccess extends BlogState {}

final class BlogsDisplaySuccess extends BlogState {
  final List<Blog> blogs;
  BlogsDisplaySuccess(this.blogs);
}
