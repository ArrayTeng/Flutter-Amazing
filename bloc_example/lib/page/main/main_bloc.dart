import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState().init());

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is MainInitEvent) {
      yield await init();
    } else if (event is SwitchTabEvent) {
      yield switchTab(event);
    } else if (event is IsExtendEvent) {
      yield MainState()
        ..selectIndex = state.selectIndex
        ..isExpanded = !state.isExpanded;
    }
  }

  Future<MainState> init() async {
    return state.clone();
  }

  MainState switchTab(SwitchTabEvent event) {
    return state.clone()..selectIndex = event.selectedIndex;
  }

  MainState isExpand(){
    return state.clone()..isExpanded = !state.isExpanded;
  }
}
