import 'package:flutter/material.dart';
import 'package:frifri/src/feature/application/root_app/presentation/widgets/app.dart';

class WhereToWhere extends StatefulWidget {
  const WhereToWhere({super.key});

  @override
  State<WhereToWhere> createState() => _WhereToWhereState();
}

class _WhereToWhereState extends State<WhereToWhere> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Куда летим?"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.06),
        child: Column(
          children: [
              
          ],
        ),
      ),
    );
  }
}
