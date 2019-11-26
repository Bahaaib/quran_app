import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quran_app/resources/strings.dart';
import 'package:quran_app/resources/integers.dart';

class ReadersDialog extends StatefulWidget {
  Function changeReader;

  ReadersDialog(this.changeReader);

  _ReadersDialogState createState() => _ReadersDialogState(changeReader);
}

class _ReadersDialogState extends State<ReadersDialog> {
  Function changeReader;

  _ReadersDialogState(this.changeReader);

  List<Reader> _readers = [
    Reader(name: Readers.ABDULBASIT, index: 0),
    Reader(name: Readers.SIDIYQ, index: 1),
    Reader(name: Readers.MAHER, index: 2),
    Reader(name: Readers.ALSUDAIS, index: 3),
    Reader(name: Readers.ALGHAMDI, index: 4),
    Reader(name: Readers.HUTHAIFY, index: 5),
    Reader(name: Readers.BDYR, index: 6),
    Reader(name: Readers.SHURAIM, index: 7),
  ];
  String _currentName;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text('Reader Selected'),
            ),
            IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
                onPressed: () => Navigator.pop(context, true))
          ],
        ),
        children: _readers
            .map((reader) => RadioListTile(
                title: Text(reader.name),
                value: reader.index,
                groupValue: AppIntegers.DIALOG_INDEX,
                onChanged: (value) {
                  setState(() {
                    AppIntegers.DIALOG_INDEX = reader.index;
                    _currentName = reader.name;
                    changeReader(AppIntegers.DIALOG_INDEX);
                    Navigator.pop(context, true);
                  });
                }))
            .toList());
  }
}

class Reader {
  String name;
  int index;

  Reader({this.name, this.index});
}
