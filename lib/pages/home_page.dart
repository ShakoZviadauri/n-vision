import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:n_vision/widgets/widget_menu_news_feed.dart';
import 'package:n_vision/widgets/widget_menu_messenger.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


IconData getIconData(String menuItem) {
  if (menuItem == 'News Feed') {
    return FontAwesomeIcons.newspaper;
  } else if (menuItem == 'Messenger') {
    return FontAwesomeIcons.facebookMessenger;
  } else if (menuItem == 'Marketplace') {
    return FontAwesomeIcons.shop;
  }else if(menuItem == 'Videos'){
    return FontAwesomeIcons.play;
  }
  return Icons.error;
}

class LeftMenuList extends StatelessWidget {
  final bool isActive;
  final Function()? onPressed;
  final String title;
  final IconData iconData;

  const LeftMenuList({
    Key? key,
    required this.isActive,
    required this.onPressed,
    required this.title,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextButton(
      style: isActive ? StyleMenuButtons.menuButtonStyle(1) : StyleMenuButtons.menuButtonStyle(null),
      onPressed: onPressed, 
      child: Container(
        width: MediaQuery.of(context).size.height,
        height: 60,
        decoration: isActive ? StyleMenuButtons.menuLeftBorder(1) : StyleMenuButtons.menuLeftBorder(null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 65,),
            RotatedBox(
              quarterTurns: 0,
              child: Icon(
                iconData,
                color: HexColor('3B579D'),
                size: 20,
              ),
            ),

            const SizedBox(width: 25,),
            Text(
              title,
              style: TextStyle(
                color: HexColor('000000'),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: "Ubuntu-Regular",
              ),
            )
          ],
        ),
      ),
    );

  }
}




class _MyHomePageState extends State<MyHomePage> {

  Map<String, bool> menuStates = {
    'News Feed': true,
    'Messenger': false,
    'Marketplace': false,
    'Videos': false,
  };

  void toggleMenuState(String menuItem) {
    setState(() {
      menuStates.update(menuItem, (value) => !value);
    });
  }

  // load default widget page
  Widget displayedWidget = getWidgetForMenuItem('News Feed');


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 350,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: HexColor('d7dee3'),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  
                  const SizedBox(height: 100,),
                  // User profile small info
                  UserProfileSmallInfo(),

                  const SizedBox(height: 70,),
                  
                  // Left menu list
                  Column(
                    children: menuStates.keys.map((String menuItem) {
                      return LeftMenuList(
                        isActive: menuStates[menuItem]!,
                        onPressed: () {
                          setState(() {
                            menuStates.updateAll((key, value) => value = false);
                            menuStates[menuItem] = true;
                            displayedWidget = getWidgetForMenuItem(menuItem);
                          });
                          print('$menuItem clicked');
                        },
                        title: menuItem,
                        iconData: getIconData(menuItem),
                      );
                    }).toList(),
                  ),

                  leftMeuBottomList(context),
                  const SizedBox(height: 100,),
                  // Log out widget
                  logOutWidget(),
                  const SizedBox(height: 50,),
                ],
              ),
            ),
          ),



          Container(
            width: MediaQuery.of(context).size.width - 350,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // import widget
                displayedWidget,
                
              
              ],
            ),
          ),

        ],
      ),
    );
  }


}

Widget getWidgetForMenuItem(String menuItem) {
  Widget widget = Container(); // You can use any default widget or Container()
  if (menuItem == 'News Feed') {
    widget = WidgetForMenuNewsFeed();
  } else if (menuItem == 'Messenger') {
    widget = WidgetForMenuMessenger();
  }else{
    widget = Container(
      padding: const EdgeInsets.only(top: 100),
      child: const Center(
        child: Text(
          'Page Not Found',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "Ubuntu-Regular",
          ),
        ),
      ),
    );
  }
  return widget;
}





// class WidgetForMenuMessenger extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text('Widget for Menu Item 2'),
//       // Add your widget's content and styling here
//     );
//   }
// }




// user small info widget
class UserProfileSmallInfo extends StatelessWidget {
  
  Widget build(BuildContext context){
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        SizedBox(
          width: 50.0,
          height: 50.0, 
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox.fromSize(
              size: const Size.fromRadius(8),
              child: Image.asset(
                'assets/images/user_image.jpg', 
                fit: BoxFit.fill,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20,),
        const Text(
          'Shako Zviadauri',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "Ubuntu-Regular",
          ),
        ),
        const SizedBox(width: 20,),
        const Icon(
          Icons.circle_outlined,
          color: Colors.green,
          size: 15,
        ),
      ],
    ),
  );
  }
}

