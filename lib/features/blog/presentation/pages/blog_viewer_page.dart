import 'package:blog_app/core/theme/pallete.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/format_date.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogViewerPage(blog: blog));
  final Blog blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blog.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              Text('By ${blog.posterName}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 5,
              ),
              Text(
                  '${formatDateByDMMMYYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppPallete.greyColor,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(blog.imageUrl),
              ),
              Text(
                blog.content,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
      ),
    );
  }
}
