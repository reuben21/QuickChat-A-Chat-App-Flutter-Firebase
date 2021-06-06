import 'package:bubble/bubble.dart';
import '../../colors.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
    this.message,
    this.id,
    this.username,
    this.imageUrl,
    this.isMe,
  );

  final int id;
  final String message;
  final String username;
  final String imageUrl;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    if (id == 1) {
      return Container(
        margin: EdgeInsets.all(10),
        child: Bubble(
          alignment: Alignment.center,
          color: kPrimaryColorAccent,
          child: Text('${username} Created This Chat',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0, color: kPrimaryColor)),
        ),
      );
    }
    if (id == 2) {
      return Container(
        margin: EdgeInsets.all(10),
        child: Bubble(
          alignment: Alignment.center,
          color: kPrimaryColorAccent,
          child: Text('${username} ${message}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0, color: kPrimaryColor)),
        ),
      );
    }
    if (id == 5) {
      return Bubble(
        margin: isMe
            ? BubbleEdges.only(top: 10, left: 40)
            : BubbleEdges.only(top: 10, right: 40),
        alignment: isMe ? Alignment.topRight : Alignment.topLeft,
        nip: isMe ? BubbleNip.rightTop : BubbleNip.leftTop,
        color: isMe ? senderMessageColor : receiverMessageColor,
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
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
      );
    }
    if (id == 6) {
      return Bubble(

        margin: isMe
            ? BubbleEdges.only(top: 10, left: 40)
            : BubbleEdges.only(top: 10, right: 40),
        alignment: isMe ? Alignment.topRight : Alignment.topLeft,
        nip: isMe ? BubbleNip.rightTop : BubbleNip.leftTop,
        color: isMe ? senderMessageColor : receiverMessageColor,
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
             Container(
                width: 200,
                  height:200,
                  decoration: BoxDecoration(
                    color: kPrimaryColorAccent,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return DetailScreen(imageUrl);
                      }));
                    },
                    child:  Hero(
                      tag: 'imageHero',
                    child: FadeInImage(
                        placeholder: AssetImage('assets/images/NoImageFound.png'),
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
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
      );
    }
    return Bubble(
      margin: isMe
          ? BubbleEdges.only(top: 10, left: 40)
          : BubbleEdges.only(top: 10, right: 40),
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      nip: isMe ? BubbleNip.rightTop : BubbleNip.leftTop,
      color: isMe ? senderMessageColor : receiverMessageColor,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
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
    );
    // Flex(
    //   direction: Axis.horizontal,
    //   mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
    //   children: <Widget>[
    //     Container(
    //       constraints: BoxConstraints(
    //         maxWidth: MediaQuery.of(context).size.width * 0.7,
    //       ),
    //       decoration: BoxDecoration(
    //         color: isMe ? senderMessageColor : receiverMessageColor,
    //         borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(12),
    //           topRight: Radius.circular(12),
    //           bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
    //           bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
    //         ),
    //       ),
    //       width: 140,
    //       padding: EdgeInsets.symmetric(
    //         vertical: 10,
    //         horizontal: 16,
    //       ),
    //       margin: EdgeInsets.symmetric(
    //         vertical: 4,
    //         horizontal: 8,
    //       ),
    //       child: Column(
    //         crossAxisAlignment:
    //             isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    //         children: [
    //
    //           Text(
    //             message,
    //             style: isMe
    //                 ? Theme.of(context).textTheme.bodyText1
    //                 : Theme.of(context).textTheme.bodyText2,
    //             textAlign: isMe ? TextAlign.end : TextAlign.start,
    //           ),
    //            Text(username,
    //                   style: Theme.of(context).textTheme.headline5)
    //
    //
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}


class DetailScreen extends StatelessWidget {



  final String imageUrl;


  DetailScreen(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
                imageUrl
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}