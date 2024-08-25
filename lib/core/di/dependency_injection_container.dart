import 'package:get_it/get_it.dart';
import 'package:mayapur_bace/features/authentication/data/datasource/auth_datasource.dart';
import 'package:mayapur_bace/features/authentication/data/repositories/auth_repositories.dart';
import 'package:mayapur_bace/features/authentication/domain/repositories/auth_repositories.dart';
import 'package:mayapur_bace/features/authentication/domain/usecases/auth_usecases.dart';
import 'package:mayapur_bace/features/home/data/data_source/quote_remote_datasource.dart';
import 'package:mayapur_bace/features/home/data/repo_impl/quote_repo_impl.dart';
import 'package:mayapur_bace/features/photos/data/datasource/firebase_datasource.dart';
import 'package:mayapur_bace/features/photos/data/repositories/photos_repo_impl.dart';
import 'package:mayapur_bace/features/photos/domain/repositories/photo_repositories.dart';
import 'package:mayapur_bace/features/photos/domain/usecases/update_image_url.dart';
final locator = GetIt.instance;

void setUp() {
  locator.registerSingleton(FirebaseDatasource());

  locator.registerSingleton<PhotoReposotories>(
    PhotosRepositoryImpl(locator<FirebaseDatasource>()),
  );

  locator.registerSingleton<FetchPhotoReposotories>(
    FetchPhotoRepositoryImpl(locator<FirebaseDatasource>()),
  );

  locator.registerSingleton(UpdateImageUrl(locator<PhotoReposotories>()));
  locator.registerSingleton(FetchImage(locator<FetchPhotoReposotories>()));

  
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<AuthUseCases>(AuthUseCases());
  locator.registerSingleton<AuthRepository>(AuthRepositoryImpl());
}

// final locator = GetIt.instance;

// void setDi() {
//   // locator.registerSingleton(FirebaseDatasource());

//   // locator.registerSingleton(FetchPhotoRepositoryImpl(FirebaseDatasource()));
//   // locator.registerSingleton(UpdateImageUrl(locator<PhotoReposotories>()));
//   // locator.registerSingleton(FetchImage(locator<FetchPhotoReposotories>()));
//   // locator
//   //     .registerSingleton(PhotosRepositoryImpl(locator<FirebaseDatasource>()));
      
// // // Register FirebaseDatasource
//   locator.registerSingleton(FirebaseDatasource());

//   // Register repositories with their dependencies
//   locator.registerSingleton<PhotoReposotories>(
//     PhotosRepositoryImpl(locator<FirebaseDatasource>()),
//   );

//   locator.registerSingleton<FetchPhotoReposotories>(
//     FetchPhotoRepositoryImpl(locator<FirebaseDatasource>()),
//   );

//   // Register use cases with their dependencies
//   locator.registerSingleton(UpdateImageUrl(locator<PhotoReposotories>()));
//   locator.registerSingleton(FetchImage(locator<FetchPhotoReposotories>()));
// }
