class Resume {
  String? sId;
  String? file;
  String? userId;
  List<Education>? education;
  List<WorkExperience>? workExperience;
  List<Skills>? skills;
  List<Certifications>? certifications;
  List<Language>? languages;

  Resume({
    this.sId,
    this.file,
    this.userId,
    this.education,
    this.workExperience,
    this.skills,
    this.certifications,
    this.languages,
  });

  Resume.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    file = json['file'];
    userId = json['userId'];
    education = json["education"]
        .map<Education>((data) => Education.fromJson(data))
        .toList();

    workExperience = json["workExperience"]
        .map<WorkExperience>((data) => WorkExperience.fromJson(data))
        .toList();

    skills =
        json["skills"].map<Skills>((data) => Skills.fromJson(data)).toList();

    certifications = json['certifications']
        .map<Certifications>((data) => Certifications.fromJson(data))
        .toList();

    languages = json['languages']
        .map<Language>((data) => Language.fromJson(data))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['file'] = file;
    data['userId'] = userId;
    if (education != null) {
      data['education'] = education!
          .map<Map<dynamic, dynamic>>((data) => data.toJson())
          .toList();
    }
    if (workExperience != null) {
      data['workExperience'] = workExperience!
          .map<Map<dynamic, dynamic>>((data) => data.toJson())
          .toList();
    }
    if (skills != null) {
      data['skills'] =
          skills!.map<Map<dynamic, dynamic>>((data) => data.toJson()).toList();
    }
    if (certifications != null) {
      data['certifications'] = certifications!
          .map<Map<dynamic, dynamic>>((data) => data.toJson())
          .toList();
    }
    if (languages != null) {
      data['languages'] = languages!
          .map<Map<dynamic, dynamic>>((data) => data.toJson())
          .toList();
    }
    return data;
  }
}

class Education {
  String? sId;
  String? schoolName;
  String? degree;
  int? graduationYear;
  int? iV;

  Education(
      {this.sId, this.schoolName, this.degree, this.graduationYear, this.iV});

  Education.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    schoolName = json['schoolName'];
    degree = json['degree'];
    graduationYear = json['graduationYear'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['schoolName'] = schoolName;
    data['degree'] = degree;
    data['graduationYear'] = graduationYear;
    data['__v'] = iV;
    return data;
  }
}

class WorkExperience {
  String? sId;
  String? jobTitle;
  String? company;
  String? startDate;
  String? endDate;
  String? description;
  int? iV;

  WorkExperience(
      {this.sId,
      this.jobTitle,
      this.company,
      this.startDate,
      this.endDate,
      this.description,
      this.iV});

  WorkExperience.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    jobTitle = json['jobTitle'];
    company = json['company'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    description = json['description'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['jobTitle'] = jobTitle;
    data['company'] = company;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['description'] = description;
    data['__v'] = iV;
    return data;
  }
}

class Skills {
  String? sId;
  String? name;
  String? proficiency;
  int? iV;

  Skills({this.sId, this.name, this.proficiency, this.iV});

  Skills.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    proficiency = json['proficiency'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['proficiency'] = proficiency;
    data['__v'] = iV;
    return data;
  }
}

class Certifications {
  String? sId;
  String? name;
  String? issuer;
  String? date;
  String? credentialsLink;
  int? iV;

  Certifications(
      {this.sId,
      this.name,
      this.issuer,
      this.date,
      this.credentialsLink,
      this.iV});

  Certifications.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    issuer = json['issuer'];
    date = json['date'];
    credentialsLink = json['credentialsLink'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['issuer'] = issuer;
    data['date'] = date;
    data['credentialsLink'] = credentialsLink;
    data['__v'] = iV;
    return data;
  }
}

class Language {
  String? id;
  String? name;
  String? proficiency;

  Language({required this.id, required this.name, required this.proficiency});

  Language.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json['name'];
    proficiency = json['proficiency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["_id"] = id;
    data['name'] = name;
    data['proficiency'] = proficiency;
    return data;
  }
}
