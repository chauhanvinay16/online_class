import 'package:flutter/material.dart';
import 'package:online_class/API/chek_api.dart';
import 'package:online_class/API/hit_api.dart';
import 'package:online_class/API/login.dart';
import 'package:online_class/API_with_modal/create_product.dart';
import 'package:online_class/API_with_modal/emp_single_api.dart';
import 'package:online_class/API_with_modal/product_get.dart';
import 'package:online_class/API_with_modal/screen_with_modal.dart';
import 'package:online_class/API_with_modal/single_move.dart';
import 'package:online_class/List_API/api_no_modal.dart';
import 'package:online_class/List_API/api_without_modal.dart';
import 'package:online_class/List_API/movi_modal_api.dart';
import 'package:online_class/List_API/quets.dart';
import 'package:online_class/Post_API/img_upload.dart';
import 'package:online_class/Post_API/lpost_login.dart';
import 'package:online_class/Post_API/niraj_post.dart';
import 'package:online_class/Post_API/register.dart';
import 'package:online_class/Post_API/test.dart';
import 'package:online_class/Post_API/xh_login.dart';
import 'package:online_class/create_post_API/home_screen.dart';
import 'package:online_class/practic/hit.dart';
import 'package:online_class/share_pref/to_do/add_note.dart';
import 'package:online_class/sqflite/DB_handler.dart';
import 'package:online_class/sqflite/home.dart';
import 'package:online_class/sqflite/note_detail.dart';
import 'package:online_class/sqflite/note_list.dart';
import 'package:online_class/ui_componat/logger.dart';
import 'package:online_class/ui_componat/newton_effect.dart';
import 'package:online_class/ui_componat/ripple_effect.dart';
import 'package:online_class/ui_componat/simer_effect.dart';
import 'package:online_class/ui_componat/vibrant.dart';

import 'API_with_modal/api_without_modal.dart';
import 'API_with_modal/get_user.dart';
import 'List_API/data_with_modal.dart';
import 'Post_API/platzi_login.dart';
import 'filter_array/home.dart';
import 'filter_array/product_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AddNoteScreen(),
    );
  }
}


