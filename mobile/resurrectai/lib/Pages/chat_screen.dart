import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resurrectai/Pages/profile_screen.dart';
import 'package:resurrectai/services/APIservice.dart';
import '../routes.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String personality;

  List<Map<String, dynamic>> messages = [];
  List<Map<String, String>> messages_data_for_prediction = [];

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  final ApiService _apiService =
      ApiService("https://amazingly-happy-hamster.ngrok-free.app");

  void _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    personality = ModalRoute.of(context)!.settings.arguments as String;
    load_chats();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  Future<void> get_response(String message) async {
    try {
      final response = await _apiService.predict(
          _messageController.text, messages_data_for_prediction);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Interactions')
          .doc(personality)
          .collection('Chats')
          .doc(Timestamp.now().toString())
          .set({
        'send': message,
        'recieve': response,
      });
      setState(() {
        load_chats();
      });
    } catch (e) {
      print('Error fetching response: $e');
    }
  }

  Future<void> load_chats() async {
    try {
      List<Map<String, dynamic>> messages_fetched = [];
      List<Map<String, String>> messages_data = [];
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Interactions')
          .doc(personality)
          .collection('Chats')
          .get();
      for (int i = querySnapshot.docs.length - 1; i >= 0; i--) {
        try {
          var message = querySnapshot.docs[i].data() as Map<String, dynamic>;
          if (message.isNotEmpty) {
            Map<String, dynamic> send = {};
            Map<String, dynamic> recieve = {};
            send['message'] = message['send'];
            send['isMe'] = true;
            recieve['message'] = message['recieve'];
            recieve['isMe'] = false;
            messages_fetched.add(recieve);
            messages_fetched.add(send);
            messages_data.add({'role': 'user', 'content': message['send']});
            messages_data
                .add({'role': 'assistant', 'content': message['recieve']});
          }
        } catch (e) {
          print('Error fetching chats: $e');
        }
      }
      setState(() {
        messages = messages_fetched.reversed.toList();
        messages_data_for_prediction = messages_data;
      });
    } catch (e) {
      print('Error fetching documents: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.h,
        title: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProfileScreen(
                personality: personality,
              );
            }));
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: AssetImage('assets/images/$personality.jpg'),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(personality,
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.bold)),
                  Text(
                    'Online',
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey[400]),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.callscreen,
                  arguments: personality);
            },
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.bottomCenter,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  if (messages[index]['message'] == '') {
                    return const SizedBox();
                  } else {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: messages[index]['isMe']
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          messages[index]['isMe']
                              ? const SizedBox()
                              : CircleAvatar(
                                  radius: 20.r,
                                  backgroundImage: AssetImage(
                                      'assets/images/$personality.jpg'),
                                ),
                          const SizedBox(width: 10),
                          Container(
                            width: 200.w,
                            alignment: messages[index]['isMe']
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: messages[index]['isMe']
                                  ? Colors.blue[100]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Text(messages[index]['message']),
                          ),
                          const SizedBox(width: 10),
                          messages[index]['isMe']
                              ? CircleAvatar(
                                  radius: 20.r,
                                  backgroundImage: const AssetImage(
                                      'assets/images/homeuserimage.png'),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    );
                  }
                },
              ),
            )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.attach_file),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.grey[200],
                      ),
                      height: 40.h,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                              hintText: 'Type a message',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      get_response(_messageController.text);
                      _messageController.clear();
                    },
                    icon: const Icon(Icons.send_rounded),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mic_outlined),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
