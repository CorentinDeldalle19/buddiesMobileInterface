class Event extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String date;

  const Event({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Text(subtitle),
        Text(description),
        Text(date),
      ],
    );
  }
}