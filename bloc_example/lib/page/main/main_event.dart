part of 'main_bloc.dart';

//执行各类事件
@immutable
abstract class MainEvent extends Equatable {
  const MainEvent();
}

//定义执行动作的event
class SwitchTabEvent extends MainEvent {

  //定义你的入参
  final int selectedIndex;

  const SwitchTabEvent({@required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}

class IsExtendEvent extends MainEvent{

  const IsExtendEvent();

  @override
  List<Object> get props => [];

}