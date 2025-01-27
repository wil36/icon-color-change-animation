import 'package:flutter/material.dart';
import 'package:animate_to/animate_to.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _animateToController = AnimateToController();
  final List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
  ];
  Color targetColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimateTo<Color>(
              controller: _animateToController,
              child: Icon(
                Icons.folder,
                size: 200,
                color: targetColor,
              ),
              onArrival: (color) {
                setState(() {
                  targetColor = color;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 5; i++)
                  InkWell(
                    borderRadius: BorderRadius.circular(40),
                    onTap: () {
                      _animateToController.animateTag(i,
                          curve: Curves.ease,
                          duration: Duration(milliseconds: 600));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        // color: color,
                        border: Border.all(
                          color: targetColor != _colors[i]
                              ? Colors.transparent
                              : _colors[i],
                        ),
                      ),
                      child: AnimateFrom<Color>(
                        value: _colors[i],
                        key: _animateToController.tag(i),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: _colors[i],
                          ),
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            )
            // ListView.builder(
            //   shrinkWrap: true,
            //   scrollDirection: Axis.horizontal,
            //   itemCount: _colors.length,
            //   itemBuilder: (context, index) {
            //     return AnimateFrom(
            //       key: GlobalKey(debugLabel: _colors[index].toString()),
            //       child: Container(
            //         width: 50,
            //         height: 50,
            //         color: _colors[index],
            //       ),
            //     );
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
