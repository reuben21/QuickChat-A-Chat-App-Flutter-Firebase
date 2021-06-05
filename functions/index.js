const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
exports.myNewFunction = functions.firestore.document('/chats/{cid}/{did}/{message}')
    .onCreate((snapshot, context) => {
      return admin.messaging().sendToTopic('chats',{
      notification: {
        title:snapshot.data().username,
        body:snapshot.data().text,
        clickAction:'FLUTTER_NOTIFICATION_CLICK'

      }

      })
    });