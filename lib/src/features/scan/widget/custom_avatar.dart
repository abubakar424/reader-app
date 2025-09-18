import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final int index;
  final String imagePath;
  final String label;
  final int selectedAvatarIndex;
  final Function onTap;
  final Color borderColor;

  const CustomAvatar({
    Key? key,
    required this.index,
    required this.imagePath,
    required this.label,
    required this.selectedAvatarIndex,
    required this.onTap,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: Container(
            width: 50, // Diameter of the outer circle
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColor,
                width: 1,
              ),
              color: selectedAvatarIndex == index
                  ? borderColor.withOpacity(0.2) // Highlight selected avatar
                  : Colors.transparent, // Remove highlight from unselected avatars
            ),
            child: ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(10.0), // Adjust the padding to control the image size
                // child: Image.asset(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: index == 0 ? Colors.transparent : Colors.black, // Pink color for Mic label
          ),
        ),
        ],
    );
  }
}
