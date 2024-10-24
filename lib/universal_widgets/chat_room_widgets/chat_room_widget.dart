
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/request_display_widgets/consulting_request_display_widget.dart';
import 'package:qadiroon_front_end/universal_widgets/service_display_widgets/consulting_display_widget.dart';

class ChatRoomScreen extends StatefulWidget
{
  ChatRoomScreen({required this.data});
  final requestDisplayWidgetRecord data;
  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen>
{

  Future<void> sendNewMessage(TextEditingController controller) async
  {
    controller.clear();
    await FirebaseFirestore.instance.collection('ServiceRequest').doc(widget.data.requestData.id).collection('Chat')
    .doc()
    .set
    (
      {
        'contentType' : messageType.toString(),
        'content' : (messageType == contentType.text)? messageText : imageURL,
        'senderID' : FirebaseAuth.instance.currentUser!.uid,
        'timeStamp' : DateTime.now()
      } 
    );
    if(widget.data.benData.id == FirebaseAuth.instance.currentUser!.uid)
    {
      await sendTestRequest(widget.data.serviceProviderData.id,
"""
${widget.data.benData.data()!['Name']} 
""",
        messageText
      );
    }
    else
    {
      await sendTestRequest(widget.data.serviceProviderData.id,
"""
${widget.data.serviceData.data()!['Name']} 
""",
        messageText
      );
    }
  }

  String messageText = "";
  String imageURL = "";
  contentType messageType = contentType.text;
  TextEditingController CupertinoTextFieldController = TextEditingController();

  Widget build(BuildContext context)
  {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold
    (
      appBar: CupertinoNavigationBar
      (
        
      ),
      backgroundColor: Color(0xFF2B448C),
      body: Center
      (
        child: Column
        (
          children:
          [
            Flexible
            (
              fit: FlexFit.loose,
              flex: 100,
              // decoration: BoxDecoration
              // (
              //   color: Color(0xFF2B448C),
              //   image: DecorationImage(image: AssetImage("assets/images/logo.png"), repeat: ImageRepeat.repeat, opacity: 0.125)
              // ),
              // height: height * 0.8,
              // width: width * 1,
              child: Card
              (
                elevation: 16,
                margin: EdgeInsets.all(4),
                color: Colors.black12,
                shadowColor: Colors.purple,
                child: StreamBuilder
                (
                  stream: FirebaseFirestore.instance
                  .collection('ServiceRequest')
                  .doc(widget.data.requestData.id)
                  .collection('Chat')
                  .orderBy('timeStamp', descending: true)
                  .snapshots(),
                  builder: (context, snapshot)
                  {
                    if(!snapshot.hasData) return CircularProgressIndicator();
                
                    final messages = snapshot.data!.docs.map((e) => e.data()).toList();
                
                    return ListView.builder
                    (
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index)
                      {
                        var message = messages[index];
                        var senderData = message['senderID'] == widget.data.benData.id? widget.data.benData: widget.data.serviceProviderData;
                        if (message['contentType'] == contentType.text.toString()) {
                          return Card
                          (
                            elevation: 10,
                            color: Colors.white60,
                            margin: EdgeInsets.all(4),
                            child: ListTile
                            (
                            dense: false,
                            leading: FutureBuilder(future: FirebaseStorage.instance.ref("${senderData.id}/public/pfp.jpg").getDownloadURL(),
                            builder: (context, snapshot)
                            {
                              if(!snapshot.hasData) return CircularProgressIndicator();
                              return CircleAvatar(backgroundImage: NetworkImage(snapshot.data!),);
                            },
                            ),
                            isThreeLine: true,
                            title: Text((message['senderID'] == widget.data.benData.id?
                            widget.data.benData.data()!['Name']
                            :
                            widget.data.serviceProviderData.data()!['Name']
                            )),
                            subtitle: Text(message['content'], textAlign: TextAlign.right,),
                            ),
                          );
                        } else {
                          return FadeInImage
                        (
                          image: NetworkImage(message['content']),
                          placeholder: AssetImage("assets/images/logo.png"),
                          fadeInDuration: Duration(seconds: 1),
                        );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            Spacer(),
            Row
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                SizedBox
                (
                  width: width * 0.85,
                  child: CupertinoTextField
                  (
                    controller: CupertinoTextFieldController,
                    onChanged: (value) {messageText = value;},
                    minLines: 1,
                    maxLines: 100,
                    autofocus: true,
                    style: TextStyle
                    (
                      fontFamily: "Tajawal",
                    ),
                  ),
                ),
                SizedBox
                (
                  width: width * 0.075,
                  child: ElevatedButton
                  (
                    onPressed: () async {await sendNewMessage(CupertinoTextFieldController);},
                    child: Icon(Icons.send, size: 10),
                  ),
                ),
                SizedBox
                (
                  width: width * 0.075,
                  child: ElevatedButton
                  (
                    onPressed: (){},
                    child: Icon(Icons.photo, size: 8),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}