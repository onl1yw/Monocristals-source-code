import 'dart:math';
import 'dart:ui';

import '../vault.dart';

void drawImage(Canvas canvas, Size size, Image image){
  final bgImage = Vault.bgImage.value; // Get the image from the Vault class

  if (bgImage != null) {
    // Calculate the aspect ratio for the source and destination rectangles
    final srcSize =
    Size(bgImage.width.toDouble(), bgImage.height.toDouble());
    final srcRect = Offset.zero & srcSize;

    // Calculate the scale factors for width and height
    final scaleX = size.width / srcSize.width;
    final scaleY = size.height / srcSize.height;

    // Use the smaller of the two scale factors to ensure the entire image fits within the screen
    final scale = min(scaleX, scaleY);

    // Calculate the destination size and rectangle
    final dstSize = srcSize * scale;
    final dstRect = Offset((size.width - dstSize.width) / 2,
        (size.height - dstSize.height) / 2) &
    dstSize;

    // Draw the image scaled to fit within the destination rectangle, while maintaining its aspect ratio
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.translate(Vault.imX.value, Vault.imY.value);
    canvas.rotate(Vault.imRotate
        .value); // Rotate the image// Scale the image// Translate the image// Translate to the center of the canvas
    canvas.scale(Vault.imScale.value);
    canvas.translate(-size.width / 2, -size.height / 2); // Translate back
    canvas.drawImageRect(bgImage, srcRect, dstRect, Paint());
    canvas.restore();
  }
}