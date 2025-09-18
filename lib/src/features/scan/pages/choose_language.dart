// import 'package:flutter/material.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:readr_app/src/common/constants/app_colors.dart';

// class ChooseLanguage extends StatefulWidget {
//   const ChooseLanguage({super.key});

//   @override
//   State<ChooseLanguage> createState() => _ChooseLanguageState();
// }

// class _ChooseLanguageState extends State<ChooseLanguage> {
//   Country? selectedCountry;
//   List<Country> countryList = CountryService().getAll(); // Get all countries from the package

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Select Language',
//           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                 color: Theme.of(context).colorScheme.onSurface,
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//               ),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: countryList.length,
//         itemBuilder: (context, index) {
//           final country = countryList[index];
//           final isSelected = selectedCountry == country;

//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 selectedCountry = country;
//               });
//             },
//             child: Container(
//               margin: const EdgeInsets.symmetric(vertical: 8),
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                   color: isSelected ? AppColor.appblue : Colors.grey.shade300,
//                   width: isSelected ? 2 : 1,
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Text(
//                     country.flagEmoji,
//                     style: const TextStyle(fontSize: 24),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Text(
//                       country.name,
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                             color: Theme.of(context).colorScheme.onSurface,
//                             fontWeight: isSelected
//                                 ? FontWeight.bold
//                                 : FontWeight.normal,
//                           ),
//                     ),
//                   ),
//                   if (isSelected)
//                     Icon(
//                       Icons.check,
//                       color: AppColor.appblue,
//                     ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

import '../../../common/constants/app_colors.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({super.key});

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  Country? selectedCountry;
  List<Country> countryList = CountryService().getAll(); // Get all countries from the package

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Language',
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
        actions: [
          TextButton(
            onPressed: selectedCountry != null
                ? () {
                    Navigator.of(context).pop();
                  }
                : null,
            style: TextButton.styleFrom(
              foregroundColor: selectedCountry != null ? AppColor.appblue : Colors.grey,
            ),
            child: const Text('Save'),
          ),
          const SizedBox(width: 8,),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: countryList.length,
        itemBuilder: (context, index) {
          final country = countryList[index];
          final isSelected = selectedCountry == country;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCountry = country;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? AppColor.appblue : Colors.grey.shade300,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    country.flagEmoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      country.name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check,
                      color: AppColor.appblue,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
