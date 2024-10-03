import 'package:contactapp/Cubit/contact_cubit.dart';
import 'package:contactapp/widgets/contactcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {

     

    return BlocBuilder<ContactCubit, ContactState>(
            builder: (context, state) {

   var favcontacts = ContactCubit.get(context)
            .contacts
            .where((contact) => contact['favorite'] == 'Favourite')
            .toList();
              if (favcontacts.isEmpty) {
                return const Center(child: Text("No contacts found"));
              }

              return ListView.builder(
                itemCount: favcontacts.length,
                itemBuilder: (context, index) {
                  return Contactcard( list: favcontacts, index: index,);
                },
              );
            },
          );
  }
}