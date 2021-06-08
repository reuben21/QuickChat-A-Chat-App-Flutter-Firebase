
import 'package:flutter/cupertino.dart';
import '../../colors.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.id, this.username, this.imageUrl, this.isMe,
      this.index);

  final int id;
  final String message;
  final String username;
  final String imageUrl;
  final bool isMe;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (id == 10) {
      return Column( mainAxisSize: MainAxisSize.min,

        children: [
          Container(

            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
                color: kPrimaryColorAccent,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text('${username} Entered This Chat',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0, color: kPrimaryColor)),
            ),
        ],
      );
    }
    if (id == 1) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
                color: kPrimaryColorAccent,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text('${username} Created This Chat',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0, color: kPrimaryColor)),
            ),
        ],
      );
    }
    if (id == 2) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
                color: kPrimaryColorAccent,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text('${username} ${message}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0, color: kPrimaryColor)),
            ),
        ],
      );
    }
    if (id == 5) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin:isMe ? EdgeInsets.only(right: 5,top: 5,bottom: 5):EdgeInsets.only(left: 5,top: 5,bottom: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: isMe ? senderMessageColor : receiverMessageColor,
                borderRadius: isMe? BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)) : BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))
            ),
            child: Column(
              crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Text(
                    message,
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                    style: isMe
                        ? Theme.of(context).textTheme.bodyText1
                        : Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Text(
                  username,
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: isMe ? TextAlign.end : TextAlign.start,
                )
              ],
            ),
          ),
        ],
      );
    }
    if (id == 6) {
      return Column(
        mainAxisSize: MainAxisSize.min,

        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin:isMe ? EdgeInsets.only(right: 5,top: 5,bottom: 5):EdgeInsets.only(left: 5,top: 5,bottom: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: isMe ? senderMessageColor : receiverMessageColor,
                borderRadius: isMe? BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)) : BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 200,

                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return DetailScreen(index, imageUrl);
                      }));
                    },
                    child: Hero(
                      tag: index.toString(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: FadeInImage(
                          placeholder: NetworkImage(
                              'https://media.giphy.com/media/3oEjI6SIIHBdRxXI40/giphy.gif'),
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  message,
                  textAlign: isMe ? TextAlign.end : TextAlign.start,
                  style: isMe
                      ? Theme.of(context).textTheme.bodyText1
                      : Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  username,
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: isMe ? TextAlign.end : TextAlign.start,
                )
              ],
            ),
          ),
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin:isMe ? EdgeInsets.only(right: 5,top: 5,bottom: 5):EdgeInsets.only(left: 5,top: 5,bottom: 5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: isMe ? senderMessageColor : receiverMessageColor,
              borderRadius: isMe? BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)) : BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))
          ),
          child: Column(
            crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Text(
                  message,
                  textAlign: isMe ? TextAlign.end : TextAlign.start,
                  style: isMe
                      ? Theme.of(context).textTheme.bodyText1
                      : Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Text(
                username,
                style: Theme.of(context).textTheme.headline5,
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class DetailScreen extends StatelessWidget {
  final int index;
  final String imageUrl;

  DetailScreen(this.index, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: index.toString(),
            child: Image.network(imageUrl),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
