import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulated records data
    final List<Map<String, String>> records = [
      {'ID': '1', 'Fecha': '2023-07-01', 'Entidad': 'Policia', 'Estado': "Finalizada / Procesada", 'Alert': 'High'},
      {'ID': '2', 'Fecha': '2023-07-01', 'Entidad': 'Alcaldia','Estado': "Enviada a la entidad", 'Alert': 'Medium'},
      {'ID': '3', 'Fecha': '2023-07-01', 'Entidad': 'Alcaldia','Estado': "En espera", 'Alert': 'Low'},
      {'ID': '4', 'Fecha': '2023-07-01', 'Entidad': 'Alcaldia','Estado': "Creada", 'Alert': 'Low'},
      // Add more records as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Alertas', style: GoogleFonts.exo2(fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: Colors.deepOrange,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      
      ),
      body: Padding(
        
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // _Title(),
          SizedBox(height: 40,),
           SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith((states) => Colors.deepOrange),
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Fecha')),
                DataColumn(label: Text('Entidad')),
                DataColumn(label: Text('Estado')),
                DataColumn(label: Text('Urgencia')),
              ],
              rows: records.map((record) {
                return DataRow(cells: [
                  DataCell(Text(record['ID']!)),
                  DataCell(Text(record['Fecha']!)),
                  DataCell(Text(record['Entidad']!)),
                  DataCell(Text(record['Estado']!)),
                  DataCell(_buildAlertCell(record['Alert']!)),
                ]);
              }).toList(),
            ),
          ),]
        ),
      ),
    );
  }

  Widget _buildAlertCell(String alert) {
    Color color;
    String text;
    switch (alert) {
      case 'High':
        color = Colors.red;
        text = 'Alta';
        break;
      case 'Medium':
        color = Colors.orange;
        text = 'Media';
        break;
      case 'Low':
        color = Colors.green;
        text = 'Baja';
        break;
      default:
        color = Colors.grey;
        text = 'Desconocida';
    }
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Row(children: [
        SizedBox(width: 20),
        Column(
          children: [
            Text(
              'Mis Alertas',
              style: Theme.of(context).textTheme.displayMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        )
      ]),
    );
  }
}