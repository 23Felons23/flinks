import 'package:flink_app/src/ui/screens/flink_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                      ),
                onTap: userFlinkList[i].url != ''
                    ? () {
                        Clipboard.setData(
                            ClipboardData(text: userFlinkList[i].url));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('✓  Copied to clipboard'),
                        ));
                      }
                    : null,
                onLongPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FlinkDetails(
                                flinkId: userFlinkList[i].id,
                                flinkUrl: userFlinkList[i].url,
                                flinkDescription: userFlinkList[i].description,
                              )));
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            }));
  }
}
