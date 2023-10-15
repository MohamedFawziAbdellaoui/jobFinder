class Job {
  String? sId;
  String? title;
  String? description;
  String? contract;
  String? entrepriseId;
  bool? isContractSigned;
  String? duration;
  List<String>? applicantsIds;
  int? price;
  String? pricingType;
  String? createdAt;
  String? updatedAt;
  String? address;
  String? endDate;
  String? startDate;
  String? startTime;
  String? endTime;
  Job(
      {this.sId,
      this.title,
      this.description,
      this.contract,
      this.entrepriseId,
      this.isContractSigned,
      this.duration,
      this.applicantsIds,
      this.price,
      this.pricingType,
      this.createdAt,
      this.updatedAt,
      this.address,
      this.endDate,
      this.startDate});

  Job.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    contract = json['contract'];
    entrepriseId = json['entreprise_id'];
    isContractSigned = json['is_contract_signed'];
    duration = json['duration'];
    applicantsIds = json['applicants_ids'].cast<String>();
    price = json['price'];
    pricingType = json['pricing_type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    address = json['address'];
    endDate = json['endDate'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    endTime = json["endTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['contract'] = contract;
    data['entreprise_id'] = entrepriseId;
    data['is_contract_signed'] = isContractSigned;
    data['duration'] = duration;
    data['applicants_ids'] = applicantsIds;
    data['price'] = price;
    data['pricing_type'] = pricingType;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['address'] = address;
    data['endDate'] = endDate;
    data['startDate'] = startDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    return data;
  }
}
