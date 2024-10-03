
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/contact_cubit.dart';
import '../widgets/contactcard.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              ContactCubit.get(context).updateSearchQuery(value);
            },
            decoration: const InputDecoration(
              labelText: 'Search By Name',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: BlocBuilder<ContactCubit, ContactState>(
            builder: (context, state) {
              var contacts = ContactCubit.get(context).contacts;

              if (state is GetDataError) {
                return const Center(child: Text("Error fetching contacts"));
              }

              if (contacts.isEmpty) {
                return const Center(child: Text("No contacts found"));
              }

              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(contacts[index]['id'].toString()),
                    onDismissed: (direction) {
                      ContactCubit.get(context)
                          .deleteContact(contacts[index]['id']);
                    },
                    direction: DismissDirection.horizontal,
                    child: Contactcard(list: contacts, index: index),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
