import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/flink.dart';

class FlinkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Flink> userFlinkList = Provider.of<List<Flink>>(context);

    return Expanded(
        child: ListView.separated(
            itemCount: userFlinkList.length,

            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                  title: Text(
                      userFlinkList[i].url != ''
                          ? userFlinkList[i].url
                          : userFlinkList[i].description,
                      style: TextStyle(fontSize: 18.0)),

                  subtitle: (userFlinkList[i].description == '') ||
                          (userFlinkList[i].description != '' &&
                              userFlinkList[i].url == '')
                      ? null
                      : Container(
                          margin: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            userFlinkList[i].description,
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ));
            },

            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            }
        )
    );
  }
}
