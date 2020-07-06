import 'package:admin/screens/house_screen.dart';
import 'package:admin/screens/score_screen.dart';
import 'package:flutter/material.dart';

import '../screens/challenge_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.confirmation_number,
                    size: 32,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.account_balance_wallet,
                    size: 32,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.home,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ScoreScreen(),
            ChallengeScreen(),
            HouseScreen(),
          ],
        ),
      ),
    );
  }
}
