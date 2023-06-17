import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../View/Resources/utils.dart';
import '../../res/Colorsnew/appcolors.dart';
import '../../res/colors/style.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/user_preference/user_preference_view_model.dart';
import '../../widget/glowingbutton.dart';
import '../Authentication/widget/widget.dart';
import '../Widgets/custom_appbar.dart';

class EditProfileController extends GetxController {
  String name = '';
  String phoneNumber = '';
  String profileImage = '';
  var isLoading = RxBool(false);

  Future<void> fetchUserProfile() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("remToken");
    var url =
        'https://maticlegend.com/api/auth/profile'; // Replace with your API endpoint
    var response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var user = jsonResponse['user'];

      name = user['name'];
      phoneNumber = user['phone_number'];
      profileImage = jsonResponse['user_image'];

      update();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  final ImagePicker _imagePicker = ImagePicker();
  File? selectedImage;

  Future<void> selectImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImage = File(pickedImage.path);
      update();
    }
  }

  Future<void> editProfileImage(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("remToken");
    try {
      isLoading.value = true;

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("https://maticlegend.com/api/auth/profile_update"),
      );
      request.headers['Authorization'] = 'Bearer $token';

      if (selectedImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'user_image', selectedImage!.path));
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var data = jsonDecode(responseData);

      if (response.statusCode == 200) {
        updateProfile(
          "name",
          data["data"]["name"].toString(),
          "phone",
          data["data"]["phone_number"].toString(),
        );

        Utils.snackbar(data["message"], "");

        await updateProfileImage("profileimg", data["user_image"]);

        // isLoading.value = false;

        // Navigator.pop(context);
      } else if (response.statusCode == 422) {
        Utils.snackbar(data["errors"], "");
      }
    } catch (e) {
      print(e.toString());
      Utils.snackbar("Something went wrong $e", "");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editProfile(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("remToken");
    try {
      // isLoading.value = true;

      var response = await http.post(
        Uri.parse("https://maticlegend.com/api/auth/profile_update"),
        body: {
          "name": name,
          "phone_number": phoneNumber,
        },
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        updateProfile(
          "name",
          data["data"]["name"].toString(),
          "phone",
          data["data"]["phone_number"].toString(),
        );

        Utils.snackbar(data["message"], "");

        debugPrint("name changed to: ${data["data"]["name"].toString()}");
        debugPrint(
            "phone number changed to: ${data["data"]["phone_number"].toString()}");
        // Navigator.pop(context);
      } else if (response.statusCode == 422) {
        var data = jsonDecode(response.body);
        Utils.snackbar(data["errors"], "");
      }
    } catch (e) {
      print(e.toString());
      Utils.snackbar("Something went wrong $e", "");
    } finally {
      // isLoading.value = false;
    }
  }

  void updateName(String newName) {
    name = newName;
  }

  void updatePhoneNumber(String newPhoneNumber) {
    phoneNumber = newPhoneNumber;
  }

  Future<void> refreshPage() async {
    await fetchUserProfile();
  }
}

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final EditProfileController controller = Get.put(EditProfileController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg1.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: SubScreenApbarBlack(
          title: "Edit Profile",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(height: 50),
                GetBuilder<EditProfileController>(
                  builder: (_) {
                    return Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                            controller.profileImage == ""
                                ? "https://lh3.googleusercontent.com/pw/AJFCJaU0GU1whPNk7q4vw0eIfgsJP59K49IzweB9Vz2sz-Ph3fbgE5Yl1mrqNtfY3DXxUhSe3NFnciEkLUsVmCKfs3AatWQ-Mu7X5nXvFhDsZVF9dNtBSpRuU9Bjo_3VGffaNRS71rX8aKlsISZH2nW8hW9z=w225-h225-s-no"
                                : controller.profileImage,
                          ),
                        ),
                        if (controller.isLoading.value)
                          Positioned(
                              bottom: 0,
                              right: 0,
                              top: 0,
                              left: 0,
                              child: CircularProgressIndicator()),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey,
                            child: IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: () {
                                _.selectImage().then((value) => controller
                                    .editProfileImage(context)
                                    .then((value) => controller.refreshPage()));
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                // GetBuilder<EditProfileController>(
                //   builder: (_) {
                //     return ElevatedButton(
                //         onPressed: () {
                //           _.selectImage().then((value) => controller
                //               .editProfileImage(context)
                //               .then((value) => controller.refreshPage()));
                //         },
                //         child: Text("pick Image"));
                //   },
                // ),
                SizedBox(height: 30),
                GetBuilder<EditProfileController>(
                  builder: (_) {
                    return buildTextFieldEditProfile(
                      controller: TextEditingController(text: controller.name),
                      hint: 'Name',
                      icon: Icons.person,
                      onChanged: controller.updateName,
                    );
                  },
                ),
                SizedBox(height: 20),
                GetBuilder<EditProfileController>(
                  builder: (_) {
                    return buildTextFieldEditProfile(
                      controller:
                          TextEditingController(text: controller.phoneNumber),
                      hint: 'Phone',
                      icon: Icons.phone,
                      onChanged: controller.updatePhoneNumber,
                    );
                  },
                ),
                SizedBox(height: 50),
                GetBuilder<EditProfileController>(
                  builder: (_) {
                    return InkWell(
                      onTap: () {
                        controller.editProfile(context);
                      },
                      child: GlowingButtonAuth(
                        text: "Save",
                        loading: false,
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Delete Account",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldEditProfile({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.white30),
        labelStyle: TextStyle(color: Colors.white30),
        prefixIcon: Icon(
          icon,
          color: AppColor.purpleColor,
        ),
        labelText: hint,
        border: UnderlineInputBorder(),
        hintText: hint,
      ),
    );
  }
}
