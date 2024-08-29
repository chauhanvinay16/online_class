import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:online_class/List_API/quets.dart';
import 'package:online_class/Post_API/login_modal.dart';
import 'package:online_class/Post_API/post_api_services.dart';


class Loginpost extends StatefulWidget {
  const Loginpost({super.key});

  @override
  State<Loginpost> createState() => _LoginpostState();
}

class _LoginpostState extends State<Loginpost> {

  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontrller=TextEditingController();

  loginmodal Loginmodal=loginmodal();
  bool isready=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Loginmodal.token==null || Loginmodal.token==""?
            const Text('login screen'): Text('${Loginmodal.token}'),
      ),
      body:  Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        labelText: 'Enter Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: passwordcontrller,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Enter Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isready=false;
                        });
                        post_api_services().loginmodaldata(emailcontroller.text.toString(), passwordcontrller.text.toString()).then((value) {
                          setState(() {
                            Loginmodal = value!;
                            print('***********API HIT************$Loginmodal');
                            AnimatedSnackBar.material(
                              'Login successful',
                              type: AnimatedSnackBarType.success,
                              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                            ).show(context);
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuetData(),));
                          });
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                        child: isready==true ? Center(child: CircularProgressIndicator(color: Colors.red,)):
                        Text('Login', style: TextStyle(fontSize: 18,color: Colors.white)),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ), backgroundColor: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



