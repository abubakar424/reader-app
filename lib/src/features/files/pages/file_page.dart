import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../router/routes.dart';
import '../../home/provider/document.dart';
import '../../home/widgets/custom_drawer.dart';
import '../../home/widgets/document_box.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({super.key});

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  Map<int, bool> selectedFiles = {};
  bool isSelectAllActive = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final documentProvider = Provider.of<DocumentProvider>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Transform.scale(
            scale: 0.7,
            child: Image.asset(
              AppImages.menu,
              height: 18,
            ),
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
                " Files",
                style: textTheme(context).headlineLarge?.copyWith(
                    color: AppColor.appblue,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                onChanged: (value) => documentProvider.searchFiles(value),
                fillColor: AppColor.lightblue,
                hint: "Search files...",
                hintColor: AppColor.appBlue.withOpacity(0.7),
                prefixIcon: Icon(
                  Icons.search_outlined,
                  color: AppColor.appBlue.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Choose Documents",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColor.appblue,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                itemCount: 2,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.5,
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
                      }
                    },
                  );
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All Files",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColor.appblue,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      GestureDetector(
                        onTap: () => _toggleSelectAll(
                            !_areAllSelected(
                                documentProvider.filteredItems.length),
                            documentProvider),
                        child: Text(
                          _areAllSelected(documentProvider.filteredItems.length)
                              ? "Deselect All"
                              : "Select All",
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppColor.appblue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (isSelectAllActive || _hasMultipleSelections())
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => _shareSelectedFiles(documentProvider),
                          child: Column(
                            children: [
                              Image.asset(
                                AppImages.share,
                                height: 14,
                              ),
                              const SizedBox(height: 4),
                              Text("Share",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: AppColor.darkGreen,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ))
                            ],
                          ),
                        ),
                        const SizedBox(width: 28),
                        GestureDetector(
                          onTap: () =>
                              _copySelectedFilesPaths(documentProvider),
                          child: Column(
                            children: [
                              Image.asset(
                                AppImages.copyIcon,
                                height: 14,
                              ),
                              const SizedBox(height: 4),
                              Text("Copy",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: AppColor.darkGreen,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ))
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: documentProvider.filteredItems.length,
                itemBuilder: (context, index) {
                  final item = documentProvider.filteredItems[index];
                  log(' The path of image is this ${item.imagePath}');
                  return _buildFileItem(
                    context,
                    item.title,
                    item.date,
                    item.romandate,
                    item.time,
                    item.imagePath,
                    selectedFiles[index] ?? false,
                    () => _toggleSelect(index),
                    isSelectAllActive || _hasMultipleSelections(),
                  );
                },
              ),
              SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
  }

  void _shareSelectedFiles(DocumentProvider documentProvider) {
    final selectedItems = selectedFiles.entries
        .where((entry) => entry.value)
        .map((entry) => documentProvider.filteredItems[entry.key])
        .toList();

    if (selectedItems.isNotEmpty) {
      final titlesAndImages = selectedItems
          .map((item) => '${item?.title}\n${item?.imagePath}')
          .join('\n\n');
      Share.share(titlesAndImages);
    }
  }

  void _copySelectedFilesPaths(DocumentProvider documentProvider) {
    final selectedItems = selectedFiles.entries
        .where((entry) => entry.value)
        .map((entry) => documentProvider.filteredItems[entry.key].imagePath)
        .join('\n');

    if (selectedItems.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: selectedItems));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File paths copied to clipboard')),
      );
    }
  }

  void _toggleSelect(int index) {
    setState(() {
      selectedFiles[index] = !(selectedFiles[index] ?? false);
      isSelectAllActive = false;
    });
  }

  bool _areAllSelected(int itemCount) {
    return selectedFiles.values.where((selected) => selected).length ==
        itemCount;
  }

  bool _hasMultipleSelections() {
    return selectedFiles.values.where((selected) => selected).length > 1;
  }

  void _toggleSelectAll(bool selectAll, DocumentProvider documentProvider) {
    setState(() {
      isSelectAllActive = selectAll;
      selectedFiles = {
        for (int i = 0; i < documentProvider.filteredItems.length; i++)
          i: selectAll
      };
    });
  }
}

extension on Object? {
  get title => null;

  get imagePath => null;
}

Widget _buildFileItem(
  BuildContext context,
  String title,
  String date,
  String romandate,
  String time,
  String imagePath,
  bool isSelected,
  VoidCallback onToggleSelect,
  bool isGlobalRowVisible,
) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 75,
            width: 55,
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
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                '$date',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                    ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    romandate,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColor.purple,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$time',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Checkbox(
            value: isSelected,
            onChanged: (value) => onToggleSelect(),
            activeColor: AppColor.appBlue,
          ),
        ],
      ),
      if (isSelected && !isGlobalRowVisible)
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                context.pushNamed(
                  AppRoute.documentPreviewPage,
                  extra: imagePath,
                );
              },
              child: Column(
                children: [
                  Image.asset(
                    AppImages.editIcon,
                    height: 14,
                  ),
                  const SizedBox(height: 4),
                  Text("Edit",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColor.darkGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ))
                ],
              ),
            ),
            const SizedBox(width: 14),
            GestureDetector(
              onTap: () {
                Share.share('$title\n$imagePath');
              },
              child: Column(
                children: [
                  Image.asset(
                    AppImages.share,
                    height: 14,
                  ),
                  const SizedBox(height: 4),
                  Text("Share",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColor.darkGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ))
                ],
              ),
            ),
            const SizedBox(width: 14),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: imagePath));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                    'File path copied to clipboard',
                  )),
                );
              },
              child: Column(
                children: [
                  Image.asset(
                    AppImages.copyIcon,
                    height: 14,
                  ),
                  const SizedBox(height: 4),
                  Text("Copy",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColor.darkGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ))
                ],
              ),
            ),
          ],
        ),
      const SizedBox(height: 4),
      Divider(thickness: 1, color: AppColor.peach.withOpacity(0.2)),
    ],
  );
}
