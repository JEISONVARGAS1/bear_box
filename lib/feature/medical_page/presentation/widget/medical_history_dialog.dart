import 'package:bearbox/core/model/user_medical_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';

class MedicalHistoryDialog extends StatefulWidget {
  final UserModel user;
  final List<UserMedicalData> medicalHistory;

  const MedicalHistoryDialog({
    super.key,
    required this.user,
    required this.medicalHistory,
  });

  @override
  State<MedicalHistoryDialog> createState() => _MedicalHistoryDialogState();
}

class _MedicalHistoryDialogState extends State<MedicalHistoryDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.medical_services, color: MyFitUiKit.util.color.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Historial Médico",
              style: MyFitUiKit.util.textStyle.titleL.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Usuario: ${widget.user.name}",
              style: MyFitUiKit.util.textStyle.subTitle.copyWith(
                fontWeight: FontWeight.w600,
                color: MyFitUiKit.util.color.primary,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: widget.medicalHistory.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.medical_information_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No hay historial médico",
                            style: MyFitUiKit.util.textStyle.subTitle.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Aún no se han registrado datos médicos",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: widget.medicalHistory.length,
                      itemBuilder: (context, index) {
                        final medicalData = widget.medicalHistory[index];
                        return MedicalHistoryExpansionTile(
                          medicalData: medicalData,
                          index: index,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Cerrar",
            style: TextStyle(
              color: MyFitUiKit.util.color.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class MedicalHistoryExpansionTile extends StatefulWidget {
  final UserMedicalData medicalData;
  final int index;

  const MedicalHistoryExpansionTile({
    super.key,
    required this.medicalData,
    required this.index,
  });

  @override
  State<MedicalHistoryExpansionTile> createState() =>
      _MedicalHistoryExpansionTileState();
}

class _MedicalHistoryExpansionTileState
    extends State<MedicalHistoryExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final dateString = dateFormat.format(widget.medicalData.dateCreate);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 2,
      child: ExpansionTile(
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        leading: CircleAvatar(
          backgroundColor: MyFitUiKit.util.color.primary,
          child: Text(
            "${widget.index + 1}",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          "Registro del $dateString",
          style: MyFitUiKit.util.textStyle.subTitle.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "Peso: ${widget.medicalData.weight?.toStringAsFixed(1) ?? 'N/A'} kg | Altura: ${widget.medicalData.height?.toStringAsFixed(2) ?? 'N/A'} m | BMI: ${widget.medicalData.bmi?.toStringAsFixed(1) ?? 'N/A'}",
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        trailing: Icon(
          _isExpanded ? Icons.expand_less : Icons.expand_more,
          color: MyFitUiKit.util.color.primary,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection("Medidas Básicas", [
                  _buildInfoRow(
                    "Peso",
                    "${widget.medicalData.weight?.toStringAsFixed(1) ?? 'N/A'} kg",
                  ),
                  _buildInfoRow(
                    "Altura",
                    "${widget.medicalData.height?.toStringAsFixed(2) ?? 'N/A'} m",
                  ),
                  _buildInfoRow(
                    "BMI",
                    widget.medicalData.bmi?.toStringAsFixed(1) ?? 'N/A',
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSection("Composición Corporal", [
                  _buildInfoRow(
                    "Grasa corporal",
                    "${widget.medicalData.fatPercentage?.toStringAsFixed(1) ?? 'N/A'}%",
                  ),
                  _buildInfoRow(
                    "Músculo",
                    "${widget.medicalData.musclePercentage?.toStringAsFixed(1) ?? 'N/A'}%",
                  ),
                  _buildInfoRow(
                    "RM kcal",
                    "${widget.medicalData.rmKcal?.toStringAsFixed(0) ?? 'N/A'} kcal",
                  ),
                  _buildInfoRow(
                    "Edad corporal",
                    "${widget.medicalData.bodyAge ?? 'N/A'} años",
                  ),
                  _buildInfoRow(
                    "Grasa visceral",
                    widget.medicalData.visceralFat?.toStringAsFixed(1) ?? 'N/A',
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSection("Signos Vitales", [
                  _buildInfoRow(
                    "FC reposo",
                    "${widget.medicalData.restingHeartRate ?? 'N/A'} bpm",
                  ),
                  _buildInfoRow(
                    "SO2",
                    "${widget.medicalData.so2Percentage?.toStringAsFixed(1) ?? 'N/A'}%",
                  ),
                  _buildInfoRow(
                    "Presión arterial",
                    "${widget.medicalData.systolicPressure ?? 'N/A'}/${widget.medicalData.diastolicPressure ?? 'N/A'} mmHg",
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSection("Antecedentes Médicos", [
                  _buildInfoRow(
                    "Antecedentes de enfermedades",
                    widget.medicalData.hasDiseases,
                  ),
                  _buildInfoRow("Dolores", widget.medicalData.hasPain),
                ]),
                if (widget.medicalData.medicalObservation.isNotEmpty ==
                    true) ...[
                  const SizedBox(height: 16),
                  _buildSection("Observaciones", [
                    _buildInfoRow(
                      "Observación médica",
                      widget.medicalData.medicalObservation.isNotEmpty
                          ? widget.medicalData.medicalObservation
                          : 'Sin observaciones',
                    ),
                  ]),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: MyFitUiKit.util.textStyle.subTitle.copyWith(
            fontWeight: FontWeight.bold,
            color: MyFitUiKit.util.color.primary,
          ),
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
