import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/constants/constansts.dart';
import 'package:blog_app/core/theme/pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());

  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          Constansts.appName,
          textAlign: TextAlign.center,
        )),
        leading: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AuthSuccess) {
              final user = state.user; // Access the user data
              return PopupMenuButton<String>(
                icon: const Icon(CupertinoIcons.person),
                onSelected: (value) {
                  if (value == 'logout') {
                    context.read<AuthBloc>().add(AuthSignOut());
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    enabled: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${user.name}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Email: ${user.email}'),
                        Text('ID: ${user.id}'),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Text('Logout', style: TextStyle(color: Colors.red)),
                  ),
                ],
              );
            } else {
              return const Icon(CupertinoIcons.person);
            }
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, AddNewBlogPage.route());
              },
              icon: const Icon(CupertinoIcons.add_circled))
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(listener: (context, state) {
        if (state is BlogFailure) {
          showSnackBar(context, state.error);
        }
      }, builder: (context, state) {
        if (state is BlogLoading) {
          return const Loader();
        }
        if (state is BlogsDisplaySuccess) {
          return ListView.builder(
            itemCount: state.blogs.length,
            itemBuilder: (context, index) {
              final blog = state.blogs[index];
              return BlogCard(
                blog: blog,
                color: index % 3 == 0
                    ? AppPallete.gradient1
                    : index % 3 == 1
                        ? AppPallete.gradient2
                        : AppPallete.gradient3,
              );
            },
          );
        }
        return const SizedBox();
      }),
    );
  }
}
