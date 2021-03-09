import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LabelSelectorDialog extends StatefulWidget {
  final double deviceWidth;
  int selectedLabel;
  final Function changeLabelCallback;

  LabelSelectorDialog(
      {required this.selectedLabel,
      required this.deviceWidth,
      required this.changeLabelCallback});

  @override
  _LabelSelectorDialogState createState() => _LabelSelectorDialogState();
}

class _LabelSelectorDialogState extends State<LabelSelectorDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Note Label",
        style: TextStyle(fontSize: 20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  print("Clicked light blue");
                  widget.changeLabelCallback(0);
                  Navigator.pop(context);
                },
                child: Container(
                  height: widget.deviceWidth * 0.1,
                  width: widget.deviceWidth * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(widget.deviceWidth),
                    border: widget.selectedLabel == 0
                        ? Border.all(color: Colors.blueGrey, width: 5)
                        : null,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Clicked red");
                  widget.changeLabelCallback(1);
                  Navigator.pop(context);
                },
                child: Container(
                  height: widget.deviceWidth * 0.1,
                  width: widget.deviceWidth * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(widget.deviceWidth),
                    border: widget.selectedLabel == 1
                        ? Border.all(color: Colors.blueGrey, width: 5)
                        : null,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Clicked purple");
                  widget.changeLabelCallback(2);
                  Navigator.pop(context);
                },
                child: Container(
                  height: widget.deviceWidth * 0.1,
                  width: widget.deviceWidth * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(widget.deviceWidth),
                    border: widget.selectedLabel == 2
                        ? Border.all(color: Colors.blueGrey, width: 5)
                        : null,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  print("Clicked green");
                  widget.changeLabelCallback(3);
                  Navigator.pop(context);
                },
                child: Container(
                  height: widget.deviceWidth * 0.1,
                  width: widget.deviceWidth * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(widget.deviceWidth),
                    border: widget.selectedLabel == 3
                        ? Border.all(color: Colors.blueGrey, width: 5)
                        : null,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Clicked yellow");
                  widget.changeLabelCallback(4);
                  Navigator.pop(context);
                },
                child: Container(
                  height: widget.deviceWidth * 0.1,
                  width: widget.deviceWidth * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(widget.deviceWidth),
                    border: widget.selectedLabel == 4
                        ? Border.all(color: Colors.blueGrey, width: 5)
                        : null,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Clicked blue");
                  widget.changeLabelCallback(5);
                  Navigator.pop(context);
                },
                child: Container(
                  height: widget.deviceWidth * 0.1,
                  width: widget.deviceWidth * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(widget.deviceWidth),
                    border: widget.selectedLabel == 5
                        ? Border.all(color: Colors.blueGrey, width: 5)
                        : null,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  print("Clicked orange");
                  widget.changeLabelCallback(6);
                  Navigator.pop(context);
                },
                child: Container(
                  height: widget.deviceWidth * 0.1,
                  width: widget.deviceWidth * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(widget.deviceWidth),
                    border: widget.selectedLabel == 6
                        ? Border.all(color: Colors.blueGrey, width: 5)
                        : null,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Clicked pink");
                  widget.changeLabelCallback(7);
                  Navigator.pop(context);
                },
                child: Container(
                  height: widget.deviceWidth * 0.1,
                  width: widget.deviceWidth * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(widget.deviceWidth),
                    border: widget.selectedLabel == 7
                        ? Border.all(color: Colors.blueGrey, width: 5)
                        : null,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Clicked teal");
                  widget.changeLabelCallback(8);
                  Navigator.pop(context);
                },
                child: Container(
                  height: widget.deviceWidth * 0.1,
                  width: widget.deviceWidth * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.tealAccent,
                    borderRadius: BorderRadius.circular(widget.deviceWidth),
                    border: widget.selectedLabel == 8
                        ? Border.all(color: Colors.blueGrey, width: 5)
                        : null,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
