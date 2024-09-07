
import 'package:mayapur_bace/features/members/data/model/members_model.dart';
import 'package:mayapur_bace/features/members/domain/repositories/members_repositories.dart';

class GetMembersUseCase {
  final MembersReposotories repository;

  GetMembersUseCase(this.repository);

  Future<List<MembersModel>> call() {
    return repository.getMembers();
  }

}