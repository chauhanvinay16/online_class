import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:online_class/create_post_API/api_services_post.dart';

class XhLogin extends StatefulWidget {
  const XhLogin({super.key});

  @override
  State<XhLogin> createState() => _XhLoginState();
}

class _XhLoginState extends State<XhLogin> {
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();

  final deviceToken = '12345678910';
  final deviceType = '1';
  dynamic  lgdata;
  bool isready=false;

  _xhlogin(){
    isready=true;
    Apiservicescreate().LoginAPI(_mobileController.text,_passwordController.text, deviceToken, deviceType).then((value) {
      lgdata=value;
      isready=false;
      AnimatedSnackBar.material(
        'Login successful',
        type: AnimatedSnackBarType.success,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      ).show(context);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Login Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mobile Number'),
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(
                hintText: 'Enter your mobile number',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Password'),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _xhlogin();
                },
                child:isready==true? CircularProgressIndicator(): Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
