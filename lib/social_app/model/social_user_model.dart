class socialUserModel
{
  String? name;
  String? phone;
  String? uId;
  String? email;
  String? image;
  String? bio;
  String? cover;

  bool? isEmailVerified;
  socialUserModel({
    this.email,
    this.cover,
    this.name,
    this.phone,
    this.uId,
    this.isEmailVerified,
    this.image,
    this.bio,
});

  socialUserModel.fromJson(Map<String,dynamic> json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
     bio = json['bio'];
cover = json['cover'];
  }
  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'isEmailVerified':isEmailVerified,
      'image':image,

      'bio':bio,
      'cover':cover,
    };
  }
}