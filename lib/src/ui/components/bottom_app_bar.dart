import 'package:flutter/material.dart';

class FlinkBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Colors.black26,
      child: IconTheme(
        data: IconThemeData(color: Theme
            .of(context)
            .colorScheme
            .onPrimary),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Open navigation menu',
              icon: const Icon(Icons.menu),
            ),
            Spacer(),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}

