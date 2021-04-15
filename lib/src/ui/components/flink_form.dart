import 'package:flink_app/src/services/db.dart';
import 'package:flutter/material.dart';

class FlinkForm extends StatefulWidget {
  @override
  _FlinkFormState createState() => _FlinkFormState();
}

class _FlinkFormState extends State<FlinkForm> {
  //final _titleTextController = TextEditingController();

  final _urlTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  bool _isUrlInputFilled = false;
  bool _isDescriptionInputFilled = false;

  DatabaseService db = DatabaseService();

  void _handleSave() async {
    await db.addFlink(_urlTextController.text, _descriptionTextController.text);
    _urlTextController.clear();
    _descriptionTextController.clear();
    setState(() {
      _isUrlInputFilled = false;
      _isDescriptionInputFilled = false;
    });
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    //_titleTextController.dispose();
    _urlTextController.dispose();
    _descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      padding: new EdgeInsets.fromLTRB(25.0, 15.0, 5.0, 0.0),
      child: Column(children: [
        /**TextField(
            controller: _titleTextController,
            decoration:
            InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20.0),**/
        TextField(
          controller: _urlTextController,
          maxLines: null,
          onChanged: (String text) {
            setState(() {
              _isUrlInputFilled = text.length > 0;
            });
          },
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 15.0),
              labelText: 'URL',
              border: InputBorder.none,
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
        TextField(
          controller: _descriptionTextController,
          maxLines: null,
          onChanged: (String text) {
            setState(() {
              _isDescriptionInputFilled = text.length > 0;
            });
          },
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              labelText: 'Description',
              border: InputBorder.none,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                child: TextButton(
                    onPressed: _isUrlInputFilled || _isDescriptionInputFilled
                        ? () {
                            _handleSave();
                          }
                        : null,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 18.0)),
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
