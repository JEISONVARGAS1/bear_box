import 'package:bearbox/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';

class HeaderRowSubscriptionsTable extends StatelessWidget {
  const HeaderRowSubscriptionsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.sizeWidth() * 0.02,
        vertical: context.sizeHeight() * 0.01,
      ),
      decoration: BoxDecoration(
        color: MyFitUiKit.util.color.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Usuario
          Expanded(
            flex: 2,
            child: Text(
              "USUARIO",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          // Precio
          Expanded(
            flex: 1,
            child: Text(
              "PRECIO",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          // Fecha Inicio
          Expanded(
            flex: 1,
            child: Text(
              "INICIO",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          // Fecha Fin
          Expanded(
            flex: 1,
            child: Text(
              "FIN",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          // Días Restantes
          Expanded(
            flex: 1,
            child: Text(
              "DÍAS",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          // Progreso
          Expanded(
            flex: 1,
            child: Text(
              "PROGRESO",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
