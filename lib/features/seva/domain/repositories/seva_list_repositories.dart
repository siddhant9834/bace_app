
import 'package:mayapur_bace/features/seva/data/model/seva_model.dart';

abstract class SevaListRepositories {
  Future<List<SevaListModel>> getSevaList();
    Future<void> updateSeva(String newSeva, String userEmail);

}
