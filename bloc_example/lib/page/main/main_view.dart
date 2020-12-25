import 'package:bloc_example/page/main/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MainBloc()..add(MainInitEvent()),
      child: BodyPage(),
    );
  }
}

class BodyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc demo'),
      ),
      body: totalPage(),
    );
  }
}

Widget totalPage() {
  return Row(
    children: [
      navigationRailSide(),
      Expanded(
        child: Center(
          child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              //每一个要刷新的组件外要包裹 BlocBuilder
              return Text('selectedIndex:' + state.selectIndex.toString());
            },
          ),
        ),
      ),
    ],
  );
}

Widget navigationRailSide() {
  //顶部头像
  Widget topWidget = Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(
                    'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3383029432,2292503864&fm=26&gp=0.jpg'),
                fit: BoxFit.fill)),
      ),
    ),
  );
  //底部切换图标
  Widget bottomWidget = Container(
    child: BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: () {
            BlocProvider.of<MainBloc>(context).add(
              IsExtendEvent(),
            );
          },
          child: Icon(state.isExpanded ? Icons.send : Icons.navigation),
        );
      },
    ),
  );

  return BlocBuilder<MainBloc, MainState>(
    builder: (context, state) {
      return NavigationRail(
        elevation: 3,
        extended: state.isExpanded,
        selectedIndex: state.selectIndex,
        labelType: state.isExpanded
            ? NavigationRailLabelType.none
            : NavigationRailLabelType.selected,
        destinations: [
          NavigationRailDestination(
            icon: Icon(Icons.add_to_queue),
            selectedIcon: Icon(Icons.add_to_photos),
            label: Text("测试一"),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: Text("测试二"),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.bubble_chart),
            selectedIcon: Icon(Icons.broken_image),
            label: Text("测试三"),
          ),
        ],
        leading: topWidget,
        trailing: bottomWidget,
        onDestinationSelected: (int index) {
          BlocProvider.of<MainBloc>(context).add(
            SwitchTabEvent(selectedIndex: index),
          );
        },
      );
    },
  );
}
