import 'package:flutter/material.dart';
import 'package:bearbox/core/widgets/dashed_border_container.dart';
import 'package:bearbox/core/widgets/video_player_widget.dart';

class SelectVideo extends StatelessWidget {
  final String url;
  final Function() onTap;

  const SelectVideo({super.key, required this.url, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return url.isEmpty
        ? InkWell(
          onTap: onTap,
          child: DashedBorderContainer(label: "Importar video"),
        )
        : SizedBox(height: 400, child: VideoPlayerWidget(videoUrl: url));
  }
}
