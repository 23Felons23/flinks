import 'package:flink_app/src/services/db.dart';
import 'package:flutter/material.dart';

class FlinkForm extends StatefulWidget {
  @override
  _FlinkFormState createState() => _FlinkFormState();
}

class _FlinkFormState extends State<FlinkForm> {
  //final _titleTextController = TextEditingController();

  final _linkTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  bool _isLinkInputFilled = false;
  bool _isDescriptionInputFilled = false;

  DatabaseService db = DatabaseService();
  void _handleSave() async {
    await db.addFlink(_linkTextController.text, _descriptionTextController.text);
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    //_titleTextController.dispose();
    _linkTextController.dispose();
    _descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      padding: new EdgeInsets.fromLTRB(30.0, 45.0, 30.0, 5.0),
      child: Column(children: [
        /**TextField(
          controller: _titleTextController,
          decoration:
              InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
        ),
        SizedBox(height: 20.0),**/
        TextField(
          controller: _linkTextController,
          onChanged: (String text) {
            setState(() {
              _isLinkInputFilled = text.length > 0;
            });
          },
          decoration:
              InputDecoration(labelText: 'URL', border: OutlineInputBorder()),
        ),

        SizedBox(height: 20.0),

        TextField(
          controller: _descriptionTextController,
          onChanged: (String text) {
            setState(() {
              _isDescriptionInputFilled = text.length > 0;
            });
          },
          decoration: InputDecoration(
              labelText: 'Description', border: OutlineInputBorder()),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                margin: EdgeInsets.only(top: 5.0),
                child: TextButton(
                    onPressed: _isLinkInputFilled || _isDescriptionInputFilled
                        ? () {
                            _handleSave();
                          }
                        : null,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 20.0)),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
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
      ]),
    );
  }
}
