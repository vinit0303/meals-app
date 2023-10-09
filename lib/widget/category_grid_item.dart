import 'package:flutter/material.dart';
import 'package:newmeal/model/category.dart';
import 'package:newmeal/screens/animated_dialog.dart';



class CategoryGridItem extends StatefulWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final Category category;
  final void Function() onSelectCategory;



  

  @override
  State<CategoryGridItem> createState() => _CategoryGridItemState();
}

class _CategoryGridItemState extends State<CategoryGridItem> {
  late OverlayEntry _popupDialog;

  OverlayEntry _createPopupDialog() {
    return OverlayEntry(
        builder: (context) => AnimatedDialog(
              child: _createPopupContent(),
            ));
  }

  Widget _createPopupContent() => Container(
        width: double.maxFinite,
        height: 400,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: widget.category.color.withOpacity(0.8)),
        child: Column(
          children: [
            Text(
              widget.category.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelectCategory,
      onLongPressStart: _showOverlay,
      onLongPressEnd: _hideOverlay,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              widget.category.color.withOpacity(0.55),
              widget.category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          widget.category.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }

  void _showOverlay(LongPressStartDetails details) {
    _popupDialog = _createPopupDialog();
    Overlay.of(context).insert(_popupDialog);
  }

  void _hideOverlay(LongPressEndDetails details) {
    _popupDialog.remove();
  }
}
