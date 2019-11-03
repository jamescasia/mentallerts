class AccountInfo {
  String displayName;
  String handle;
  String displayPhotoSource;

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "handle": handle,
        "displayPhotoSource": displayPhotoSource,
      };

  AccountInfo.fromStorageJson(Map<String, dynamic> json)
      : displayName = json["displayName"],
        handle = json['handle'],
        displayPhotoSource = json['displayPhotoSource'];
}

