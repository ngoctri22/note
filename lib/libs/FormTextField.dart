import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget {
  final String? value;
  final ValueChanged? onChanged;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final String? hintText;
  final InputDecoration? decoration;

  const FormTextField({Key? key,this.value, this.onChanged, this.minLines, this.maxLines, this.decoration, this.maxLength, this.hintText}) : super(key: key);

  @override
  _FormTextFieldState createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  TextEditingController? _controller;

  String? value;

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    value = widget.value??'';
    _controller = TextEditingController(text: widget.value ?? '');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormTextField oldWidget) {
    if(widget.value != value && !(widget.value == null && value == '')) {
      _controller!.text = widget.value ?? '';
      value = widget.value??'';
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return  TextField(
      maxLength:widget.maxLength,
      minLines: widget.minLines,
      maxLines: widget.maxLines??1,
      controller: _controller,
      onChanged: (val){
        value = val;
        if(widget.onChanged != null){
          widget.onChanged!(val);
        }
      },
      decoration:widget.decoration??  InputDecoration(
          border: const OutlineInputBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
                color: Color(0xFFCCCCCC), width: 1),
          ),
          hintText: widget.hintText??'Nhập'),
    );
  }
}
