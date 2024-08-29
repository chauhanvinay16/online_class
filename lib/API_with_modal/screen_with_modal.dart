import 'package:flutter/material.dart';
import 'package:online_class/API_with_modal/api_services.dart';
import 'package:online_class/API_with_modal/single_post_modal.dart';



class ScreenWithModel extends StatefulWidget {
  const ScreenWithModel({Key? key}) : super(key: key);

  @override
  State<ScreenWithModel> createState() => _ScreenWithModelState();
}

class _ScreenWithModelState extends State<ScreenWithModel> {
  bool isReady = false;
  singlepostmodal singlePostWithModel = singlepostmodal();

  _getSinglePost() {
    setState(() {
      isReady = true;
    });
    Apiservices().getsinglePostwithModal().then((value) {
      setState(() {
        singlePostWithModel = value!;
        isReady = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getSinglePost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Post With Model"),
      ),
      body: isReady
          ? const Center(child: CircularProgressIndicator())
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            singlePostWithModel.userId.toString(),
            style: const TextStyle(fontSize: 20, color: Colors.blue),
          ),
          Text(
            singlePostWithModel.title.toString(),
            style: const TextStyle(fontSize: 18, color: Colors.redAccent),
          ),
          Text(
            singlePostWithModel.body.toString(),
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
