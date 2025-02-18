extension DateFormatter on DateTime {
  static const List<String> months = [
    'janeiro',
    'fevereiro',
    'março',
    'abril',
    'maio',
    'junho',
    'julho',
    'agosto',
    'setembro',
    'outubro',
    'novembro',
    'dezembro',
  ];

  String formatFullDate() {
    // Dia, mês e ano
    int day = this.day;
    String month = months[this.month - 1];
    int year = this.year;

    return '$day de $month de $year';
  }

  String formatDate() {
    // Dia, mês e ano
    int day = this.day;
    int month = this.month;
    int year = this.year;

    return '$day/$month/$year';
  }

  String formatShortDate() {
    // Dia, mês e ano
    int day = this.day;
    String month = months[this.month - 1];

    return '$day ${month[0].toUpperCase() + month.substring(1)}';
  }
}
