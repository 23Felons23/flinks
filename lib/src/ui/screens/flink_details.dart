import 'package:flink_app/src/services/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlinkDetails extends StatefulWidget {
  final flinkId;
  final flinkUrl;
  final flinkDescription;

  const FlinkDetails(
      {Key key,
      @required this.flinkId,
      @required this.flinkUrl,
      @required this.flinkDescription})
      : super(key: key);

  @override
  _FlinkDetailsState createState() => _FlinkDetailsState();
}

class _FlinkDetailsState extends State<FlinkDetails> {
  final _urlTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  bool _isUrlInputFilled = false;
  bool _isDescriptionInputFilled = false;

  DatabaseService db = DatabaseService();

  void _handleSave() async {
    await db.updateFlink(widget.flinkId, _urlTextController.text,
        _descriptionTextController.text);

  }

  @override
  void initState() {
    _isUrlInputFilled = widget.flinkUrl.length > 0;
    _isDescriptionInputFilled = widget.flinkDescription.length > 0;

    //Initialize input with default text from current FLink
    _urlTextController.text = widget.flinkUrl;
    _descriptionTextController.text = widget.flinkDescription;
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _urlTextController.dispose();
    _descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(Theme.of(context).colorScheme);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0x424242),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.delete_outlined), onPressed: () {})
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  child: Column(
                children: [
                  TextFormField(
                    controller: _urlTextController,
                    onChanged: (String text) {
                      setState(() {
                        _isUrlInputFilled = text.length > 0;
                        print(_urlTextController.text != widget.flinkUrl);
                      });
                    },
                    maxLines: null,
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "URL",
                        suffixIcon: _isUrlInputFilled
                            ? IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  _urlTextController.clear();
                                  setState(() {
                                    _isUrlInputFilled = false;
                                  });
                                },
                              )
                            : Icon(null)),
                  ),
                  TextFormField(
                    controller: _descriptionTextController,
                    onChanged: (String text) {
                      setState(() {
                        _isDescriptionInputFilled = text.length > 0;
                      });
                    },
                    maxLines: null,
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Description",
                        suffixIcon: _isDescriptionInputFilled
                            ? IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  _descriptionTextController.clear();
                                  setState(() {
                                    _isDescriptionInputFilled = false;
                                  });
                                },
                              )
                            : Icon(null)),
                  ),
                ],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 8.0),
                      child: TextButton(
                          onPressed: (_isUrlInputFilled ||
                                      _isDescriptionInputFilled) &&
                                  (_urlTextController.text != widget.flinkUrl ||
                                      _descriptionTextController.text !=
                                          widget.flinkDescription)
                              ? () {
                                  _handleSave();
                                  Navigator.pop(context);
                                }
                              : null,
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                        vertical: 18.0, horizontal: 22.0)),
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled))
                                return Colors.grey;
                              return Theme.of(context)
                                  .colorScheme
                                  .secondary; // Defer to the widget's default.
                            }),
                          ),
                          child: Text('Save',
                              style: TextStyle(
                                fontSize: 18.0,
                              ))))
                ],
              )
            ],
          ),
        ));
  }
}
