import 'package:bearbox/core/extension/context_extension.dart';
import 'package:bearbox/core/model/subscription_model.dart';
import 'package:bearbox/feature/update_user/presentation/cubit/update_user_cubit.dart';
import 'package:bearbox/feature/update_user/presentation/widget/popup_edit_subscription_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';

class SubscriptionCard extends StatelessWidget {
  final SubscriptionModel subscription;
  final UpdateUserCubit? cubit;

  const SubscriptionCard({super.key, required this.subscription, this.cubit});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd/MMM/yyyy');
    final String startDateFormatted = dateFormat.format(subscription.startDate);
    final String endDateFormatted = dateFormat.format(subscription.endDate);

    final DateTime now = DateTime.now();
    final bool isExpired = subscription.endDate.isBefore(now);
    final bool hasNotStarted = subscription.startDate.isAfter(now);
    final bool isInProgress =
        !isExpired && !hasNotStarted && subscription.isActive;
    final bool isActiveAndNotExpired = subscription.isActive && !isExpired;

    return Container(
      width: context.sizeWidth(0.25),
      margin: EdgeInsets.only(right: 15),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isActiveAndNotExpired
                  ? [
                      MyFitUiKit.util.color.primary.withOpacity(0.2),
                      MyFitUiKit.util.color.primary.withOpacity(0.5),
                    ]
                  : [
                      MyFitUiKit.util.color.cardDark.withOpacity(0.2),
                      MyFitUiKit.util.color.cardDark.withOpacity(0.5),
                    ],
            ),
            border: Border.all(
              color: isActiveAndNotExpired
                  ? MyFitUiKit.util.color.primary.withOpacity(0.5)
                  : Colors.red.withOpacity(0.5),
              width: 2,
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con precio y estado
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Precio destacado
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "\$${subscription.price.toStringAsFixed(0)}",
                      style: MyFitUiKit.util.textStyle.subTitle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  // Indicador de estado
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(
                            isInProgress,
                            isExpired,
                            hasNotStarted,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          _getStatusIcon(
                            isInProgress,
                            isExpired,
                            hasNotStarted,
                          ),
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () => _onEditSubscription(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(
                              isInProgress,
                              isExpired,
                              hasNotStarted,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 15),

              // Estado textual
              Text(
                _getStatusText(isInProgress, isExpired, hasNotStarted),
                style: MyFitUiKit.util.textStyle.text.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),

              SizedBox(height: 12),

              // Fechas
              _buildDateRow(
                icon: Icons.play_arrow_rounded,
                label: "Inicio:",
                date: startDateFormatted,
              ),

              SizedBox(height: 8),

              _buildDateRow(
                icon: Icons.stop_rounded,
                label: "Fin:",
                date: endDateFormatted,
                isEndDate: true,
                isExpired: isExpired,
              ),

              SizedBox(height: 15),

              // Días restantes o vencida
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    _getDaysRemainingText(),
                    style: MyFitUiKit.util.textStyle.text.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateRow({
    required IconData icon,
    required String label,
    required String date,
    bool isEndDate = false,
    bool isExpired = false,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: isEndDate && isExpired
              ? Colors.red.withOpacity(0.8)
              : Colors.white.withOpacity(0.7),
          size: 16,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: MyFitUiKit.util.textStyle.text.copyWith(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 10,
                ),
              ),
              Text(
                date,
                style: MyFitUiKit.util.textStyle.text.copyWith(
                  color: isEndDate && isExpired
                      ? Colors.red.withOpacity(0.9)
                      : Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(bool isInProgress, bool isExpired, bool hasNotStarted) {
    if (isExpired) return Colors.red; // Rojo para expirado
    if (isInProgress) return Colors.green; // Verde para en curso
    if (hasNotStarted) return Colors.blue; // Azul para no iniciado
    return Colors.orange; // Naranja para inactivo
  }

  IconData _getStatusIcon(
    bool isInProgress,
    bool isExpired,
    bool hasNotStarted,
  ) {
    if (isExpired) return Icons.close_rounded; // X para expirado
    if (isInProgress) return Icons.check_rounded; // Check para en curso
    if (hasNotStarted) return Icons.access_time_rounded; // ? para no iniciado
    return Icons.pause_rounded; // Pausa para inactivo
  }

  String _getStatusText(bool isInProgress, bool isExpired, bool hasNotStarted) {
    if (isExpired) return "VENCIDA";
    if (isInProgress) return "EN CURSO";
    if (hasNotStarted) return "PENDIENTE";
    return "INACTIVA";
  }

  String _getDaysRemainingText() {
    final now = DateTime.now();

    // Si aún no ha comenzado
    if (subscription.startDate.isAfter(now)) {
      final daysToStart = subscription.startDate.difference(now).inDays;
      if (daysToStart == 0) {
        return "Comienza hoy";
      } else {
        return "Comienza en $daysToStart días";
      }
    }

    // Si ya comenzó, calcular días restantes
    final difference = subscription.endDate.difference(now).inDays;

    if (difference < 0) {
      return "Vencida hace ${difference.abs()} días";
    } else if (difference == 0) {
      return "Vence hoy";
    } else if (difference <= 7) {
      return "⚠️ Vence en $difference días";
    } else {
      return "Vence en $difference días";
    }
  }

  void _onEditSubscription(BuildContext context) {
    if (cubit != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) => PopupEditSubscriptionPage(
          cubit: cubit!,
          subscription: subscription,
        ),
      );
    }
  }
}
