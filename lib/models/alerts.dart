class Welcome {
    bool ok;
    List<Alert> alerts;

    Welcome({
        required this.ok,
        required this.alerts,
    });

}

class Alert {
    String id;
    String document;
    String email;
    String name;
    DateTime date;
    String type;
    String tags;
    String entity;
    String status;
    String message;
    String urlImage;

    Alert({
        required this.id,
        required this.document,
        required this.email,
        required this.name,
        required this.date,
        required this.type,
        required this.tags,
        required this.entity,
        required this.status,
        required this.message,
        required this.urlImage,
    });

}
