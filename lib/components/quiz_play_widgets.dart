import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;
  final bool quizSubmitStatus;

  OptionTile(
      {this.description,
      this.correctAnswer,
      this.option,
      this.optionSelected,
      this.quizSubmitStatus});

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: Text(
              '(${widget.option})',
              style: TextStyle(
                fontSize: 17,
                color: widget.quizSubmitStatus
                    ? widget.optionSelected == widget.description
                        ? widget.description == widget.correctAnswer
                            ? Colors.green.withOpacity(0.7)
                            : Colors.red
                        : Colors.black54
                    : widget.optionSelected == widget.description
                        ? Colors.blue[400]
                        : Colors.black54,
              ),
            ),
            title: Text(
              widget.description,
              style: TextStyle(
                fontSize: 19,
                color: widget.quizSubmitStatus
                    ? widget.optionSelected == widget.description
                        ? widget.description == widget.correctAnswer
                            ? Colors.green.withOpacity(0.7)
                            : Colors.red
                        : Colors.black54
                    : widget.optionSelected == widget.description
                        ? Colors.blue[400]
                        : Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
