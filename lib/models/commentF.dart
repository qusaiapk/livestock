class CommentF {
  int id;
  String askname;
  String mesage;
  List<Funanswer> funanswer;

  CommentF({this.id, this.askname, this.mesage, this.funanswer});

  CommentF.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    askname = json['askname'];
    mesage = json['mesage'];
    if (json['funanswer'] != null) {
      funanswer = <Funanswer>[];
      json['funanswer'].forEach((v) {
        funanswer.add(new Funanswer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['askname'] = this.askname;
    data['mesage'] = this.mesage;
    if (this.funanswer != null) {
      data['funanswer'] = this.funanswer.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Funanswer {
  int id;
  String answer;
  String doctorname;
  int askId;

  Funanswer({this.id, this.answer, this.doctorname, this.askId});

  Funanswer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    answer = json['answer'];
    doctorname = json['doctorname'];
    askId = json['ask_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['answer'] = this.answer;
    data['doctorname'] = this.doctorname;
    data['ask_id'] = this.askId;
    return data;
  }
}
