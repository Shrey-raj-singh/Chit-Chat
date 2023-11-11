class chatModel {
  String name;
  bool isGroup;
  String time;
  String currentMessage;
  String status;
  bool select = false;
  chatModel(
      {required this.name,
      required this.isGroup,
      required this.time,
      required this.currentMessage,
      required this.status,
      this.select = false});
}
