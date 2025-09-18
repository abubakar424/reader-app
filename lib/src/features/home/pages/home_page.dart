import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:share_plus/share_plus.dart';


import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../provider/document.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/document_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  final FocusNode searchFocusNode = FocusNode();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Transform.scale(
              scale: 0.7,
              child: Image.asset(AppImages.menu, height: 18),
            ),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Home",
                  style: textTheme(context).headlineLarge?.copyWith(
                      color: AppColor.appblue,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),

                // Search bar without triggering rebuilds
                CustomTextFormField(
                  controller: searchController,
                  focusNode: searchFocusNode, // Add focusNode here
                  onChanged: (value) {
                    context.read<DocumentProvider>().searchFiles(value);
                  },
                  fillColor: AppColor.lightblue,
                  hint: "Search files...",
                  hintColor: AppColor.appBlue.withOpacity(0.7),
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: AppColor.appBlue.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 12),

                const SizedBox(height: 12),

                // Choose Documents Section
                Text(
                  "Choose Documents",
                  style: textTheme(context).headlineLarge?.copyWith(
                      color: AppColor.appblue,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),

                // Document Boxes in a Grid wrapped with Consumer
                Consumer<DocumentProvider>(
                  builder: (context, documentProvider, child) {
                    return GridView.builder(
                      itemCount: documentProvider.documentTypes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two boxes per row
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 2.8,
                      ),
                      itemBuilder: (context, index) {
                        final doc = documentProvider.documentTypes[index];
                        return DocumentBox(
                          iconPath: doc['iconPath'],
                          title: doc['title'],
                          fileCount: doc['fileCount'],
                          color: doc['color'],
                          onTap: () {
                            if (doc['title'] == 'Import Image') {
                              documentProvider.pickImage();
                            } else if (doc['title'] == 'Import File') {
                              documentProvider.pickFile();
                            } else if (doc['title'] == 'Gallery') {
                              documentProvider.openGallery();
                            }
                          },
                        );
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    );
                  },
                ),
                const SizedBox(height: 12),

                Text(
                  "Recent",
                  style: textTheme(context).headlineLarge?.copyWith(
                      color: AppColor.appblue,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),

                Consumer<DocumentProvider>(
                  builder: (context, documentProvider, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: documentProvider.filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = documentProvider.filteredItems[index];
                        return _buildRecentItem(
                          context,
                          item.title,
                          item.date,
                          item.time,
                          item.imagePath,
                          item.romandate,
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentItem(BuildContext context, String title, String date,
      String time, String imagePath, String romandate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            romandate,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.purple,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 65,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: imagePath.startsWith("http")
                        ? NetworkImage(imagePath) as ImageProvider
                        : FileImage(File(imagePath)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme(context).headlineLarge?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$date    $time',
                    style: textTheme(context).headlineLarge?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (Uri.tryParse(imagePath)?.isAbsolute ?? false) {
                            Share.share(
                              '$title\n$imagePath',
                              subject: title,
                            );
                          } else {
                            Share.shareXFiles(
                              [XFile(imagePath)],
                              text: 'Check out this document: $title',
                            );
                          }
                        },
                        child: Container(
                          height: 19,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColor.peach.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              "Share",
                              style: textTheme(context).headlineLarge?.copyWith(
                                  color: colorScheme(context).onSurface,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 19,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColor.peach.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              "To Word",
                              style: textTheme(context).headlineLarge?.copyWith(
                                  color: colorScheme(context).onSurface,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
          const SizedBox(height: 4),
          Divider(thickness: 1, color: AppColor.peach.withOpacity(0.2)),
        ],
      ),
    );
  }
}
