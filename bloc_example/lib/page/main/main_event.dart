part of 'main_bloc.dart';

//执行各类事件
@immutable
abstract class MainEvent {
}

class MainInitEvent extends MainEvent{

}

//定义执行动作的event
class SwitchTabEvent extends MainEvent {

  //定义你的入参
  final int selectedIndex;

  SwitchTabEvent({@required this.selectedIndex});


}

class IsExtendEvent extends MainEvent{


}