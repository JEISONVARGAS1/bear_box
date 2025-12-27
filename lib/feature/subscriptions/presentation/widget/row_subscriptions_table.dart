import 'package:bearbox/core/extension/context_extension.dart';
import 'package:bearbox/feature/subscriptions/data/model/subscription_table_model.dart';
import 'package:flutter/material.dart';

class RowSubscriptionsTable extends StatelessWidget {
  final SubscriptionTableModel subscription;
  final bool isLoading;
  final VoidCallback? onTapUpdate;

  const RowSubscriptionsTable({
    super.key,
    required this.subscription,
    required this.isLoading,
    this.onTapUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapUpdate,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.sizeWidth() * 0.02,
          vertical: context.sizeHeight() * 0.01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            // Usuario
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: subscription.userPhoto.isNotEmpty
                        ? NetworkImage(subscription.userPhoto)
                        : null,
                    child: subscription.userPhoto.isEmpty
                        ? Text(
                            subscription.userName[0].toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subscription.userName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          subscription.userEmail,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Precio
            Expanded(
              flex: 1,
              child: Text(
                subscription.formattedPrice,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.green,
                ),
              ),
            ),
            // Fecha Inicio
            Expanded(
              flex: 1,
              child: Text(
                subscription.formattedStartDate,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            // Fecha Fin
            Expanded(
              flex: 1,
              child: Text(
                subscription.formattedEndDate,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            // Días Restantes
            Expanded(
              flex: 1,
              child: Text(
                subscription.daysRemaining.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: subscription.daysRemaining <= 7
                      ? Colors.red
                      : Colors.orange,
                ),
              ),
            ),
            // Progreso
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    subscription.formattedProgress,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  LinearProgressIndicator(
                    value: subscription.progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      subscription.progress == 100 ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
