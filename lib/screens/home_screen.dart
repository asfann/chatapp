import 'package:chatapp/helper.dart';
import 'package:chatapp/pages/calls_page.dart';
import 'package:chatapp/pages/contacts_page.dart';
import 'package:chatapp/pages/messages_pages.dart';
import 'package:chatapp/pages/notification_page.dart';
import 'package:chatapp/theme.dart';
import 'package:chatapp/widgets/glowing_action_button.dart';
import 'package:chatapp/widgets/icon_buttons.dart';
import 'package:chatapp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

   final ValueNotifier<int> pageIndex = ValueNotifier(0);
   final ValueNotifier<String> title = ValueNotifier('Messages');



  final  pages = [
    MessagesPage(),
    NotificationPage(),
    CallsPage(),
    ContactsPage()
  ];

  final pageTitles = const [
    'Messages',
    'Notifications',
    'Calls',
    'Contacts',
  ];


   void _onNavigationItemSelected(index) {
     title.value = pageTitles[index];
     pageIndex.value = index;
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _){
            return Text(
              value,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            );
          },
        ),
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(icon: Icons.search,
          onTap: () {
            print('TODO search');
          },),
        ),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: Avatar.small(url: Helpers.randomPictureUrl()),
        )],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }

}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key, required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {

  var selectedIndex = 0;

  void handleItemSelected(int index) {
setState(() {
  selectedIndex = index;
});
    widget.onItemSelected(index);

  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8,right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(
                index: 0,
                lable: 'Messages',
                icon: CupertinoIcons.bubble_left_bubble_right,
                isSelected:   (selectedIndex==0),
                onTap: handleItemSelected ),
              _NavigationBarItem(
                index: 1,
                lable: 'Notifications',
                icon: CupertinoIcons.bell_solid,
                isSelected:   (selectedIndex==1),
                onTap: handleItemSelected),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GlowingActionButton(color: AppColors.secondary, icon: CupertinoIcons.add, onPressed: () {

                }),
              ),
              _NavigationBarItem(
                index: 2,
                lable: 'Calls',
                icon: CupertinoIcons.phone_fill,
                isSelected:   (selectedIndex==2),
                onTap: handleItemSelected),
              _NavigationBarItem(
                index: 3,
                lable: 'Contacts',
                icon: CupertinoIcons.person_2_fill,
                isSelected:   (selectedIndex==3),
                onTap: handleItemSelected),
            ],
          ),
        ),
      ),
    );
  }
}


class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    Key? key,
    required this.lable,
    required this.icon,
    required this.index,
    required this.onTap,
    this.isSelected = false
  }) : super(key: key);


  final ValueChanged<int> onTap;
  final int index;
  final String lable;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
              size: 20,
            color:  isSelected ? AppColors.secondary : null,),
            SizedBox(
              height: 8,
            ),
            Text(lable,style: isSelected ?
            const TextStyle(fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary): const TextStyle(fontSize: 11,)),
          ],
        ),
      ),
    );
  }
}

