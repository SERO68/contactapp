import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../UI/contacts.dart';
import '../UI/favscreen.dart';
import 'dart:developer';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial()) {
    createDatabase();
  }

  static ContactCubit get(context) => BlocProvider.of(context);

  final List<Widget> listscreens = [
    const ContactsScreen(),
    const FavouriteScreen(),
  ];

  int currentIndex = 0;
  bool newscreen = true;
  bool favscreen = false;

  void changeindex(int newindex) {
    currentIndex = newindex;
    newscreen = !newscreen;
    favscreen = !favscreen;
    emit(ChangeIndex());
  }

  List<Map> contacts = [];

  late Database database;

  createDatabase() async {
    database = await openDatabase(
      'contacts.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE contacts (id INTEGER PRIMARY KEY, name TEXT, number TEXT, favorite TEXT)',
        );
      },
    );
    emit(Databasecreate());
    await getdata();
  }

  getdata() async {
    try {
      contacts.clear();
      contacts.clear();

      List<Map<String, dynamic>> data =
          await database.rawQuery('SELECT * FROM contacts');

      for (Map<String, dynamic> element in data) {
        contacts.add(element); 
      }

      emit(GetDataSuccess());
    } catch (e) {
      emit(GetDataError());
    }

    emit(GetDataSuccess());
  }

  addContact({required String name, required String number}) async {
    try {
      log(database.path);
      await database.transaction((txn) async {
        await txn.rawInsert(
          'INSERT INTO contacts(name, number, favorite) VALUES(?, ?, ?)',
          [name, number, 'NotFavourite'],
        );
        log('name: $name, number: $number');
      });
      log('Contact inserted');
      await getdata();
    } catch (e) {
      emit(AddContactError());
    }
  }

  changefaveorite(int id, String currentFavorite) async {
    try {
      String newStatus =
          currentFavorite == 'Favourite' ? 'NotFavourite' : 'Favourite';
      await database.rawUpdate(
        'UPDATE contacts SET favorite = ? WHERE id = ?',
        [newStatus, id],
      );
      log('Favorite status updated');
      await getdata();
    } catch (e) {
      emit(ChangeFavoriteError());
    }
  }

  updateSearchQuery(String query) async {
    try {
      contacts.clear();

      List<Map<String, dynamic>> data = await database.rawQuery(
        'SELECT * FROM contacts WHERE name LIKE ?',
        ['%$query%'],
      );

      for (Map<String, dynamic> element in data) {
        contacts.add(element);
      }

      emit(UpdateSearchQuerySuccess());
    } catch (e) {
      emit(UpdateSearchQueryError());
    }
  }

 deleteContact(int id) async {
    try {
      await database.rawDelete('DELETE FROM contacts WHERE id = ?', [id]);
      log('Contact deleted');
      await getdata();
    } catch (e) {
      emit(DeleteContactError());
    }
  }
}
