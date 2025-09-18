import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../model/doc_model.dart';
class DocumentProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> documentTypes = [
    {
      'iconPath': AppIcons.docCamera,
      'title': 'Import Image',
      'fileCount': 120,
      'color': AppColor.purple
    },
    {
      'iconPath': AppIcons.docFile,
      'title': 'Import File',
      'fileCount': 58,
      'color': AppColor.peach
    },
    {
      'iconPath': AppIcons.docScan,
      'title': 'Smart Scan',
      'fileCount': 41,
      'color': AppColor.green
    },
    {
      'iconPath': AppIcons.docGallery,
      'title': 'Gallery',
      'fileCount': 46,
      'color': AppColor.blue
    },
  ];

  final List<RecentFile> recentItems = [
    RecentFile(
        imagePath:
            "https://ohiostate.pressbooks.pub/app/uploads/sites/160/h5p/content/5/images/image-5bd08790e1864.png",
        title: 'Appointment.pdf',
        date: '2024-11-01',
        time: '6:29',
        romandate: 'January,11'),
    RecentFile(
        imagePath:
            "https://cdn.prod.website-files.com/62c67bbf65af22785775fee3/66f6ace0028aed08e2ce0d46_Software%20Design%20DocumentationTemplate.png",
        title: 'Offer Letter',
        date: '2024-11-01',
        time: '6:29',
        romandate: 'January,11'),
    RecentFile(
        imagePath:
            "https://nimbusweb.me/wp-content/uploads/2023/05/Contractor-Agreement-791x1024.png",
        title: 'Appointment',
        date: '2024-11-01',
        time: '6:29',
        romandate: 'January,11'),
  ];

  List<RecentFile> filteredItems = [];

  DocumentProvider() {
    filteredItems = recentItems;
  }

  // Function to request storage permissions
  Future<bool> requestPermissions() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  // Method to add a document from AppointmentPage with a custom image path
  void addDocumentFromAppointment(String imagePath) {
    filteredItems.add(RecentFile(
      title: "New Document",
      date: "2024-11-05",
      romandate: "January,3",
      time: "10:30 AM",
      imagePath: imagePath,
    ));

    notifyListeners();
  }

  void searchFiles(String query) {
    if (query.isEmpty) {
      filteredItems = recentItems;
    } else {
      filteredItems = recentItems
          .where(
              (file) => file.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    debugPrint(
        'Filtered Items in HomePage Search: ${filteredItems.map((item) => item.title).toList()}');
    notifyListeners();
  }

  Future<void> pickImage() async {
    if (await requestPermissions()) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        // Handle image selection from the camera
      }
    } else {
      // Handle permission denial
    }
  }

  Future<void> pickFile() async {
    if (await requestPermissions()) {
      final result = await FilePicker.platform.pickFiles(type: FileType.any);
      if (result != null) {
        // Handle file selection
      }
    } else {
      // Handle permission denial
    }
  }

  Future<void> openGallery() async {
    try {
      if (await requestPermissions()) {
        final ImagePicker picker = ImagePicker();
        final XFile? galleryImage =
            await picker.pickImage(source: ImageSource.gallery);
        if (galleryImage != null) {
          // Handle gallery image selection
        }
      } else {
        // Handle permission denial
      }
    } catch (e) {
      log('error in openGallery: $e');
    }
  }
}



// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:readr_app/src/common/constants/app_colors.dart';
// import 'package:readr_app/src/common/constants/app_images.dart';
// import 'package:readr_app/src/model/doc_model.dart';

// class DocumentProvider extends ChangeNotifier {
//   final List<Map<String, dynamic>> documentTypes = [
//     {
//       'iconPath': AppIcons.docCamera,
//       'title': 'Import Image',
//       'fileCount': 120,
//       'color': AppColor.purple
//     },
//     {
//       'iconPath': AppIcons.docFile,
//       'title': 'Import File',
//       'fileCount': 58,
//       'color': AppColor.peach
//     },
//     {
//       'iconPath': AppIcons.docScan,
//       'title': 'Smart Scan',
//       'fileCount': 41,
//       'color': AppColor.green
//     },
//     {
//       'iconPath': AppIcons.docGallery,
//       'title': 'Gallery',
//       'fileCount': 46,
//       'color': AppColor.blue
//     },
//   ];

