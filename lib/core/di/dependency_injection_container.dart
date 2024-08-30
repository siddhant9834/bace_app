import 'package:get_it/get_it.dart';
import 'package:mayapur_bace/core/side_drawer/data/datasource/FB_auth_services.dart';
import 'package:mayapur_bace/core/side_drawer/data/repositories/profile_repo_impl.dart';
import 'package:mayapur_bace/core/side_drawer/domain/repositories/user_repo.dart';
import 'package:mayapur_bace/features/authentication/data/FireB_auth_impl_datasource.dart/firebase_auth_services_impl.dart';
import 'package:mayapur_bace/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:mayapur_bace/features/authentication/domain/repositories/auth_repositories.dart';
import 'package:mayapur_bace/features/authentication/domain/usecases/auth_usecases.dart';
import 'package:mayapur_bace/core/side_drawer/domain/usecases/get_profile_usecases.dart';
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

locator.registerLazySingleton<ProfileService>(() => ProfileService());

  locator.registerLazySingleton<ProfileReposotories>(
      () => ProfileRepositoryImpl(locator<ProfileService>()));
//   locator.registerSingleton<ProfileService>(ProfileService());
  locator.registerSingleton<GetProfileUseCase>(
    GetProfileUseCase(locator<ProfileReposotories>()),
  );
// //  locator.registerSingleton<ProfileReposotories>(
//   ProfileRepositoryImpl(locator<ProfileService>()),



}


