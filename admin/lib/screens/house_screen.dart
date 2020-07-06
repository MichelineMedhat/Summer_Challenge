import 'package:admin/blocs/house_bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HouseScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HouseScreenState();
}

class _HouseScreenState extends State<HouseScreen> {
  HouseBloc houseBloc;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    houseBloc = BlocProvider.of<HouseBloc>(context)..add(LoadHouses());
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                'Houses',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
