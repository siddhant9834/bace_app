import 'package:get_it/get_it.dart';
import 'package:mayapur_bace/core/side_drawer/data/datasource/FB_services.dart';
import 'package:mayapur_bace/core/side_drawer/data/repositories/profile_repo_impl.dart';
import 'package:mayapur_bace/core/side_drawer/domain/repositories/user_repo.dart';
import 'package:mayapur_bace/features/authentication/data/FireB_auth_impl_datasource.dart/firebase_auth_services_impl.dart';
import 'package:mayapur_bace/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:mayapur_bace/features/authentication/domain/repositories/auth_repositories.dart';
import 'package:mayapur_bace/features/authentication/domain/usecases/auth_usecases.dart';
import 'package:mayapur_bace/core/side_drawer/domain/usecases/get_profile_usecases.dart';
import 'package:mayapur_bace/features/members/data/data_source.dart/members_datasource.dart';
import 'package:mayapur_bace/features/members/data/repositories/members_repositores.dart';
import 'package:mayapur_bace/features/members/domain/repositories/members_repositories.dart';
import 'package:mayapur_bace/features/members/domain/usecases/members_usecases.dart';
import 'package:mayapur_bace/features/photos/data/datasource/firebase_datasource.dart';
import 'package:mayapur_bace/features/photos/data/repositories/photos_repo_impl.dart';
import 'package:mayapur_bace/features/photos/domain/repositories/photo_repositories.dart';
import 'package:mayapur_bace/features/photos/domain/usecases/update_image_url.dart';
import 'package:mayapur_bace/features/seva/data/datasource/seva_list_datasource.dart';
import 'package:mayapur_bace/features/seva/data/repositories/seva_list_repo.dart';
import 'package:mayapur_bace/features/seva/domain/repositories/seva_list_repositories.dart';
import 'package:mayapur_bace/features/seva/domain/usecases/user_list_usecases.dart';

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
  locator.registerSingleton<GetProfileUseCase>(
    GetProfileUseCase(locator<ProfileReposotories>()),
  );

  locator.registerLazySingleton<MembersDataService>(() => MembersDataService());

  locator.registerLazySingleton<MembersReposotories>(
      () => MembersRepositoryImpl(locator<MembersDataService>()));
  locator.registerSingleton<GetMembersUseCase>(
    GetMembersUseCase(locator<MembersReposotories>()),
  );

  locator
      .registerLazySingleton<SevaListDataService>(() => SevaListDataService());

  locator.registerLazySingleton<SevaListRepositories>(
      () => SevaListRepositoryImpl(locator<SevaListDataService>()));
      
  locator.registerSingleton<GetSevaListUseCase>(
    GetSevaListUseCase(locator<SevaListRepositories>()),
  );
// //  locator.registerSingleton<ProfileReposotories>(
//   ProfileRepositoryImpl(locator<ProfileService>()),
}

