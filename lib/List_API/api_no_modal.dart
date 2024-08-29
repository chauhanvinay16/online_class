
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:online_class/List_API/api_servicess.dart';

class UserProfileCard extends StatefulWidget {
  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  bool isLoading = true; // Indicates if data is loading
  List<dynamic>? userdata; // List to hold fetched user data

  // Function to fetch user data
  void _fetchUserData() {
    ApiServicess().getprofiledata().then((value) {
      setState(() {
        isLoading = false;
        userdata = value; // Assign fetched data to userdata
        print('************API HIT************** $userdata');
      });
    }).catchError((error) {
      print('Error fetching user data: $error');
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Initiate data fetching when widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CustomCircularProgressIndicator()) // Show loading indicator if data is loading
        : Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        itemCount: userdata!.length.compareTo(0),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 60, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      child: Text(userdata![index]['userId'].toString()),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              userdata![index]['email'].toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            ),
                          ],
                        ),
                        Text(
                          userdata![index]['username'].toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      children: [
                        Text('Bio: '),
                        Text(
                          userdata![index]['bio'].toString(),
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('Location: '),
                                Text(userdata![index]['location'].toString()),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Followers: '),
                                Text(userdata![index]['followersCount'].toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text('Following: '),
                                Text(userdata![index]['followingCount'].toString())
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      children: [
                        Text('Hobby: '),
                        Text(userdata![index]['hobbies'].toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Education: '),
                        Text(userdata![index]['education'].toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Work: '),
                        Text(userdata![index]['work'].toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Relationship Status: '),
                        Text(userdata![index]['relationshipStatus'].toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Gender: '),
                        Text(userdata![index]['gender'].toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Languages: '),
                        Text(userdata![index]['languages'].toString()),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Full Name: '),
                    Text(userdata![index]['fullName'].toString()),
                  ],
                ),
                Row(
                  children: [
                    Text('Joined: '),
                    Text(userdata![index]['joinedDate'].toString()),
                  ],
                ),
                Row(
                  children: [
                    Text('Last Active: '),
                    Text(userdata![index]['lastActive'].toString()),
                  ],
                ),
                Row(
                  children: [
                    Text('Status: '),
                    Text(userdata![index]['statusMessage'].toString()),
                  ],
                ),
                Row(
                  children: [
                    Text('Phone: '),
                    Text(userdata![index]['contactInfo']['phone'].toString()),
                  ],
                ),
                Row(
                  children: [
                    Text('Secondary Email: '),
                    Text(userdata![index]['contactInfo']['secondaryEmail'].toString()),
                  ],
                ),
                Row(
                  children: [
                    Text('Custom Name: '),
                    Text(userdata![index]['customFields'][0]['fieldName'].toString()),
                  ],
                ),
                Row(
                  children: [
                    Text('Custom Value: '),
                    Text(userdata![index]['customFields'][0]['fieldValue'].toString()),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CustomCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          LoadingAnimationWidget.flickr(size: 60, leftDotColor: Colors.red, rightDotColor: Colors.blue)
        ],
      ),
    );
  }
}
