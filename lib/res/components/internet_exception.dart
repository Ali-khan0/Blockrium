import 'package:flutter/material.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({super.key, required this.onpress});

  final VoidCallback onpress;
  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Genre Exception"),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: widget.onpress, child: Text("Retry"))
        ],
      ),
    );
  }
}
