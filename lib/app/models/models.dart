class Project {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String liveUrl;
  final String githubUrl;
  final List<String> technologies;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.liveUrl,
    required this.githubUrl,
    required this.technologies,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      liveUrl: json['live_url'],
      githubUrl: json['github_url'],
      technologies: List<String>.from(json['technologies']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'live_url': liveUrl,
      'github_url': githubUrl,
      'technologies': technologies,
    };
  }
}

class Certification {
  final String id;
  final String name;
  final String organization;
  final DateTime date;
  final String credentialUrl;
  final String imageUrl;

  Certification({
    required this.id,
    required this.name,
    required this.organization,
    required this.date,
    required this.credentialUrl,
    required this.imageUrl,
  });

  factory Certification.fromJson(Map<String, dynamic> json) {
    return Certification(
      id: json['id'],
      name: json['name'],
      organization: json['organization'],
      date: DateTime.parse(json['date']),
      credentialUrl: json['credential_url'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'organization': organization,
      'date': date.toIso8601String(),
      'credential_url': credentialUrl,
      'image_url': imageUrl,
    };
  }
}

class Testimonial {
  final String id;
  final String quote;
  final String clientName;
  final String clientCompany;

  Testimonial({
    required this.id,
    required this.quote,
    required this.clientName,
    required this.clientCompany,
  });

  factory Testimonial.fromJson(Map<String, dynamic> json) {
    return Testimonial(
      id: json['id'],
      quote: json['quote'],
      clientName: json['client_name'],
      clientCompany: json['client_company'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quote': quote,
      'client_name': clientName,
      'client_company': clientCompany,
    };
  }
}

class ContactMessage {
  final String id;
  final String name;
  final String email;
  final String subject;
  final String message;
  final DateTime timestamp;

  ContactMessage({
    required this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    required this.timestamp,
  });

  factory ContactMessage.fromJson(Map<String, dynamic> json) {
    return ContactMessage(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      subject: json['subject'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}