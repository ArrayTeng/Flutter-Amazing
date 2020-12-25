import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState(selectIndex: 0, isExpanded: false));

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is SwitchTabEvent) {
      yield MainState()
        ..selectIndex = event.selectedIndex
        ..isExpanded = state.isExpanded;
    } else if (event is IsExtendEvent) {
      yield MainState()
        ..selectIndex = state.selectIndex
        ..isExpanded = !state.isExpanded;
    }
  }
}
