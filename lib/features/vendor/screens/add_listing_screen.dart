// import 'dart:io';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:livenxt_front/common/widgets/common_textfield.dart';
// import 'package:livenxt_front/common/widgets/custom_buttom.dart';
// import 'package:livenxt_front/constants/utils.dart';
// import 'package:livenxt_front/features/vendor/services/vendor_services.dart';

// class AddPropertyScreen extends StatefulWidget {
//   const AddPropertyScreen({super.key});
//   static const routeName = '/addProduct';

//   @override
//   State<AddPropertyScreen> createState() => _AddPropertyScreenState();
// }

// class _AddPropertyScreenState extends State<AddPropertyScreen> {
//   final TextEditingController propertyNameController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final VendorServices vendorServices = VendorServices();
//   String category = 'For Sell';
//   List<File> images = [];
//   final _addPropertyFormKey = GlobalKey<FormState>();
//   @override
//   void dispose() {
//     super.dispose();
//     propertyNameController.dispose();
//     descriptionController.dispose();
//     priceController.dispose();
//     addressController.dispose();
//   }

//   List<String> propertyCategory = ['For Sell', 'For Rent', 'Commercial'];
//   void selectImages() async {
//     var res = await pickImage();

//     setState(() {
//       images = res;
//     });
//   }

//   void listProduct() {
//     if (_addPropertyFormKey.currentState!.validate()) {
//       vendorServices.listProprty(
//           context: context,
//           name: propertyNameController.text,
//           description: descriptionController.text,
//           address: addressController.text,
//           price: int.parse(priceController.text),
//           category: category,
//           images: images);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(50),
//           child: AppBar(
//               flexibleSpace: Container(
//                   decoration: const BoxDecoration(
//                       gradient: LinearGradient(colors: [
//                 Color.fromARGB(255, 82, 5, 96),
//                 Colors.black,
//               ]))),
//               title: const Text(
//                 'List New Property',
//                 style: TextStyle(
//                     color: Color.fromARGB(255, 162, 175, 182),
//                     fontWeight: FontWeight.w700),
//               ))),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//                 child: Form(
//                     key: _addPropertyFormKey,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           images.isNotEmpty
//                               ? Stack(children: [
//                                   CarouselSlider(
//                                       items: images.map((i) {
//                                         return Builder(
//                                             builder: (BuildContext context) =>
//                                                 Image.file(
//                                                   i,
//                                                   fit: BoxFit.cover,
//                                                   height: 200,
//                                                 ));
//                                       }).toList(),
//                                       options: CarouselOptions(
//                                           viewportFraction: 1, height: 200)),
//                                   FloatingActionButton(
//                                     onPressed: selectImages,
//                                     child: Text('Add'),
//                                   ),
//                                 ])
//                               : GestureDetector(
//                                   onTap: selectImages,
//                                   child: DottedBorder(
//                                       borderType: BorderType.RRect,
//                                       radius: const Radius.circular(10),
//                                       dashPattern: [10, 4],
//                                       strokeCap: StrokeCap.round,
//                                       child: Container(
//                                         width: double.infinity,
//                                         height: 150,
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         child: const Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Icon(
//                                               Icons.folder_open,
//                                               size: 40,
//                                             ),
//                                             SizedBox(
//                                               height: 10,
//                                             ),
//                                             Text(
//                                               "Select Property Images",
//                                               style: TextStyle(),
//                                             )
//                                           ],
//                                         ),
//                                       )),
//                                 ),
//                           SizedBox(
//                             height: 30,
//                           ),
//                           CustomTextField(
//                             controller: propertyNameController,
//                             hintText: 'Property Name',
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           CustomTextField(
//                             controller: descriptionController,
//                             hintText: 'Property Description',
//                             maxLines: 7,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           CustomTextField(
//                             controller: addressController,
//                             hintText: 'Property address',
//                             maxLines: 3,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           CustomTextField(
//                             controller: priceController,
//                             hintText: 'price',
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           SizedBox(
//                               width: double.infinity,
//                               child: DropdownButton(
//                                 hint: const Text('Select Category'),
//                                 value: category,
//                                 icon: const Icon(Icons.keyboard_arrow_down),
//                                 items: propertyCategory.map((String item) {
//                                   return DropdownMenuItem(
//                                       value: item, child: Text(item));
//                                 }).toList(),
//                                 onChanged: (String? newVal) {
//                                   setState(() {
//                                     category = newVal!;
//                                   });
//                                 },
//                               )),
//                           const SizedBox(height: 10),
//                         ],
//                       ),
//                     ))),
//           ),
//           CustomButton(text: 'List Property', onTap: listProduct),
//           Container(
//             height: 10,
//             decoration: BoxDecoration(color: Colors.purple),
//           )
//         ],
//       ),
//     );
//   }
// }
