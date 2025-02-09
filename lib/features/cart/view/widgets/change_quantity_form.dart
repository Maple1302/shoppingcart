import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/features/cart/bloc/cart_event.dart';

import '../../../../core/color.dart';
import '../../../../core/text_style.dart';
import '../../../../data/models/cart_item.dart';

class ChangeQuantityForm extends StatefulWidget {
  final CartItem item;
  final VoidCallback onSubmit;
  final TextEditingController quantityController;

  const ChangeQuantityForm(
      {super.key,
      required this.item,
      required this.onSubmit,
      required this.quantityController});

  @override
  State<ChangeQuantityForm> createState() => _ChangeQuantityFormState();
}

class _ChangeQuantityFormState extends State<ChangeQuantityForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.quantityController.text = widget.item.quantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: AlertDialog(
          title: Text(
            widget.item.product.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: TextFormField(
            validator: validateQuantityField,
            onChanged: (value) => _validateForm(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: AppTextStyle.productNameTextStyle,
            controller: widget.quantityController,
            textAlign: TextAlign.center,
            cursorColor: ColorManager.yellow,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: ColorManager.yellow, width: 2),
                    borderRadius: BorderRadius.circular(8)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: ColorManager.yellow, width: 2),
                    borderRadius: BorderRadius.circular(8)),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(8)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(8))),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () {
                        widget.onSubmit();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bo góc 20
                  ),
                ),
                child: Text(
                  "Submit",
                  style: AppTextStyle.buttonTextStyle.copyWith(fontSize: 18),
                ),
              ),
            )
          ],
        ));
  }

  String? validateQuantityField(String? text) {
    if (text != null && text.isNotEmpty) {
      return int.parse(text) > 999 ? "Quantity not excced 999" : null;
    } else if (text == null || text.isEmpty) {
      return "Quantity not empty";
    }
    return null;
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _formKey.currentState?.validate() ?? false;
    });
  }
}
