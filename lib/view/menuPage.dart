import 'package:dongne/view/mainPage.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  int _selectIndex = 0;

  List _widgetOptions = [MainPage()];

  void _onBackKey() {
    if (_selectIndex == 0) {
      showDialog(
        //Dialog를 제외한 다른 화면 터치불가
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Text("정말 나가시려구요?",style: TextStyle(fontSize: 16),),
              actions: [
                TextButton(
                  child: Text("아니오", style: TextStyle(color: Colors.black87),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(

                  child: Text("나가기"),
                  style: ElevatedButton.styleFrom(primary: Colors.deepOrangeAccent, shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  )),

                  onPressed: () {
                    Navigator.pop(context);

                  },
                )
              ],
            );
          });
    } else {
      setState(() {
        _selectIndex = 0;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBackKey();
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.black54.withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          currentIndex: _selectIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.search),label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle),label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.textsms),label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: "")
          ],
          onTap: (index) {
            setState(() {
              _selectIndex = index;
            });
          },
        ),
        body: _widgetOptions.elementAt(_selectIndex),
      ),
    );
  }
}
