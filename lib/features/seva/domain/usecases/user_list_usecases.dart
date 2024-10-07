

import 'package:mayapur_bace/features/seva/data/model/seva_model.dart';
import 'package:mayapur_bace/features/seva/domain/repositories/seva_list_repositories.dart';

class GetSevaListUseCase {
  final SevaListRepositories repository;

  GetSevaListUseCase(this.repository);

  Future<List<SevaListModel>> call() {
    return repository.getSevaList();
  }

}

class UpdateSevaUsecases {
  final SevaListRepositories repository;

  UpdateSevaUsecases(this.repository);

  Future<void> callUpdateSeva(String newSeva, String userEmail) {

    return repository.updateSeva(newSeva, userEmail);
  }
}
