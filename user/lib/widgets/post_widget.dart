import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summer_challenge/blocs/authentication_bloc/authentication_state.dart';
import 'package:summer_challenge/blocs/authentication_bloc/bloc.dart';
import 'package:summer_challenge/blocs/post_bloc/bloc.dart';

import '../models/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Color(0xff2B2A28),
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
          Container(
            child: post.uri != null
                ? Image.network(
                    post.uri,
                    fit: BoxFit.contain,
                    cacheWidth: 512,
                  )
                : Container(),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            post.status,
            style: TextStyle(fontSize: 14, color: Colors.white),
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
                backgroundImage: post.userProfilePicture != null
                    ? NetworkImage(
                        post.userProfilePicture,
                      )
                    : AssetImage("assets/pp.png"),
              ),
              SizedBox(width: 14),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '@${post.username}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 4),
                    post.hashtag.isNotEmpty
                        ? Container(
                            child: Text(
                              '#${post.hashtag}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              post.username ==
                      (BlocProvider.of<AuthenticationBloc>(context).state
                              as Authenticated)
                          .user
                          .username
                  ? IconButton(
                      icon: Icon(Icons.delete_forever),
                      color: Colors.orange,
                      onPressed: () => BlocProvider.of<PostBloc>(context).add(
                            DeletePost(post: post),
                          ))
                  : Container()
            ],
          )
        ],
      ),
    );
  }
}
