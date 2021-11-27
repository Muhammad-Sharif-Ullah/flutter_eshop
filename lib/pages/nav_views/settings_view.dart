import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/theme/app_constant.dart';
import 'package:flutter_eshop/utils/validator.dart';
import 'package:flutter_eshop/widget/password_field.dart';
import 'package:intl/intl.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    DateTime newDOB = DateTime.now();
    DateTime oldDOB = DateTime.now();
    final inputFormat = DateFormat('dd/MM/yyyy');
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    getFormatDOB() => inputFormat.format(newDOB);
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        // title: Text('SettingsView'),
        // iconTheme: IconThemeData(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          // onPressed: () => Get.back(),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: textTheme.headline1,
                ),
                SizedBox(height: height * .01),
                Text(
                  'Personal Information',
                  style: textTheme.headline3,
                ),
                SizedBox(height: height * .01),
                SettingCard(
                  height: 74,
                  isDarkMode: isDarkMode,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Full Name",
                          style: textTheme.caption?.copyWith(
                              color: Colors.grey,
                              wordSpacing: 0,
                              fontWeight: FontWeight.bold)),
                      Text("User Name", style: textTheme.caption),
                    ],
                  ),
                ),
                SizedBox(height: height * .01),
                InkWell(
                  onTap: () => changeDOB(newDOB, oldDOB, isDarkMode, context),
                  child: SettingCard(
                      height: 64,
                      isDarkMode: isDarkMode,
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date Of Birth",
                            style: textTheme.caption?.copyWith(
                                color: Colors.grey,
                                wordSpacing: 0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(getFormatDOB().toString())
                        ],
                      )),
                ),
                SizedBox(height: height * .01),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Password',
                        style: textTheme.headline3,
                      ),
                      TextButton(
                          onPressed: () {
                            changePassword(context, height);
                          },
                          child: const Text("Change",
                              style: TextStyle(color: Colors.grey))),
                    ],
                  ),
                ),
                SettingCard(
                  height: 64,
                  isDarkMode: isDarkMode,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Password",
                          style: textTheme.caption?.copyWith(
                              color: Colors.grey,
                              wordSpacing: 0,
                              fontWeight: FontWeight.bold)),
                      const Text("******************")
                    ],
                  ),
                ),
                SizedBox(height: height * .011),
                Text(
                  'Notifications',
                  style: textTheme.headline3,
                ),
                buildSwitchButton("Sale", true, context, textTheme),
                buildSwitchButton("New Arrivals", true, context, textTheme),
                buildSwitchButton(
                  "Delivery Status Change",
                  true,
                  context,
                  textTheme,
                ),
                SizedBox(height: height * .01),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: width * .5,
                    child: ElevatedButton.icon(
                        onPressed: () async {
                          // await FireBaseAuth.logOut();
                          // Get.offAllNamed(Routes.AUTHENTICATION);
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text("Logout")),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> changePassword(BuildContext context, double height) {
    TextEditingController oldPASS = TextEditingController();
    TextEditingController newPAss = TextEditingController();

    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          height: height,
          child: Column(
            children: [
              Expanded(
                child: PasswordField(
                  label: 'Old Password',
                  hintText: "********",
                  passCNT: oldPASS,
                  validator: (String? value) => Validator.passValidate(value),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> changeDOB(
      DateTime newDOB, DateTime oldDOB, bool isDarkMode, BuildContext context) {
    // return Get.defaultDialog(
    //   backgroundColor: isDarkMode ? AppColors.blackDark : AppColors.white,
    //   title: "Select Date Of Birth",
    //   titleStyle:
    //       TextStyle(color: !isDarkMode ? AppColors.blackDark : AppColors.white),
    //   confirm: ElevatedButton(
    //     onPressed: () {
    //       //TODO: Changing Code with Backend
    //       newDOB = oldDOB;
    //       // Get.back();
    //       Navigator.pop(context);
    //     },
    //     child: const Text("Change Now"),
    //     style: ElevatedButton.styleFrom(primary: AppColors.success),
    //   ),
    //   cancel: ElevatedButton(
    //       onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
    //   content: Container(
    //     color: Colors.white,
    //     height: 300,
    //     child: CupertinoTheme(
    //       data: CupertinoThemeData(
    //         brightness: isDarkMode ? Brightness.dark : Brightness.light,
    //       ),
    //       child: CupertinoDatePicker(
    //         backgroundColor: isDarkMode ? AppColors.blackDark : AppColors.white,
    //         mode: CupertinoDatePickerMode.date,
    //         initialDateTime: newDOB,
    //         onDateTimeChanged: (DateTime newDateTime) {
    //           oldDOB = newDateTime;
    //         },
    //       ),
    //     ),
    //   ),
    // );
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              //TODO: Changing Code with Backend
              newDOB = oldDOB;
              // Get.back();
              Navigator.pop(context);
            },
            child: const Text("Change Now"),
            style: ElevatedButton.styleFrom(primary: AppColors.success),
          )
        ],
        backgroundColor: isDarkMode ? AppColors.blackDark : AppColors.white,
        title: Text(
          'Select Date Of Birth',
          style: TextStyle(
              color: !isDarkMode ? AppColors.blackDark : AppColors.white),
        ),
        content: Container(
          color: Colors.white,
          height: 300,
          child: CupertinoTheme(
            data: CupertinoThemeData(
              brightness: isDarkMode ? Brightness.dark : Brightness.light,
            ),
            child: CupertinoDatePicker(
              backgroundColor:
                  isDarkMode ? AppColors.blackDark : AppColors.white,
              mode: CupertinoDatePickerMode.date,
              initialDateTime: newDOB,
              onDateTimeChanged: (DateTime newDateTime) {
                oldDOB = newDateTime;
              },
            ),
          ),
        ),
      ),
    );
  }

  ListTile buildSwitchButton(String btnName, bool onActive,
      BuildContext context, TextTheme textTheme) {
    return ListTile(
      leading: Text(btnName, style: textTheme.subtitle2),
      trailing: CupertinoSwitch(
        value: onActive,
        onChanged: (value) {},
      ),
    );
  }
}

class SettingCard extends StatelessWidget {
  const SettingCard({
    Key? key,
    this.height = 64,
    required this.child,
    required this.isDarkMode,
    required this.width,
  }) : super(key: key);
  final Widget child;
  final double height;
  final bool isDarkMode;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: isDarkMode ? AppColors.blackDark : AppColors.white,
      child: Container(
        height: height,
        padding: const EdgeInsets.only(left: 14.0),
        alignment: Alignment.centerLeft,
        width: width,
        child: child,
      ),
    );
  }
}
