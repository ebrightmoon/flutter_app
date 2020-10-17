class Response<T> {
  int code;
  String msg;
  T data;

  Response(this.code, this.msg, this.data);

  Response.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['data'] = this.data;
    return data;
  }

  @override
  String toString() {
    return 'Response{code: $code, errorMsg: $msg, data: $data}';
  }
}
