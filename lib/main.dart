import 'package:board/board_item_object.dart';
import 'package:board/board_list_object.dart';
import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:boardview/boardview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BoardViewExample(),
    );
  }
}

class BoardViewExample extends StatelessWidget {
  List<BoardListObject> boardListObjectList = [
    BoardListObject(
        title: 'Coluna1', items: [BoardItemObject(title: 'item11')]),
    BoardListObject(title: 'Coluna2', items: [
      BoardItemObject(title: 'item21'),
      BoardItemObject(title: 'item22')
    ]),
    BoardListObject(title: 'Coluna3', items: [BoardItemObject(title: 'item1')]),
  ];
  BoardViewController boardViewController = BoardViewController();

  @override
  Widget build(BuildContext context) {
    List<BoardList> boardList = List<BoardList>();
    for (int i = 0; i < boardListObjectList.length; i++) {
      boardList.add(_createBoardList(boardListObjectList[i]));
    }

    return BoardView(
      lists: boardList,
      boardViewController: boardViewController,
    );
  }

  Widget _createBoardList(BoardListObject boardListObject) {
    List<BoardItem> boardItemList = List();
    for (var i = 0; i < boardListObject.items.length; i++) {
      boardItemList.insert(i, buildBoardItem(boardListObject.items[i]));
    }
    return BoardList(
      onStartDragList: (int listIndex) {
        print('BoardList.onStartDragList');
      },
      onTapList: (int listIndex) {
        print('BoardList.onTapList');
      },
      onDropList: (listIndex, oldListIndex) {
        var boardListObject = boardListObjectList[oldListIndex];
        boardListObjectList.removeAt(oldListIndex);
        boardListObjectList.insert(listIndex, boardListObject);
      },
      headerBackgroundColor: Color.fromARGB(255, 235, 236, 240),
      backgroundColor: Color.fromARGB(255, 235, 236, 240),
      draggable: false,
      header: [
        Icon(Icons.ac_unit),
        // Expanded(
        //   child: Padding(
        //     padding: EdgeInsets.all(5),
        //     child: Text(
        //       boardListObject.title,
        //       style: TextStyle(fontSize: 20),
        //     ),
        //   ),
        // ),
      ],
      items: boardItemList,
    );
  }

  Widget buildBoardItem(BoardItemObject itemObject) {
    return BoardItem(
      onStartDragItem: (int listIndex, int itemIndex, BoardItemState state) {
        print('BoardItem.onStartDragItem');
      },
      onDropItem: (int listIndex, int itemIndex, int oldListIndex,
          int oldItemIndex, BoardItemState state) {
        print('BoardItem.onDropItem');
        var item = boardListObjectList[oldListIndex].items[oldItemIndex];
        boardListObjectList[oldListIndex].items.removeAt(oldItemIndex);
        boardListObjectList[listIndex].items.insert(itemIndex, item);
      },
      onTapItem: (int listIndex, int itemIndex, BoardItemState state) {
        print('BoardItem.onTapItem');
      },
      item: Card(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(itemObject.title),
        ),
      ),
    );
  }
}