//   final List<RecentFile> recentItems = [
//     RecentFile(
//       imagePath: "https://ohiostate.pressbooks.pub/app/uploads/sites/160/h5p/content/5/images/image-5bd08790e1864.png",
//       title: 'Appointment.pdf',
//       date: '2024-11-01',
//       time: '6:29',
//       romandate: 'January,11',
//     ),
//     RecentFile(
//       imagePath: "https://cdn.prod.website-files.com/62c67bbf65af22785775fee3/66f6ace0028aed08e2ce0d46_Software%20Design%20DocumentationTemplate.png",
//       title: 'Offer Letter',
//       date: '2024-11-01',
//       time: '6:29',
//       romandate: 'January,11',
//     ),
//     RecentFile(
//       imagePath: "https://nimbusweb.me/wp-content/uploads/2023/05/Contractor-Agreement-791x1024.png",
//       title: 'Appointment',
//       date: '2024-11-01',
//       time: '6:29',
//       romandate: 'January,11',
//     ),
//   ];

//   List<RecentFile> filteredItems = [];

//   DocumentProvider() {
//     // Initialize filteredItems with recentItems
//     filteredItems = List.from(recentItems);
//   }

//   // Function to request storage permissions
//   Future<bool> requestPermissions() async {
//     final status = await Permission.storage.request();
//     return status.isGranted;
//   }

//   // Method to add a document from AppointmentPage with a custom image path
//   void addDocumentFromAppointment(String imagePath) {
//     final newDocument = RecentFile(
//       title: "New Document",
//       date: "2024-11-05",
//       romandate: "January,3",
//       time: "10:30 AM",
//       imagePath: imagePath,
//     );

//     // Check if the document already exists in filteredItems and recentItems
//     if (!filteredItems.any((item) => item.imagePath == imagePath)) {
//       filteredItems.add(newDocument);
//     }

//     if (!recentItems.any((item) => item.imagePath == imagePath)) {
//       recentItems.add(newDocument);
//     }

//     // Ensure filteredItems is synced with recentItems
//     filteredItems = List.from(recentItems);

//     notifyListeners();
//   }

//   void searchFiles(String query) {
//     if (query.isEmpty) {
//       // Reset filteredItems to all recentItems when search is cleared
//       filteredItems = List.from(recentItems);
//     } else {
//       // Filter recentItems based on query
//       filteredItems = recentItems
//           .where((file) => file.title.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }

//     debugPrint(
//       'Filtered Items in HomePage Search: ${filteredItems.map((item) => item.title).toList()}',
//     );
//     notifyListeners();
//   }

//   Future<void> pickImage() async {
//     if (await requestPermissions()) {
//       final ImagePicker picker = ImagePicker();
//       final XFile? image = await picker.pickImage(source: ImageSource.camera);
//       if (image != null) {
//         // Handle image selection from the camera
//       }
//     } else {
//       // Handle permission denial
//     }
//   }

//   Future<void> pickFile() async {
//     if (await requestPermissions()) {
//       final result = await FilePicker.platform.pickFiles(type: FileType.any);
//       if (result != null) {
//         // Handle file selection
//       }
//     } else {
//       // Handle permission denial
//     }
//   }

//   Future<void> openGallery() async {
//     if (await requestPermissions()) {
//       final ImagePicker picker = ImagePicker();
//       final XFile? galleryImage = await picker.pickImage(source: ImageSource.gallery);
//       if (galleryImage != null) {
//         // Handle gallery image selection
//       }
//     } else {
//       // Handle permission denial
//     }
//   }
// }
