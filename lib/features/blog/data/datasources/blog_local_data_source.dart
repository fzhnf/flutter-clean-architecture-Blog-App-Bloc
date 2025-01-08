import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImpl(this.box);

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();
    box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        box.put(i.toString(), blogs[i].toJson());
      }
    });
  }

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogList = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        blogList.add(BlogModel.fromJson(box.get(i.toString())));
      }
    });
    return blogList;
  }
}
