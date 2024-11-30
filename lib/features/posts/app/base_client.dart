import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BaseClient {
  final client =  http.Client();
   Future<dynamic> post({String url="",dynamic payload}) async{
     try {
       final response = await client.post(Uri.parse(url),body: jsonEncode(payload),
           headers: {
             'Content-type': 'application/json',
           }
       );
       print("status${response.statusCode}");
       if(response.statusCode == 201) {
         print("yes");
         return response.body;
       }
       else {
         throw Exception('Failed to create post');
       }
     }
     catch(e) {
       debugPrint(e.toString());
     }
   }
}