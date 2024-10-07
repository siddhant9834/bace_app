import 'dart:developer';

import 'package:mayapur_bace/core/side_drawer/domain/repositories/profile_pic_repo.dart';
import 'package:mayapur_bace/core/side_drawer/domain/repositories/user_repo.dart';

class UpdateStatusUsecases {
  final ProfileReposotories repository;

  UpdateStatusUsecases(this.repository);

  Future<void> callStatus(bool status) {
    log('status usecases clicked');

    return repository.updateStatus(status);
  }
}
