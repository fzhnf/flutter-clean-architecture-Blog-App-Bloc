import 'package:blog_app/core/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/secret/app_secrets.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory(() => Hive.box(name: 'blogs'));
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()));
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator(), serviceLocator()))
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerLazySingleton(() => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator()));
}

void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
        () => BlogRemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
        serviceLocator(), serviceLocator(), serviceLocator()))
    ..registerFactory(() => UploadBlog(serviceLocator()))
    ..registerFactory(() => GetAllBlogs(serviceLocator()))
    ..registerFactory<BlogLocalDataSource>(
        () => BlogLocalDataSourceImpl(serviceLocator()))
    ..registerLazySingleton(() =>
        BlogBloc(uploadBlog: serviceLocator(), getAllBlogs: serviceLocator()));
}
