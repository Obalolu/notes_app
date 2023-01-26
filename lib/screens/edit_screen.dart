import 'package:flutter/material.dart';
import 'package:notes/services/database_helper.dart';
import 'package:notes/utilities/color_button.dart';
import 'package:notes/utilities/constants.dart';

class EditScreen extends StatefulWidget {
  EditScreen({this.id, this.title, this.content, this.lastUpdated, this.index, this.color});

  final int id;
  final int index;
  final String title;
  final String content;
  final String color;
  final String lastUpdated;

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final FocusScopeNode _node = FocusScopeNode();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  bool _fromCard = false;
  String color;
  bool isVisible = false;

  List<Map<String, dynamic>> colorList = [
    {'color': '0xFFFEFEFF', 'isVisible': false},
    {'color': '0xFF77A688', 'isVisible': false},
    {'color': '0xFFCA7D80', 'isVisible': false},
    {'color': '0xFFA7BC4E', 'isVisible': false},
    {'color': '0xFFF4E466', 'isVisible': false},
    {'color': '0xFFEF5C57', 'isVisible': false},
    {'color': '0xFF78D7F7', 'isVisible': false},
    {'color': '0xFFD49E21', 'isVisible': false},
    {'color': '0xFFBED1DA', 'isVisible': false},
    {'color': '0xFFF2FBE0', 'isVisible': false},
    {'color': '0xFFE6BCCD', 'isVisible': false},
    {'color': '0xFFB8B7B8', 'isVisible': false}
  ];

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title == null ? '' : widget.title;
    contentController.text = widget.content == null ? '' : widget.content;
    if (widget.title != null) {
      _fromCard = true;
    }
    color = widget.color == null ? colorList[0]['color'] : widget.color;
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed() async {
    Map<String, dynamic> row;
    if (_fromCard) {
      row = {
        'id': widget.id,
        'title': titleController.text,
        'content': contentController.text,
        'color': color,
        'lastUpdated': DateTime.now().toString(),
      };
      int rowId = await DatabaseHelper.instance.update(row);
      print('The updated row id is: $rowId');
      Navigator.pop(context, titleController.text);
    } else {
      if (titleController.text.trim() != '' &&
          contentController.text.trim() != '') {
        row = {
          'title': titleController.text,
          'content': contentController.text,
          'color': color,
          'created': DateTime.now().toString(),
          'lastUpdated': DateTime.now().toString(),
        };
        int rowId = await DatabaseHelper.instance.insert(row);
        print('The inserted row id is: $rowId');
        Navigator.pop(context, titleController.text);
      }
    }
    return true ?? false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          color: Colors.black.withOpacity(0.7),
          child: Stack(
            children: [
              Hero(
                tag:
                    widget.index == null ? 'noteTag' : 'noteTag${widget.index}',
                child: Padding(
                  padding: EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 132),
                  child: Card(
                    color: Color(int.parse(color)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 0,
                                    child: IconButton(
                                        splashRadius: 24,
                                        icon: Icon(Icons.arrow_back),
                                        onPressed: _onBackPressed)),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Edited 9:12 AM',
                                      textAlign: TextAlign.center,
                                    )),
                                Expanded(
                                    flex: 0,
                                    child: IconButton(
                                        splashRadius: 24,
                                        icon: Icon(Icons.more_vert),
                                        onPressed: () {})),
                              ],
                            ),
                          ),
                          Divider(
                            height: 2,
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: FocusScope(
                                node: _node,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    // email
                                    Expanded(
                                      flex: 0,
                                      child: TextFormField(
                                        decoration: kTitleInputDecoration,
                                        style: kEditTitleTextStyle,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        controller: titleController,
                                        onEditingComplete: _node.nextFocus,
                                      ),
                                    ),
                                    // password
                                    Expanded(
                                      flex: 2,
                                      child: SingleChildScrollView(
                                        child: TextFormField(
                                          maxLines: 99999999,
                                          decoration: kContentInputDecoration,
                                          style: kEditContentTextStyle,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          textInputAction:
                                              TextInputAction.done,
                                          controller: contentController,
                                          onEditingComplete: _node.nextFocus,
                                        ),
                                      ),
                                    ),
                                    // submit
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 2,
                          ),
                          Expanded(
                            flex: 0,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: IconButton(
                                        splashRadius: 24,
                                        icon: Icon(Icons.add_box_outlined),
                                        onPressed: () {})),
                                Spacer(
                                  flex: 5,
                                ),
                                Expanded(
                                    flex: 0,
                                    child: IconButton(
                                        splashRadius: 24,
                                        icon: Icon(Icons.push_pin_outlined),
                                        onPressed: () {})),
                                Expanded(
                                    flex: 0,
                                    child: IconButton(
                                        splashRadius: 24,
                                        icon: Icon(
                                            Icons.notifications_none_outlined),
                                        onPressed: () {})),
                                Expanded(
                                    flex: 0,
                                    child: IconButton(
                                        splashRadius: 24,
                                        icon: Icon(Icons.archive_outlined),
                                        onPressed: () {})),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -5,
                left: -5,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(34),
                          topRight: Radius.circular(34))),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    alignment: Alignment.centerLeft,
                    width: size.width,
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 12,
                      itemBuilder: (BuildContext context, int index) => ColorButton(
                        color: colorList[index]['color'],
                        isVisible: colorList[index]['isVisible'],
                        onPressed: () {
                          setState(() {
                            color = colorList[index]['color'];
                            colorList[0]['isVisible'] = false;
                            colorList[1]['isVisible'] = false;
                            colorList[2]['isVisible'] = false;
                            colorList[3]['isVisible'] = false;
                            colorList[4]['isVisible'] = false;
                            colorList[5]['isVisible'] = false;
                            colorList[6]['isVisible'] = false;
                            colorList[7]['isVisible'] = false;
                            colorList[8]['isVisible'] = false;
                            colorList[9]['isVisible'] = false;
                            colorList[10]['isVisible'] = false;
                            colorList[11]['isVisible'] = false;
                            colorList[index]['isVisible'] = true;
                            print('pressed');
                          });
                      },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
