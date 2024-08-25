import 'package:mayapur_bace/features/photos/domain/repositories/photo_repositories.dart';

class UpdateImageUrl {
  final PhotoReposotories repository;

  UpdateImageUrl(this.repository);

  Future<void> call(String imageUrl, String category, String nameOfImage) {
    return repository.addImage(imageUrl, category, nameOfImage);
  }
}

class FetchImage {
  final FetchPhotoReposotories repository;

  FetchImage(this.repository);

        // future: firebaseDatasource.fetchImages(category),
  Future<List<Map<String, String>>> call( String category) {
    return repository.fetchImages(category);
  }
}