import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Statusinfo extends StatelessWidget {
  final data;
  final title;
  final important;
  Statusinfo(this.title, this.data, this.important);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 2.5, color: Colors.grey.shade300))),
      margin: EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(bottom: 15),
              alignment: Alignment.center,
              child: Text(
                title + " :",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(bottom: 15),
              alignment: Alignment.center,
              child: Text(
                data.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    color: (important ? Colors.green.shade400 : Colors.red.shade400)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
