import 'package:ltdmed/fhir/primitive.dart';

class VAttachment {
  VCode? contentType; // MIME type of the attachment
  VCode? language; // Language of the attachment
  Vbase64Binary? data; // Base64 encoded data of the attachment
  Vurl? url; // URL of the attachment
  Vinteger64? size; // Size of the attachment in bytes
  Vbase64Binary? hash; // Hash of the attachment data
  Vstring? title; // Title of the attachment
  VdateTime? creation; // Creation date of the attachment
  VpositiveInt? height; // Height of the attachment (if applicable)
  VpositiveInt? width; // Width of the attachment (if applicable)
  VpositiveInt? frames; // Number of frames (if applicable)
  Vdecimal? duration; // Duration of the attachment (if applicable)
  VpositiveInt? pages; // Number of pages (if applicable)

  VAttachment({
    this.contentType,
    this.language,
    this.data,
    this.url,
    this.size,
    this.hash,
    this.title,
    this.creation,
    this.height,
    this.width,
    this.frames,
    this.duration,
    this.pages,
  });

  Map<String, dynamic> toJson() {
    return {
      'contentType': contentType,
      'language': language,
      'data': data,
      'url': url,
      'size': size,
      'hash': hash,
      'title': title,
      'creation': creation,
      'height': height,
      'width': width,
      'frames': frames,
      'duration': duration,
      'pages': pages,
    }..removeWhere((key, value) => value == null);
  }

  factory VAttachment.fromJson(Map<String, dynamic> json) {
    return VAttachment(
      contentType: json['contentType'],
      language: json['language'],
      data: json['data'],
      url: json['url'],
      size: json['size'],
      hash: json['hash'],
      title: json['title'],
      creation: json['creation'],
      height: json['height'],
      width: json['width'],
      frames: json['frames'],
      duration: json['duration'],
      pages: json['pages'],
    );
  }
}
