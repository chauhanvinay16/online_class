import 'package:flutter/material.dart';
import 'package:online_class/List_API/api_servicess.dart';

class QuetData extends StatefulWidget {
  const QuetData({super.key});

  @override
  State<QuetData> createState() => _QuetDataState();
}

class _QuetDataState extends State<QuetData> {
  bool isReady = false;
  List<dynamic>? quotesList;
  dynamic tot;

  _fetchQuotesData() {
    setState(() {
      isReady = true;
    });

    ApiServicess().getquetdata().then((value) {
      setState(() {
        quotesList = value['quotes'];
        tot=value;
        isReady = false;
        print('****************API HIT**************\n$quotesList');
      });
    }).onError((error, stackTrace) {
      print(error);
      setState(() {
        isReady = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchQuotesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes Data'),
      ),
      body: isReady
          ? Center(child: CircularProgressIndicator())
          : quotesList == null
          ? Center(child: Text('Failed to load quotes'))
          : ListView.builder(
        itemCount: quotesList!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Text(
                    quotesList![index]['id'].toString(),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  quotesList![index]['quote'].toString(),
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                subtitle: Text(
                  '- ' + quotesList![index]['author'].toString(),
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                ),
                trailing: Icon(Icons.format_quote, color: Colors.blueAccent),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                onTap: () {
                  // Add your onTap function here
                },
              ),
            ),
          );

        },
      ),
    );
  }
}
