import 'package:flutter/material.dart';
import 'package:shawn/features/splash/netflix/utils/models.dart';

List<Path> netflixSegments() {
  const letterWidth = 44.0;
  const strokeThickness = 12.0;
  const letterHeight = 85.0;
  const spacing = 8.0; // Base spacing between letters

  // ---------------------------
  // Letter I segments
  // ---------------------------
  Path buildI(double xOffset) {
    return Path()
      ..direction = AnimationDirection.bottomToTop
      ..moveTo(xOffset + (letterWidth / 2) - strokeThickness, -5)
      ..lineTo(xOffset + letterWidth / 2 + .8, -5)
      ..lineTo(xOffset + letterWidth / 2 + .8, letterHeight - 2.5)
      ..lineTo(xOffset + letterWidth / 2 - strokeThickness, letterHeight - 3.8)
      ..close();
  }

  List<Path> buildISegments(double xOffset) {
    return [
      buildI(xOffset),
    ];
  }

  // ---------------------------
  // Letter J segments (Updated with your provided code)
  // ---------------------------
  Path buildJTop(double xOffset) {
    return Path()
      ..direction = AnimationDirection.leftToRight
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(xOffset, -5, letterWidth, strokeThickness),
        Radius.zero,
      ));
  }

  Path buildJStem(double xOffset) {
    return Path()
      ..direction = AnimationDirection.topToBottom
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
          xOffset + letterWidth - strokeThickness,
          -5,
          strokeThickness,
          letterHeight * 0.75,
        ),
        Radius.zero,
      ));
  }

  Path buildJHook(double xOffset) {
    final path = Path()..direction = AnimationDirection.leftToRight;
    path.moveTo(xOffset, letterHeight * 0.75 - strokeThickness / 2);
    path.quadraticBezierTo(
        xOffset, letterHeight + 5, xOffset + letterWidth / 2, letterHeight + 5);
    path.lineTo(xOffset + letterWidth - strokeThickness, letterHeight + 5);
    path.lineTo(xOffset + letterWidth - strokeThickness, letterHeight * 0.75);
    path.close();
    return path;
  }

  List<Path> buildJSegments(double xOffset) => [
    buildJTop(xOffset),
    buildJStem(xOffset),
    buildJHook(xOffset),
  ];


  // ---------------------------
  // Letter N segments
  // ---------------------------
  Path buildNLeft(double xOffset) {
    final path = Path();
    path.direction = AnimationDirection.bottomToTop;
    path.moveTo(xOffset - 1, -4);
    path.lineTo(xOffset - 1 + strokeThickness + 1, -4);
    path.lineTo(xOffset - 1 + strokeThickness + 1, -4 + letterHeight + 6.5);
    path.lineTo(xOffset - 1, -4 + letterHeight + 8.5);
    path.close();
    return path;
  }

  Path buildNDiagonal(double xOffset) {
    return Path()
      ..direction = AnimationDirection.topToBottom
      ..moveTo(xOffset - 13 + (strokeThickness * 1.0), -5)
      ..lineTo(xOffset - 14 + (strokeThickness * 2.0), -5)
      ..lineTo(xOffset + 12 + (letterWidth - strokeThickness), letterHeight - 2)
      ..lineTo(
          xOffset + 9 + (letterWidth - strokeThickness * 2.0), letterHeight)
      ..close();
  }

  Path buildNRight(double xOffset) {
    final path = Path();
    path.direction = AnimationDirection.bottomToTop;
    final startX = xOffset - 1 + (letterWidth - strokeThickness);
    const startY = -5.0;
    path.moveTo(startX, startY);
    path.lineTo(startX + strokeThickness, startY);
    path.lineTo(startX + strokeThickness, startY + letterHeight + 4);
    path.lineTo(startX, startY + letterHeight + 6);
    path.close();
    return path;
  }

  List<Path> buildNSegments(double xOffset) {
    return [
      buildNLeft(xOffset),
      buildNDiagonal(xOffset),
      buildNRight(xOffset),
    ];
  }

  // ---------------------------
  // Letter L segments
  // ---------------------------
  Path buildLVertical(double xOffset) {
    return Path()
      ..direction = AnimationDirection.topToBottom
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(xOffset, -5, strokeThickness + 1.5, letterHeight - 5),
        const Radius.circular(0),
      ));
  }

  Path buildLBottom(double xOffset) {
    return Path()
      ..direction = AnimationDirection.leftToRight
      ..moveTo(xOffset, letterHeight - strokeThickness - 8)
      ..lineTo(xOffset + letterWidth - 6, letterHeight - strokeThickness - 6.8)
      ..lineTo(xOffset + letterWidth - 6, letterHeight - strokeThickness + 7.5)
      ..lineTo(xOffset, letterHeight - strokeThickness + 5.5)
      ..close();
  }

  List<Path> buildLSegments(double xOffset) {
    return [
      buildLVertical(xOffset),
      buildLBottom(xOffset),
    ];
  }

  // ---------------------------
  // Letter E segments
  // ---------------------------
  Path buildEVertical(double xOffset) {
    return Path()
      ..direction = AnimationDirection.bottomToTop
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(xOffset, 0, strokeThickness + 2, letterHeight - 5),
        const Radius.circular(0),
      ));
  }

  Path buildETop(double xOffset) {
    return Path()
      ..direction = AnimationDirection.leftToRight
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
          xOffset + strokeThickness - 12,
          -5,
          letterWidth - strokeThickness + 6,
          strokeThickness + 2,
        ),
        const Radius.circular(0),
      ));
  }

  Path buildEMiddle(double xOffset) {
    return Path()
      ..direction = AnimationDirection.leftToRight
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
          xOffset + strokeThickness,
          (letterHeight / 2) - (strokeThickness / 2) - 6,
          letterWidth - (strokeThickness * 2),
          strokeThickness + 2,
        ),
        const Radius.circular(0),
      ));
  }

  Path buildEBottom(double xOffset) {
    return Path()
      ..direction = AnimationDirection.rightToLeft
      ..moveTo(xOffset, letterHeight - strokeThickness - 5)
      ..lineTo(xOffset + letterWidth - 6, letterHeight - strokeThickness - 6.5)
      ..lineTo(xOffset + letterWidth - 6, letterHeight - strokeThickness + 7.2)
      ..lineTo(xOffset, letterHeight - strokeThickness + 9.8)
      ..close();
  }

  List<Path> buildESegments(double xOffset) {
    return [
      buildEBottom(xOffset),
      buildEVertical(xOffset),
      buildETop(xOffset),
      buildEMiddle(xOffset),
    ];
  }


  // ---------------------------
  // Assemble segments for "IJINLE"
  // ---------------------------

  final segments = <Path>[];
  final double segmentUnit = letterWidth + spacing;

  segments.addAll(buildISegments(0 * segmentUnit));                // I
  segments.addAll(buildJSegments(1.0 * segmentUnit));              // J (Using your new J paths)
  segments.addAll(buildISegments(1.7 * segmentUnit));              // I (Second I, closer to J)
  segments.addAll(buildNSegments(2.8 * segmentUnit));              // N (Wider spacing after narrow I)
  segments.addAll(buildLSegments(3.8 * segmentUnit));              // L
  segments.addAll(buildESegments(4.7 * segmentUnit));              // E

  return segments;
}
