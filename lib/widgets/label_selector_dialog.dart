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
              ColoredLabelWidget(
                callbackFunction: widget.changeLabelCallback,
                labelCallbackIndex: 0,
                labelColor: Colors.lightBlueAccent,
                showBorder: widget.selectedLabel == 0 ? true : false,
              ),
              ColoredLabelWidget(
                callbackFunction: widget.changeLabelCallback,
                labelCallbackIndex: 1,
                labelColor: Colors.redAccent,
                showBorder: widget.selectedLabel == 1 ? true : false,
              ),
              ColoredLabelWidget(
                callbackFunction: widget.changeLabelCallback,
                labelCallbackIndex: 2,
                labelColor: Colors.purpleAccent,
                showBorder: widget.selectedLabel == 2 ? true : false,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ColoredLabelWidget(
                callbackFunction: widget.changeLabelCallback,
                labelCallbackIndex: 3,
                labelColor: Colors.greenAccent,
                showBorder: widget.selectedLabel == 3 ? true : false,
              ),
              ColoredLabelWidget(
                callbackFunction: widget.changeLabelCallback,
                labelCallbackIndex: 4,
                labelColor: Colors.yellowAccent,
                showBorder: widget.selectedLabel == 4 ? true : false,
              ),
              ColoredLabelWidget(
                callbackFunction: widget.changeLabelCallback,
                labelCallbackIndex: 5,
                labelColor: Colors.blueAccent,
                showBorder: widget.selectedLabel == 5 ? true : false,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ColoredLabelWidget(
                callbackFunction: widget.changeLabelCallback,
                labelCallbackIndex: 6,
                labelColor: Colors.orangeAccent,
                showBorder: widget.selectedLabel == 6 ? true : false,
              ),
              ColoredLabelWidget(
                callbackFunction: widget.changeLabelCallback,
                labelCallbackIndex: 7,
                labelColor: Colors.pinkAccent,
                showBorder: widget.selectedLabel == 7 ? true : false,
              ),
              ColoredLabelWidget(
                callbackFunction: widget.changeLabelCallback,
                labelCallbackIndex: 8,
                labelColor: Colors.tealAccent,
                showBorder: widget.selectedLabel == 8 ? true : false,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ColoredLabelWidget extends StatelessWidget {
  final Function callbackFunction;
  final Color labelColor;
  final int labelCallbackIndex;
  final bool showBorder;

  const ColoredLabelWidget(
      {required this.labelColor,
      required this.labelCallbackIndex,
      required this.callbackFunction,
      required this.showBorder});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        print("Clicked ${this.labelColor.toString()}");
        callbackFunction(labelCallbackIndex);
        // widget.changeLabelCallback(0);
        Navigator.pop(context);
      },
      child: Container(
        height: width * 0.1,
        width: width * 0.1,
        decoration: BoxDecoration(
            color: this.labelColor,
            borderRadius: BorderRadius.circular(width),
            border: this.showBorder
                ? Border.all(color: Colors.blueGrey, width: 5)
                : null),
      ),
    );
  }
}
