import 'dart:math';
import 'package:flutter/material.dart';

class BinaryCodeBackground extends StatefulWidget {
  const BinaryCodeBackground({super.key});

  @override
  State<BinaryCodeBackground> createState() => _BinaryCodeBackgroundState();
}

class _BinaryCodeBackgroundState extends State<BinaryCodeBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  List<List<int>> _binaryColumns = [];
  List<double> _columnOffsets = [];
  List<double> _columnSpeeds = [];
  int _columnCount = 0;
  double _fontSize = 15.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
      _updateColumns();
      setState(() {});
    });

    _controller.repeat(period: const Duration(milliseconds: 50));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeColumns();
  }

  void _initializeColumns() {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    _fontSize = screenWidth < 600 ? 10.0 : 15.0;
    _columnCount = (screenWidth / _fontSize).ceil();

    _binaryColumns = List.generate(_columnCount, (index) => _generateColumn(screenHeight));
    _columnOffsets = List.generate(_columnCount, (index) => -_random.nextDouble() * screenHeight);
    _columnSpeeds = List.generate(_columnCount, (index) => 5.0 + _random.nextDouble() * 10.0);
  }

  List<int> _generateColumn(double screenHeight) {
    final int rowCount = (screenHeight / _fontSize).ceil() + 5;
    return List.generate(rowCount, (index) => _random.nextInt(2));
  }

  void _updateColumns() {
    final double screenHeight = MediaQuery.of(context).size.height;
    for (int i = 0; i < _columnCount; i++) {
      _columnOffsets[i] += _columnSpeeds[i];
      if (_columnOffsets[i] > screenHeight) {
        _columnOffsets[i] = -_random.nextDouble() * screenHeight;
        _binaryColumns[i] = _generateColumn(screenHeight);
        _columnSpeeds[i] = 5.0 + _random.nextDouble() * 10.0;
      }

      for (int j = 0; j < _binaryColumns[i].length; j++) {
        if (_random.nextDouble() < 0.05) {
          _binaryColumns[i][j] = _random.nextInt(2);
        }
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_columnCount == 0 || (constraints.maxWidth / _fontSize).ceil() != _columnCount) {
          _initializeColumns();
        }
        return CustomPaint(
          painter: _BinaryCodePainter(
            binaryColumns: _binaryColumns,
            columnOffsets: _columnOffsets,
            fontSize: _fontSize,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _BinaryCodePainter extends CustomPainter {
  final List<List<int>> binaryColumns;
  final List<double> columnOffsets;
  final double fontSize;

  _BinaryCodePainter({
    required this.binaryColumns,
    required this.columnOffsets,
    required this.fontSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      fontSize: fontSize,
      fontFamily: 'monospace',
      fontWeight: FontWeight.bold,
    );

    for (int colIndex = 0; colIndex < binaryColumns.length; colIndex++) {
      final column = binaryColumns[colIndex];
      final double currentColumnOffset = columnOffsets[colIndex];
      double x = colIndex * fontSize;

      for (int rowIndex = 0; rowIndex < column.length; rowIndex++) {
        double y = currentColumnOffset + rowIndex * fontSize;

        if (y > -fontSize && y < size.height) {
          double opacity = 1.0;
          if (y < fontSize * 5) {
            opacity = y / (fontSize * 5);
          } else if (y > size.height - fontSize * 10) {
            opacity = (size.height - y) / (fontSize * 10);
          }

          final Color animatedColor = Colors.green.withOpacity(opacity.clamp(0.1, 0.7));

          final textSpan = TextSpan(
            text: column[rowIndex].toString(),
            style: textStyle.copyWith(color: animatedColor),
          );
          final textPainter = TextPainter(
            text: textSpan,
            textDirection: TextDirection.ltr,
          );
          textPainter.layout();
          textPainter.paint(canvas, Offset(x, y));
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BinaryCodePainter oldDelegate) {
    return oldDelegate.binaryColumns != binaryColumns || oldDelegate.columnOffsets != columnOffsets || oldDelegate.fontSize != fontSize;
  }
}