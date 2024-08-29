import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_class/Post_API/post_api_services.dart';

class Platzi extends StatefulWidget {
  const Platzi({super.key});

  @override
  State<Platzi> createState() => _PlatziState();
}

class _PlatziState extends State<Platzi> {
  TextEditingController _mobileController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  bool isready=false;
  dynamic datalogin;


  getloginuser(){
    isready=true;
    post_api_services().plazilogin(_mobileController.text, _passwordController.text).then((value) {
      setState(() {
        isready=false;
        datalogin=value;
        print("Response => ${datalogin}");
      });
    },).onError((error, stackTrace) {
      debugPrint("Error Found: ${error.toString()}");
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
                  TextInput.finishAutofillContext();
                  await getloginuser();
                  AnimatedSnackBar.material(
                    'Login Succesfull !',
                    type: AnimatedSnackBarType.success,
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom
                  ).show(context);
                },
                child:isready==true? Center(child: CircularProgressIndicator()): Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
