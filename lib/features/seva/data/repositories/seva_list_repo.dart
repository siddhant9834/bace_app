
import 'package:mayapur_bace/features/seva/data/datasource/seva_list_datasource.dart';
import 'package:mayapur_bace/features/seva/data/model/seva_model.dart';
import 'package:mayapur_bace/features/seva/domain/repositories/seva_list_repositories.dart';

class SevaListRepositoryImpl implements SevaListRepositories {
  final SevaListDataService datasource;

  SevaListRepositoryImpl(this.datasource);


  @override
  Future<List<SevaListModel>> getSevaList() {
    return datasource.getSevaList();
  }


}
