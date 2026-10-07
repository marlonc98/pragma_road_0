import 'package:flutter/material.dart';
import 'package:mi_perfil_dev/domain/states/developer_state.dart';

class DeveloperStateImpl extends DeveloperState with ChangeNotifier {
  @override
  void updateHiredStatus(bool hired) {
    developer?.hired = hired;
    notifyListeners();
  }
}