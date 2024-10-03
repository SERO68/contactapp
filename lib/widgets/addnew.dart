import 'package:contactapp/Cubit/contact_cubit.dart';
import 'package:contactapp/widgets/formfield.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class Addnewcontact extends StatefulWidget {
  const Addnewcontact({
    super.key,
    required this.formkey,
    required this.namecontroller,
    required this.numbercontroller,
    required this.contactcubit,
  });

  final GlobalKey<FormState> formkey;
  final TextEditingController namecontroller;
  final TextEditingController numbercontroller;
  final ContactCubit contactcubit;

  @override
  State<Addnewcontact> createState() => _AddnewcontactState();
}

class _AddnewcontactState extends State<Addnewcontact> {
    String countryCodenum = '+20';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text(
          "Add Contact",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          height: 200,
          width: 350,
          child: SingleChildScrollView(
            child: Form(
              key: widget.formkey,
              child: Column(
                children: [
                  Formfield(
                    namecontroller: widget.namecontroller,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 3) {
                        return "Enter valid Name";
                      }
                      return null;
                    },
                    hinttext: 'Name',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [ CountryCodePicker(
                      onChanged: (countryCode) {
                        setState(() {
                          countryCodenum = countryCode.dialCode ?? '+20';
                        });
                      },
                      initialSelection: 'EG',
                      favorite: const ['+20', 'EG'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                    ),
                      Expanded(
                        child: Formfield(
                          namecontroller: widget.numbercontroller,
                          hinttext: 'Number',
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return "Enter valid Number";
                            }
                        
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            if (widget.formkey.currentState!.validate()) {
                          String fullNumber = '$countryCodenum ${widget.numbercontroller.text.trim()}';
                          widget.contactcubit.addContact(
                            name: widget.namecontroller.text.trim(),
                            number: fullNumber,
                          );

                              widget.namecontroller.clear();
                              widget.numbercontroller.clear();
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            widget.namecontroller.clear();
                            widget.numbercontroller.clear();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
