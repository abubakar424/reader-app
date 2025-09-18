
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../router/routes.dart';
import '../widget/custom_avatar.dart';
import '../widget/custom_slider.dart';

class DocumentPreviewPage extends StatefulWidget {
  final String documentPath;

  const DocumentPreviewPage({super.key, required this.documentPath});

  @override
  _DocumentPreviewPageState createState() => _DocumentPreviewPageState();
}

class _DocumentPreviewPageState extends State<DocumentPreviewPage> {
  int selectedAvatarIndex = 0;
  double brightnessValue = 0.5;


    void _showMicDialog() {
    showDialog(
      context: context,
      barrierDismissible: true, // Allow dismissing when tapping outside
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(), // Dismiss on outside tap
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: colorScheme(context)
                      .primary, // Set green color for the circle
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.volume_up, // Mic icon
                  size: 60,
                  color: colorScheme(context).onSurface, // Icon color in black
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Document Reading',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 336,
                  width: 264,

                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(1 - brightnessValue),
                      BlendMode.srcATop,
                    ),
                    child: Image.file(
                      File(widget.documentPath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Brightness",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomSlider(
                value: brightnessValue,
                onChanged: (value) {
                  setState(() {
                    brightnessValue = value;
                  });
                },
                activeColor: colorScheme(context).onSurface,
                inactiveColor: colorScheme(context).onSurface.withOpacity(0.2),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomAvatar(
                    index: 0,
                    imagePath: AppImages.mic,
                    label: "Mic",
                    selectedAvatarIndex: selectedAvatarIndex,
                    onTap: () {
                      setState(() {
                        selectedAvatarIndex = 0;
                      });
                      _showMicDialog(); // Show dialog on Mic selection
                    },
                    borderColor: colorScheme(context).primary,
                  ),
                  const SizedBox(width: 16),
                  CustomAvatar(
                    index: 1,
                    imagePath: AppImages.male,
                    label: "Male",
                    selectedAvatarIndex: selectedAvatarIndex,
                    onTap: () {
                      setState(() {
                        selectedAvatarIndex = 1;
                      });
                    },
                    borderColor: colorScheme(context).primary,
                  ),
                  const SizedBox(width: 16),
                  CustomAvatar(
                    index: 2,
                    imagePath: AppImages.female,
                    label: "Female",
                    selectedAvatarIndex: selectedAvatarIndex,
                    onTap: () {
                      setState(() {
                        selectedAvatarIndex = 2;
                      });
                    },
                    borderColor: colorScheme(context).primary,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              CustomButton(
                onTap: () {
                  context.pushNamed(
                    AppRoute.appointmentPage,
                    extra: widget.documentPath,
                  );
                },
                borderradius: 50,
                text: "Save",
              ),
            ],
          ),
        ),
      ),
    );
  }

}


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:go_router/go_router.dart';
// import 'package:readr_app/src/common/constants/app_images.dart';
// import 'package:readr_app/src/common/constants/global_variables.dart';
// import 'package:readr_app/src/common/widgets/custom_button.dart';
// import 'package:readr_app/src/features/scan/widget/custom_avatar.dart';
// import 'package:readr_app/src/features/scan/widget/custom_slider.dart';
// import 'package:readr_app/src/router/routes.dart';

// class DocumentPreviewPage extends StatefulWidget {
//   final String documentPath;

//   const DocumentPreviewPage({super.key, required this.documentPath});

//   @override
//   _DocumentPreviewPageState createState() => _DocumentPreviewPageState();
// }

// class _DocumentPreviewPageState extends State<DocumentPreviewPage> {
//   int selectedAvatarIndex = 0;
//   double brightnessValue = 0.5;
//   final FlutterTts flutterTts = FlutterTts();

//   @override
//   void dispose() {
//     flutterTts.stop();
//     super.dispose();
//   }

//   Future<void> _speak(String voiceType) async {
//     if (voiceType == "mic") {
//       await flutterTts.setVoice({'name': 'en-us-x-sfg#male_2-local', 'locale': 'en-US'});
//     } else if (voiceType == "male") {
//       await flutterTts.setVoice({'name': 'en-us-x-sfg#male_1-local', 'locale': 'en-US'});
//     } else if (voiceType == "female") {
//       await flutterTts.setVoice({'name': 'en-us-x-sfg#female_1-local', 'locale': 'en-US'});
//     }
//     await flutterTts.speak("Your document content goes here");
//   }

//   void _showMicDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return GestureDetector(
//           onTap: () => Navigator.of(context).pop(),
//           child: Dialog(
//             backgroundColor: Colors.transparent,
//             child: Center(
//               child: Container(
//                 width: 150,
//                 height: 150,
//                 decoration: BoxDecoration(
//                   color: colorScheme(context).primary,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.volume_up,
//                   size: 60,
//                   color: colorScheme(context).onSurface,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Document Reading',
//           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//             color: Theme.of(context).colorScheme.onSurface,
//             fontSize: 15,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: SizedBox(
//                   height: 336,
//                   width: 264,
//                   child: ColorFiltered(
//                     colorFilter: ColorFilter.mode(
//                       Colors.black.withOpacity(1 - brightnessValue),
//                       BlendMode.srcATop,
//                     ),
//                     child: Image.file(
//                       File(widget.documentPath),
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 "Brightness",
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                   color: Theme.of(context).colorScheme.onSurface,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               CustomSlider(
//                 value: brightnessValue,
//                 onChanged: (value) {
//                   setState(() {
//                     brightnessValue = value;
//                   });
//                 },
//                 activeColor: colorScheme(context).onSurface,
//                 inactiveColor: colorScheme(context).onSurface.withOpacity(0.2),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   CustomAvatar(
//                     index: 0,
//                     imagePath: AppImages.mic,
//                     label: "Mic",
//                     selectedAvatarIndex: selectedAvatarIndex,
//                     onTap: () {
//                       setState(() {
//                         selectedAvatarIndex = 0;
//                       });
//                       _showMicDialog();
//                       _speak("mic");
//                     },
//                     borderColor: colorScheme(context).primary,
//                   ),
//                   const SizedBox(width: 16),
//                   CustomAvatar(
//                     index: 1,
//                     imagePath: AppImages.male,
//                     label: "Male",
//                     selectedAvatarIndex: selectedAvatarIndex,
//                     onTap: () {
//                       setState(() {
//                         selectedAvatarIndex = 1;
//                       });
//                       _speak("male");
//                     },
//                     borderColor: colorScheme(context).primary,
//                   ),
//                   const SizedBox(width: 16),
//                   CustomAvatar(
//                     index: 2,
//                     imagePath: AppImages.female,
//                     label: "Female",
//                     selectedAvatarIndex: selectedAvatarIndex,
//                     onTap: () {
//                       setState(() {
//                         selectedAvatarIndex = 2;
//                       });
//                       _speak("female");
//                     },
//                     borderColor: colorScheme(context).primary,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 50),
//               CustomButton(
//                 onTap: () {
//                   context.pushNamed(
//                     AppRoute.appointmentPage,
//                     extra: widget.documentPath,
//                   );
//                 },
//                 borderradius: 50,
//                 text: "Save",
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
