import 'package:contactapp/widgets/addnew.dart';
import 'package:flutter/material.dart';
import '../Cubit/contact_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController numbercontroller = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ContactCubit contactcubit = ContactCubit.get(context);
    return SafeArea(
      child: BlocBuilder<ContactCubit, ContactState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: contactcubit.newscreen
                    ? const Text(
                        "Favourites",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      )
                    : const Text(
                        "Contacts",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
              ),
              floatingActionButton: contactcubit.favscreen
                  ? null
                  : FloatingActionButton(
                      backgroundColor: Colors.white,
                      elevation: 5,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Addnewcontact(formkey: formkey, namecontroller: namecontroller, numbercontroller: numbercontroller, contactcubit: contactcubit);
                            });
                      },
                      child: const Icon(Icons.add),
                    ),
              body: contactcubit.listscreens[contactcubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.contacts), label: "Contacts"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "Favourite"),
                ],
                currentIndex: contactcubit.currentIndex,
                onTap: (index) {
                  contactcubit.changeindex(index);
                },
              ));
        },
      ),
    );
  }
}
