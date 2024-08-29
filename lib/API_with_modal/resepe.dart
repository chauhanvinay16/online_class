// import 'package:flutter/material.dart';
// import 'package:http_clear_architecture/models/resepe_modal.dart';
// import 'package:http_clear_architecture/network_manager/rest_client.dart';
//
// class ResepeScreen extends StatefulWidget {
//   const ResepeScreen({super.key});
//
//   @override
//   State<ResepeScreen> createState() => _ResepeScreenState();
// }
//
// class _ResepeScreenState extends State<ResepeScreen> {
//   bool isLoading = true;
//   List<ResepeModal> resepe = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _getresepe();
//   }
//
//   _getresepe() {
//     RestClient.getresepe().then((value) {
//       setState(() {
//         resepe = value;
//         isLoading = false;
//       });
//     }).catchError((error) {
//       print("Error==>${error.toString()}");
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Resepe'),
//       ),
//       body: isLoading
//           ? Center(
//         child: CircularProgressIndicator(),
//       )
//           : ListView.builder(
//         itemCount: resepe.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(resepe[index].title),
//             subtitle: Text(resepe[index].description),
//           );
//         },
//       ),
//     );
//   }
// }
