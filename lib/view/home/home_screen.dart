import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wac_task/database_helper/db_helper.dart';
import 'package:wac_task/main.dart';
import 'package:wac_task/models/user_model.dart';
import 'package:wac_task/services/api_services.dart';
import 'package:wac_task/view/details/employee_details_screen.dart';
import 'package:wac_task/widgets/custom_image.dart';

import '../../controller/user_data_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserDataController>(context, listen: false).getAllUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Consumer<UserDataController>(builder: (context, p, c) {
          return SizedBox(
            width: w,
            height: 40,
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  onChanged: p.search,
                  onFieldSubmitted: p.search,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      hintText: "Search employees name or email",
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ))
              ],
            ),
          );
        }),
      ),
      body: Consumer<UserDataController>(builder: (context, p, c) {
        if (p.isLoading) {
          return SizedBox(
            height: h,
            width: w,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return SizedBox(
          height: h,
          width: w,
          child: p.usersList.isEmpty
              ? const Center(
                  child: Text("No user data to show"),
                )
              : ListView.separated(
                  itemCount:
                      p.isSearching ? p.searchList.length : p.usersList.length,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, i) {
                    return const Divider(
                      height: 0,
                    );
                  },
                  itemBuilder: (context, i) {
                    UserModel user =
                        p.isSearching ? p.searchList[i] : p.usersList[i];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (_) => EmployeeDetailsScreen(
                                      data: user,
                                    )));
                      },
                      isThreeLine: true,
                      subtitle: Text(user.company?.name ?? ""),
                      leading: CustomImage(
                        url: user.profileImage ?? "",
                      ),
                      title: Text(user.name ?? ""),
                    );
                  }),
        );
      }),
    );
  }
}
