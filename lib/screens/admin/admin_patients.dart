import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminPatients extends StatefulWidget {
  const AdminPatients({Key? key}) : super(key: key);

  @override
  State<AdminPatients> createState() => _AdminPatientsState();
}

class _AdminPatientsState extends State<AdminPatients> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Text("1"),
          title: Text("K Vishal Varma"),
          subtitle: Text("Account Status: Active"),
          trailing: IconButton(
            icon: Icon(FontAwesomeIcons.ban, color: Colors.red,),
            onPressed: (){},
          ),
        )
      ],
    );
  }
}
