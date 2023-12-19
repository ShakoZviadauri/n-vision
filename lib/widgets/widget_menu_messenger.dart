import 'package:flutter/material.dart';

class WidgetForMenuMessenger extends StatefulWidget {
  const WidgetForMenuMessenger({super.key});

  @override
  _WidgetForMenuMessengerState createState() => _WidgetForMenuMessengerState();
}


class _WidgetForMenuMessengerState extends State<WidgetForMenuMessenger> {

  // @overrides
  Widget buildFixedSection(context) {
    return Container(
      width: MediaQuery.of(context).size.width - 700,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(
                    color: Colors.red,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                  child: Text(
                    '45',
                    style: TextStyle(
                      color: HexColor('ffffff'),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Ubuntu-Regular",
                    ),
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Messenger'.toUpperCase(),
                    style: TextStyle(
                      color: HexColor('A5A5A5'),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Ubuntu-Regular",
                    ),
                  ),
                  Text(
                    'Recent',
                    style: TextStyle(
                      color: HexColor('000000'),
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Ubuntu-Regular",
                    ),
                  ),
                ],
              ),
            ],
          ),


        ],
      ),
    );
  }


  

  Widget buildScrollableContent(context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(right: BorderSide(color: Color.fromARGB(67, 144, 144, 144), width: 1)),
        ),
        padding: const EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 20),
        width: MediaQuery.of(context).size.width - 700,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('data'),
          SizedBox(height: 20), // Example space, replace with your widget
          SizedBox(height: 3000,),
          Text('data'),
        ],
      ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      width: MediaQuery.of(context).size.width - 350,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Colors.white, //back background fill
        // border: Border.all(color: Colors.grey), // Optional: Add borders
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fixed section at the top
          buildFixedSection(context),
          // Scrollable content
          Expanded(
            child: buildScrollableContent(context),
          ),
        ],
      ),
    );
  }


  
}










class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}