import 'package:admin/blocs/post_bloc/bloc.dart';
import 'package:admin/blocs/post_bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/post.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  const PostWidget({Key key, this.post}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  TextEditingController scoreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(1.2, 2.4),
            color: Colors.black12,
            blurRadius: .64,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: scoreController,
              onFieldSubmitted: (_) => BlocProvider.of<PostBloc>(context).add(
                  AddScore(
                      username: widget.post.username,
                      score: double.parse(scoreController.text),
                      post: widget.post)),
            ),
          ),
          Container(
            child: widget.post.uri != null
                ? Image.network(
                    widget.post.uri,
                    fit: BoxFit.contain,
                    cacheWidth: 512,
                  )
                : Container(),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            widget.post.status,
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white70,
                radius: MediaQuery.of(context).size.width > 567 ? 30 : 24,
                backgroundImage: widget.post.userProfilePicture != null
                    ? NetworkImage(
                        widget.post.userProfilePicture,
                      )
                    : AssetImage("assets/pp.png"),
              ),
              SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@${widget.post.username}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4),
                  widget.post.hashtag.isNotEmpty
                      ? Container(
                          child: Text(
                            '#${widget.post.hashtag}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
