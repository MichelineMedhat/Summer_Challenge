import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summer_challenge/blocs/post_bloc/bloc.dart';
import 'package:summer_challenge/models/post.dart';
import 'package:summer_challenge/screens/home_page.dart';
import 'package:summer_challenge/screens/houses_page.dart';
import 'package:summer_challenge/screens/profile_page.dart';
import 'package:summer_challenge/widgets/post_dialog.dart';

import '../blocs/post_bloc/post_bloc.dart';
import '../blocs/authentication_bloc/bloc.dart';
import '../models/user.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  static PageController pageController;

  const HomeScreen({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController statusEditingController;
  TextEditingController hashtagEditingController;
  String extenstion;
  Uint8List data;
  PostBloc postBloc;
  @override
  void initState() {
    super.initState();
    HomeScreen.pageController = new PageController(initialPage: 0);
    statusEditingController = new TextEditingController();
    hashtagEditingController = new TextEditingController();
    postBloc = BlocProvider.of<PostBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              HomeScreen.pageController.animateToPage(1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutBack);
            },
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              HomeScreen.pageController.animateToPage(0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutBack);
            },
          )
        ],
      ),
      body: PageView(
        controller: HomeScreen.pageController,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        pageSnapping: false,
        children: [
          HousesPage(user: widget.user),
          ProfilePage(user: widget.user),
          HomePage(user: widget.user),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).bottomAppBarColor,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).iconTheme.color,
                  size: 28,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.open_in_new,
                  color: Theme.of(context).iconTheme.color,
                  size: 28,
                ),
                onPressed: () {
                  HomeScreen.pageController.animateToPage(2,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOutBack);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryIconTheme.color,
          size: 28,
        ),
        onPressed: _showMyDialog,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void dispose() {
    HomeScreen.pageController.dispose();
    super.dispose();
  }

  Future<void> _showMyDialog() {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return PostDialog(
            onPressed: () {
            hashtagEditingController = PostDialog.hashtagEditingController;
            statusEditingController = PostDialog.statusEditingController;
              Post post = Post(
                  status: statusEditingController.text,
                  hashtag: statusEditingController.text,
                  username: widget.user.username,
                  timestamp: Timestamp.now());

              postBloc.add(AddPost(
                  post: post,
                  image: PostDialog.data,
                  extenstion: PostDialog.extenstion));
              Navigator.of(context).pop();
            },
          );
        });
  }
}
