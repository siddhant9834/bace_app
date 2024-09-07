
import 'package:mayapur_bace/features/members/data/data_source.dart/members_datasource.dart';
import 'package:mayapur_bace/features/members/data/model/members_model.dart';
import 'package:mayapur_bace/features/members/domain/repositories/members_repositories.dart';

class MembersRepositoryImpl implements MembersReposotories {
  final MembersDataService datasource;

  MembersRepositoryImpl(this.datasource);


  @override
  Future<List<MembersModel>> getMembers() {
    return datasource.getMembers();
  }


}
