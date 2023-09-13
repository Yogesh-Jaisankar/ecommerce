import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SponsorItem extends StatefulWidget {
  const SponsorItem({super.key});

  @override
  State<SponsorItem> createState() => _SponsorItemState();
}

class _SponsorItemState extends State<SponsorItem> {
  TextEditingController _desctextController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  String _descriptiontext = 'Description';
  String _price = 'Price';

  File? _selectedImage; // Store the selected image

  void dispose() {
    _desctextController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  // Function to open the image picker
  Future<void> _pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
        });
      }
    } catch (e) {
      // Handle the error (e.g., display an error message)
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              "Sponsor Item Preview",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 110,
                      width: 120,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                        ),
                        child: _selectedImage != null
                            ? Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              ) // Display the selected image
                            : Image.asset(
                                "assets/images/image.png",
                                fit: BoxFit.cover,
                              ), // Default image
                      ),
                    ),
                    SizedBox(height: 0, width: 120, child: Divider()),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        _descriptiontext,
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "₹$_price",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Divider(),
            MaterialButton(
                onPressed: () {
                  _pickImage();
                  print("Image");
                },
                color: Colors.indigoAccent,
                child: Text(
                  "Select Product Image",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLength: 20,
                  controller: _desctextController,
                  onChanged: (value) {
                    setState(() {
                      _descriptiontext = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintStyle: TextStyle(overflow: TextOverflow.ellipsis),
                    hintText: 'Your Product Description...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                  maxLength: 7,
                  controller: _priceController,
                  onChanged: (value) {
                    setState(() {
                      _price = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintStyle: TextStyle(overflow: TextOverflow.ellipsis),
                    hintText: 'Set Price',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: 250,
              //Todo: Add otp verification to cpmplete the add sponsor process
              child: MaterialButton(
                  onPressed: () {
                    print("Add Sponsor");
                  },
                  color: Colors.green.shade600,
                  child: Text(
                    "Add Sponsor",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: Colors.grey.shade400,
                  ),
                ),
                Text(
                  "Otp Required !",
                  style: TextStyle(
                      color: Colors.grey.shade400, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
