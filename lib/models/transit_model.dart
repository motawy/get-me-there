class TransitModel {
  Res res;

  TransitModel({this.res});

  TransitModel.fromJson(Map<String, dynamic> json) {
    res = json['Res'] != null ? new Res.fromJson(json['Res']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.res != null) {
      data['Res'] = this.res.toJson();
    }
    return data;
  }
}

class Res {
  String serviceUrl;
  Connections connections;

  Res({this.serviceUrl, this.connections});

  Res.fromJson(Map<String, dynamic> json) {
    serviceUrl = json['serviceUrl'];
    connections = json['Connections'] != null
        ? new Connections.fromJson(json['Connections'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceUrl'] = this.serviceUrl;
    if (this.connections != null) {
      data['Connections'] = this.connections.toJson();
    }
    return data;
  }
}

class Connections {
  String validUntil;
  String context;
  List<Connection> connection;
  Operators operators;

  Connections({this.validUntil, this.context, this.connection, this.operators});

  Connections.fromJson(Map<String, dynamic> json) {
    validUntil = json['valid_until'];
    context = json['context'];
    if (json['Connection'] != null) {
      connection = new List<Connection>();
      json['Connection'].forEach((v) {
        connection.add(new Connection.fromJson(v));
      });
    }
    operators = json['Operators'] != null
        ? new Operators.fromJson(json['Operators'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valid_until'] = this.validUntil;
    data['context'] = this.context;
    if (this.connection != null) {
      data['Connection'] = this.connection.map((v) => v.toJson()).toList();
    }
    if (this.operators != null) {
      data['Operators'] = this.operators.toJson();
    }
    return data;
  }
}

class Connection {
  String id;
  String duration;
  int transfers;
  DepMain depMain;
  Arr arrMain;
  Sections sections;
  Dep dep;
  Arr arr;

  Connection(
      {this.id,
      this.duration,
      this.transfers,
      this.depMain,
      this.arrMain,
      this.sections,
      this.dep,
      this.arr});

  Connection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    duration = json['duration'];
    transfers = json['transfers'];
    depMain =
        json['DepMain'] != null ? new DepMain.fromJson(json['DepMain']) : null;
    arrMain =
        json['ArrMain'] != null ? new Arr.fromJson(json['ArrMain']) : null;
    sections = json['Sections'] != null
        ? new Sections.fromJson(json['Sections'])
        : null;
    dep = json['Dep'] != null ? new Dep.fromJson(json['Dep']) : null;
    arr = json['Arr'] != null ? new Arr.fromJson(json['Arr']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['duration'] = this.duration;
    data['transfers'] = this.transfers;
    if (this.depMain != null) {
      data['DepMain'] = this.depMain.toJson();
    }
    if (this.arrMain != null) {
      data['ArrMain'] = this.arrMain.toJson();
    }
    if (this.sections != null) {
      data['Sections'] = this.sections.toJson();
    }
    if (this.dep != null) {
      data['Dep'] = this.dep.toJson();
    }
    if (this.arr != null) {
      data['Arr'] = this.arr.toJson();
    }
    return data;
  }
}

class DepMain {
  String time;
  Addr addr;

  DepMain({this.time, this.addr});

  DepMain.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    addr = json['Addr'] != null ? new Addr.fromJson(json['Addr']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    if (this.addr != null) {
      data['Addr'] = this.addr.toJson();
    }
    return data;
  }
}

class Addr {
  double y;
  double x;

  Addr({this.y, this.x});

  Addr.fromJson(Map<String, dynamic> json) {
    y = json['y'];
    x = json['x'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['y'] = this.y;
    data['x'] = this.x;
    return data;
  }
}

class Sections {
  List<Sec> sec;

  Sections({this.sec});

  Sections.fromJson(Map<String, dynamic> json) {
    if (json['Sec'] != null) {
      sec = new List<Sec>();
      json['Sec'].forEach((v) {
        sec.add(new Sec.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sec != null) {
      data['Sec'] = this.sec.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sec {
  String id;
  int mode;
  Dep dep;
  Journey journey;
  Arr arr;

  Sec({this.id, this.mode, this.dep, this.journey, this.arr});

  Sec.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mode = json['mode'];
    dep = json['Dep'] != null ? new Dep.fromJson(json['Dep']) : null;
    journey =
        json['Journey'] != null ? new Journey.fromJson(json['Journey']) : null;
    arr = json['Arr'] != null ? new Arr.fromJson(json['Arr']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mode'] = this.mode;
    if (this.dep != null) {
      data['Dep'] = this.dep.toJson();
    }
    if (this.journey != null) {
      data['Journey'] = this.journey.toJson();
    }
    if (this.arr != null) {
      data['Arr'] = this.arr.toJson();
    }
    return data;
  }
}

class Dep {
  String time;
  Addr addr;
  Transport transport;
  Stn stn;
  Freq freq;

  Dep({this.time, this.addr, this.transport, this.stn, this.freq});

  Dep.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    addr = json['Addr'] != null ? new Addr.fromJson(json['Addr']) : null;
    transport = json['Transport'] != null
        ? new Transport.fromJson(json['Transport'])
        : null;
    stn = json['Stn'] != null ? new Stn.fromJson(json['Stn']) : null;
    freq = json['Freq'] != null ? new Freq.fromJson(json['Freq']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    if (this.addr != null) {
      data['Addr'] = this.addr.toJson();
    }
    if (this.transport != null) {
      data['Transport'] = this.transport.toJson();
    }
    if (this.stn != null) {
      data['Stn'] = this.stn.toJson();
    }
    if (this.freq != null) {
      data['Freq'] = this.freq.toJson();
    }
    return data;
  }
}

class Transport {
  int mode;
  String dir;
  String name;
  At at;

  Transport({this.mode, this.dir, this.name, this.at});

  Transport.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    dir = json['dir'];
    name = json['name'];
    at = json['At'] != null ? new At.fromJson(json['At']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    data['dir'] = this.dir;
    data['name'] = this.name;
    if (this.at != null) {
      data['At'] = this.at.toJson();
    }
    return data;
  }
}

class At {
  String category;
  String color;
  String textColor;
  String operator;

  At({this.category, this.color, this.textColor, this.operator});

  At.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    color = json['color'];
    textColor = json['textColor'];
    operator = json['operator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['color'] = this.color;
    data['textColor'] = this.textColor;
    data['operator'] = this.operator;
    return data;
  }
}

class Stn {
  double y;
  double x;
  String name;
  String id;

  Stn({this.y, this.x, this.name, this.id});

  Stn.fromJson(Map<String, dynamic> json) {
    y = json['y'];
    x = json['x'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['y'] = this.y;
    data['x'] = this.x;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class Freq {
  int min;
  int max;
  List<AltDep> altDep;

  Freq({this.min, this.max, this.altDep});

  Freq.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
    if (json['AltDep'] != null) {
      altDep = new List<AltDep>();
      json['AltDep'].forEach((v) {
        altDep.add(new AltDep.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = this.min;
    data['max'] = this.max;
    if (this.altDep != null) {
      data['AltDep'] = this.altDep.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AltDep {
  String time;
  Transport transport;

  AltDep({this.time, this.transport});

  AltDep.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    transport = json['Transport'] != null
        ? new Transport.fromJson(json['Transport'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    if (this.transport != null) {
      data['Transport'] = this.transport.toJson();
    }
    return data;
  }
}

class Journey {
  int distance;
  String duration;
  List<Stop> stop;
  int iGuide;

  Journey({this.distance, this.duration, this.stop, this.iGuide});

  Journey.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    duration = json['duration'];
    if (json['Stop'] != null) {
      stop = new List<Stop>();
      json['Stop'].forEach((v) {
        stop.add(new Stop.fromJson(v));
      });
    }
    iGuide = json['_guide'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['duration'] = this.duration;
    if (this.stop != null) {
      data['Stop'] = this.stop.map((v) => v.toJson()).toList();
    }
    data['_guide'] = this.iGuide;
    return data;
  }
}

class Stop {
  String dep;
  Stn stn;
  String arr;

  Stop({this.dep, this.stn, this.arr});

  Stop.fromJson(Map<String, dynamic> json) {
    dep = json['dep'];
    stn = json['Stn'] != null ? new Stn.fromJson(json['Stn']) : null;
    arr = json['arr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dep'] = this.dep;
    if (this.stn != null) {
      data['Stn'] = this.stn.toJson();
    }
    data['arr'] = this.arr;
    return data;
  }
}

class Arr {
  String time;
  Stn stn;
  Addr addr;

  Arr({this.time, this.stn, this.addr});

  Arr.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    stn = json['Stn'] != null ? new Stn.fromJson(json['Stn']) : null;
    addr = json['Addr'] != null ? new Addr.fromJson(json['Addr']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    if (this.stn != null) {
      data['Stn'] = this.stn.toJson();
    }
    if (this.addr != null) {
      data['Addr'] = this.addr.toJson();
    }
    return data;
  }
}

class Operators {
  List<Op> op;

  Operators({this.op});

  Operators.fromJson(Map<String, dynamic> json) {
    if (json['Op'] != null) {
      op = new List<Op>();
      json['Op'].forEach((v) {
        op.add(new Op.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.op != null) {
      data['Op'] = this.op.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Op {
  String code;
  String type;
  String name;
  String shortName;
  List<Link> link;

  Op({this.code, this.type, this.name, this.shortName, this.link});

  Op.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    type = json['type'];
    name = json['name'];
    shortName = json['short_name'];
    if (json['Link'] != null) {
      link = new List<Link>();
      json['Link'].forEach((v) {
        link.add(new Link.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['type'] = this.type;
    data['name'] = this.name;
    data['short_name'] = this.shortName;
    if (this.link != null) {
      data['Link'] = this.link.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Link {
  String type;
  String href;
  String secIds;
  String text;

  Link({this.type, this.href, this.secIds, this.text});

  Link.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    href = json['href'];
    secIds = json['sec_ids'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['href'] = this.href;
    data['sec_ids'] = this.secIds;
    data['text'] = this.text;
    return data;
  }
}
