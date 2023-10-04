import 'package:album_repository/album_repository.dart';
import 'package:albums/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard(this.albumPhoto, {super.key});

  final AlbumPhoto albumPhoto;

  static const _placeHolderIcon = Center(child: Icon(Icons.image));

  static const _borderRadius = BorderRadius.vertical(top: Radius.circular(8));

  static const _titlePadding = EdgeInsets.all(8);

  Widget errorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) =>
      _placeHolderIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Flexible(
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: _borderRadius,
              child: Image.network(
                albumPhoto.thumbnailUrl ?? '',
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: errorBuilder,
              ),
            ),
          ),
          Padding(
            padding: _titlePadding,
            child: Text(
              albumPhoto.title ?? Constants.untitled,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
