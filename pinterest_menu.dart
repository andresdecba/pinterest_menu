import 'package:flutter/material.dart';

/*
1- CREATE A SCROLL CONTROLLER::
ScrollController scrollController = ScrollController();

2- SET THE MENU AS A FLOATING ACTION BUTTON OR INSE A STACK::
floatingActionButton: PinterestMenu(
  scrollController: scrollController,
  color: Colors.blueGrey, // optional
  selectedColor: Colors.red, // optional
  items: [
    PinterestButton(onPress: () {}, icon: Icons.pie_chart),
    PinterestButton(onPress: () {}, icon: Icons.search),
    PinterestButton(onPress: () {}, icon: Icons.notifications),
    PinterestButton(onPress: () {}, icon: Icons.supervised_user_circle),
  ],
),
floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
*/

class PinterestButton {
  final Function onPress;
  final IconData icon;

  PinterestButton({
    required this.onPress,
    required this.icon,
  });
}

class PinterestMenu extends StatefulWidget {
  const PinterestMenu({
    required this.items,
    required this.scrollController,
    this.selectedColor = Colors.red,
    this.color = Colors.blueGrey,
    Key? key,
  }) : super(key: key);

  final List<PinterestButton> items;
  final ScrollController scrollController;
  final Color selectedColor;
  final Color color;


  @override
  State<PinterestMenu> createState() => _PinterestMenuState();
}

class _PinterestMenuState extends State<PinterestMenu> {
  //
  ////////// fields
  double scrollAnterior = 0.0;
  bool mostrar = true;
  int index = 0;

  ////////// init and close controller
  @override
  void initState() {
    widget.scrollController.addListener(() {
      if (widget.scrollController.offset > scrollAnterior && widget.scrollController.offset > 150) {
        mostrar = false;
      } else {
        mostrar = true;
      }
      scrollAnterior = widget.scrollController.offset;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: mostrar ? 1 : 0,
      duration: const Duration(milliseconds: 300),

      ////////// menu background //////////
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black45,
              blurRadius: 10,
              spreadRadius: -5,
            ),
          ],
        ),

        ////////// icons //////////
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: widget.items
              .map(
                (e) => IconButton(
                  onPressed: () {
                    setState(() {
                      index = widget.items.indexOf(e);
                      e.onPress();
                    });
                  },
                  icon: Icon(e.icon),
                  alignment: Alignment.center,
                  iconSize: (index == widget.items.indexOf(e)) ? 40 : 30,
                  color: (index == widget.items.indexOf(e)) ? widget.selectedColor : widget.color,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