// return Column(
//       children: [
//             const SizedBox(height: 100,),
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 50.0,
//                     height: 50.0, 
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: SizedBox.fromSize(
//                         size: const Size.fromRadius(8),
//                         child: Image.asset(
//                           'assets/images/user_image.jpg', 
//                           fit: BoxFit.fill,
//                           alignment: Alignment.center,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 20,),
//                   const Text(
//                     'Shako Zviadauri',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: "Ubuntu-Regular",
//                     ),
//                   ),
//                   const SizedBox(width: 20,),
//                   const Icon(
//                     Icons.circle_outlined,
//                     color: Colors.green,
//                     size: 15,
//                   ),
//                 ],
//               ),
//             ),
//       ],
//     );




Widget leftMeuBottomList(BuildContext context){
  
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
      color: Colors.transparent,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
  
        const SizedBox(height: 75,),

        // shortcuts block
        Container(
          padding: const EdgeInsets.only(left: 72),
          child: Text(
            'SHORTCUTS',
            style: TextStyle(
              color: HexColor('B6B9BD'),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: "Ubuntu-Regular",
            ),
          ),
        ),

        const SizedBox(height: 20,),


        // Dribbble menu item
        TextButton(
          style: StyleMenuButtons.menuButtonStyle(null),
          onPressed: () {
            print('Dribbble');
          }, 
          child: Container(
            width: MediaQuery.of(context).size.height,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 72,),
                Icon(
                  FontAwesomeIcons.dribbble,
                  color: HexColor('A0A3A7'),
                  size: 20,
                ),
                const SizedBox(width: 25,),
                Text(
                  'Dribbble TH',
                  style: TextStyle(
                      color: HexColor('000000'),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Ubuntu-Regular",
                    ),
                ),
              ],
            ),
          ),
        ),

        // Figma menu item
        TextButton(
          style: StyleMenuButtons.menuButtonStyle(null),
          onPressed: () {
            print('Figma');
          }, 
          child: Container(
            width: MediaQuery.of(context).size.height,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 72,),
                Icon(
                  FontAwesomeIcons.figma,
                  color: HexColor('A0A3A7'),
                  size: 20,
                ),
                const SizedBox(width: 25,),
                Text(
                  'Figma Community',
                  style: TextStyle(
                    color: HexColor('000000'),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Ubuntu-Regular",
                  ),
                ),
              ],
            ),
          ),
        ),


        const SizedBox(height: 20,),

        Center(
          child: Container(
            width: 200,
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                backgroundColor: MaterialStatePropertyAll<Color>(HexColor('EBEDF1')),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    // side: BorderSide(color: Colors.red)
                  )
                ),
              ),
              onPressed: () {
                print('Add Shortcut');
              },  
              child: Text(
                'Add Shortcut',
                style: TextStyle(
                  color: HexColor('3B579D'),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Ubuntu-Regular",
                ),
              )
            ),
          ),
        ),


      ],
    ),
  );
}


Widget logOutWidget(){
  return Container(
    width: 150,
    child: TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
        backgroundColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            side: BorderSide(color: Color.fromARGB(255, 196, 196, 196))
          )
        ),
      ),
      onPressed: () {
        print('Log Out');
      }, 
      child: Text(
        'Log Out',
        style: TextStyle(
          color: HexColor('8E8E8E'),
          fontSize: 13,
          fontWeight: FontWeight.w600,
          fontFamily: "Ubuntu-Regular",
          height: 1
        ),
      )
    ),
  );
}




class StyleMenuButtons {

  static BoxDecoration menuLeftBorder(toggle){
    if(toggle == 1){
      return BoxDecoration(
        border: Border(
          left: BorderSide(width: 5.0, color: HexColor('3B579D'),),
        ),
      );
    }else{
      return const BoxDecoration(
        border: Border(
          left: BorderSide(width: 5.0, color: Colors.transparent),
        ),
      );
    }
  }

  static ButtonStyle menuButtonStyle(toggle) {
    if(toggle == 1){
      return TextButton.styleFrom(
        backgroundColor: HexColor('E4E9ED'),
        foregroundColor: Colors.blue,
        animationDuration: const Duration(milliseconds: 10),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.zero),
        ),
      );
    }else{
      return TextButton.styleFrom(
        foregroundColor: Colors.blue,
        animationDuration: const Duration(milliseconds: 10),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.zero),
        ),
      );
    }
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