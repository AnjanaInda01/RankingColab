import 'package:flutter/material.dart';

class LeaderBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Leaderboard"),
            Text("1st: 500pt"),
            Text("2nd: 400pt"),
            Text("3rd: 300pt"),
          ],
        ),
      ),
    );
  }
}
