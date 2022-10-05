import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wac_task/models/user_model.dart';
import 'package:wac_task/widgets/custom_image.dart';

import '../../widgets/info_row_widget.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  UserModel data;

  EmployeeDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Details of ${data.name}"),
      ),
      body: SizedBox(
        height: h,
        width: w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              CustomImage(
                url: data.profileImage ?? "",
                width: w * .35,
                height: w * .35,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                data.name ?? "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              if (data.username != null)
                const SizedBox(
                  height: 4,
                ),
              if (data.username != null) Text("( ${data.username} )"),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: w,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contact Info",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Divider(),
                          InfoRowWidget(
                              icon: Icons.mail_outline_outlined,
                              info: data.email ?? "",
                              color: Colors.red),
                          InfoRowWidget(
                              icon: Icons.phone,
                              info: data.phone ?? "",
                              color: Colors.teal),
                          InfoRowWidget(
                              icon: Icons.link_outlined,
                              info: data.website ?? "",
                              color: Colors.blue),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Address Details",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const Divider(),
                          InfoRowWidget(
                              icon: Icons.location_city_outlined,
                              info: data.address?.street ?? "",
                              color: Colors.brown),
                          InfoRowWidget(
                              icon: Icons.location_history_sharp,
                              info: data.address?.suite ?? "",
                              color: Colors.cyan),
                          InfoRowWidget(
                              icon: Icons.location_city_rounded,
                              info: data.address?.city ?? "",
                              color: Colors.blue),
                          InfoRowWidget(
                              icon: CupertinoIcons.number_square,
                              info: data.address?.zipcode ?? "",
                              color: Colors.black),
                          InfoRowWidget(
                              icon: CupertinoIcons.location,
                              info:
                                  "${data.address?.geo?.lat!} , ${data.address?.geo?.lng!}",
                              color: Colors.blueAccent),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Company Details",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Divider(),
                          InfoRowWidget(
                              icon: Icons.apartment_outlined,
                              info: data.company?.name ?? "",
                              color: Colors.brown),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("catchPhrase"),
                                SizedBox(
                                  width: 10,
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      data.company?.catchPhrase ?? "",
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
