import 'package:flutter/material.dart';

class ErrorDialog {

  static void show(

      BuildContext context,

      String message,

      ){

    showDialog(

      context: context,

      builder:(_){

        return AlertDialog(

          title: const Text("Oops"),

          content: Text(message),

          actions:[

            TextButton(

              onPressed:(){

                Navigator.pop(context);

              },

              child: const Text("OK"),

            ),

          ],

        );

      },

    );

  }

}