
abstract class PhotoReposotories {

  Future<void> addImage(String imageUrl, String category, String nameOfImage);
}

abstract class FetchPhotoReposotories {

  Future<List<Map<String, String>>> fetchImages( String category);
}