import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String texto;
  final bool seleccionado;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.texto,
    required this.seleccionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, right: 8),
      child: Material(
        elevation: seleccionado ? 4 : 0,
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        child: ChoiceChip(
          label: Text(texto),
          selected: seleccionado,
          onSelected: (_) => onTap(),
          selectedColor: const Color(0xFF000A7A), // deep blue on select
          backgroundColor: theme.colorScheme.surface.withOpacity(0.04),
          labelStyle: TextStyle(
            color: seleccionado ? Colors.white : theme.textTheme.bodyMedium?.color,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: seleccionado ? const Color(0xFFB4B4B4) : Colors.transparent,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
