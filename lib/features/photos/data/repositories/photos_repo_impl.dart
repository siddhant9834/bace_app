

import 'package:mayapur_bace/features/photos/data/datasource/firebase_datasource.dart';
import 'package:mayapur_bace/features/photos/domain/repositories/photo_repositories.dart';


class PhotosRepositoryImpl implements PhotoReposotories {
  final FirebaseDatasource datasource;

  PhotosRepositoryImpl(this.datasource,);

   Future<void>addImage(String imageUrl, String category, String nameOfImage) {
    return datasource.addImage(imageUrl, category, nameOfImage);
  }


  // imageUrl
}



class FetchPhotoRepositoryImpl implements FetchPhotoReposotories {
  final FirebaseDatasource datasource;

  FetchPhotoRepositoryImpl(this.datasource,);
Future<List<Map<String, String>>>fetchImages(String category) {
    return datasource.fetchImages(category);
  }


  // imageUrl
}
   