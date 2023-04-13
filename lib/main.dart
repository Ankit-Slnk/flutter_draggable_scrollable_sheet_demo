import 'package:bottom_sheet/utility/appAssets.dart';
import 'package:bottom_sheet/utility/utility.dart';
import 'package:flutter/material.dart';

// flutter 3.3.0

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double extent = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: body(),
    );
  }

  Widget body() {
    return Stack(
      children: [
        Utility.imageLoader(
          "https://picsum.photos/200/300",
          AppAssets.placeHolder,
        ),
        SizedBox.expand(
          child: NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              if (mounted)
                setState(() {
                  extent = notification.extent;
                });
            },
            child: DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.6,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(extent == 1.0 ? 0 : 16),
                      topRight: Radius.circular(extent == 1.0 ? 0 : 16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.black45,
                        offset: Offset(-1, -1),
                      )
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Visibility(
                        visible: extent != 1.0,
                        child: Container(
                          margin: EdgeInsets.only(top: 8),
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: 25,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(title: Text('Item $index'));
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
