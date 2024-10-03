
import 'package:contactapp/Cubit/contact_cubit.dart';
import 'package:flutter/material.dart';

class Contactcard extends StatelessWidget {
 final int index;
   const Contactcard({
    super.key,
    required this.list,
    required this.index,
  });

  final List<Map> list;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        title: Text(list[index]['name'],
            style: const TextStyle(fontSize: 22)),
        subtitle: Text(list[index]['number'],
            style: const TextStyle(fontSize: 20)),
        trailing: IconButton(
          icon: list[index]['favorite'] == 'Favourite'
              ? const Icon(Icons.favorite, color: Colors.red)
              : const Icon(Icons.favorite_border),
          onPressed: () {
            ContactCubit.get(context).changefaveorite(
                list[index]['id'],
                list[index]['favorite']);
          },
        ),
      ),
    );
  }
}
