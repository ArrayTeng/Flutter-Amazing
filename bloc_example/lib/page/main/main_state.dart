part of 'main_bloc.dart';

//数据保存中转
class MainState {
  int selectIndex;

  bool isExpanded;

  MainState init() {
    return MainState()
      ..selectIndex = 0
      ..isExpanded = false;
  }

  MainState clone() {
    return MainState()
      ..selectIndex = selectIndex
      ..isExpanded = isExpanded;
  }
}
