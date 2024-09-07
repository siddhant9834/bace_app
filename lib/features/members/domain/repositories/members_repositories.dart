
import 'package:mayapur_bace/features/members/data/model/members_model.dart';

abstract class MembersReposotories {
  Future<List<MembersModel>> getMembers();
}
