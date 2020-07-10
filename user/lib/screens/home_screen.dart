import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:summer_challenge/screens/profile_page.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../blocs/post_bloc/bloc.dart';
import '../blocs/post_bloc/post_bloc.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../screens/challenges_page.dart';
import '../screens/home_page.dart';
import '../screens/houses_page.dart';
import '../screens/scores_page.dart';
import '../widgets/post_dialog.dart';

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
        backgroundColor: Colors.orange,
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
              HomeScreen.pageController.animateToPage(4,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn);
            },
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.addressCard, color: Colors.white),
            onPressed: () {
              HomeScreen.pageController.animateToPage(1,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn);
            },
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              HomeScreen.pageController.animateToPage(0,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn);
            },
          )
        ],
      ),
      body: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostNotUploaded) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: PageView(
          controller: HomeScreen.pageController,
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HousesPage(),
            HomePage(user: widget.user),
            ScoresPage(),
            ChallengesPage(),
            ProfilePage(user: widget.user)
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black87,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.dumbbell,
                  color: Colors.orange,
                ),
                onPressed: () {
                  HomeScreen.pageController.animateToPage(3,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.fastOutSlowIn);
                },
              ),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.trophy,
                  color: Colors.orange,
                ),
                onPressed: () {
                  HomeScreen.pageController.animateToPage(2,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.fastOutSlowIn);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
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
                  hashtag: hashtagEditingController.text,
                  username: widget.user.username,
                  userProfilePicture: widget.user.profilePicture,
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
