import 'package:mvvm_flutter_app/main.dart';
import 'package:mvvm_flutter_app/network/api-connect.dart';

List<SubAvatarItem> topType = [
  SubAvatarItem("NoHair", "NoHair", false),
  SubAvatarItem("Eyepatch", "Eyepatch", false),
  SubAvatarItem("Hat", "Hat", false),
  SubAvatarItem("Hijab", "Hijab", false),
  SubAvatarItem("Turban", "Turban", false),
  SubAvatarItem("WinterHat1", "WinterHat1", false)
];
List<SubAvatarItem> accessoriesType = [
  SubAvatarItem("Blank", "Blank", false),
  SubAvatarItem("Kurt", "Kurt", false),
  SubAvatarItem("Prescription01", "Prescription01", false)
];
List<SubAvatarItem> facialHairType = [
  SubAvatarItem("Blank", "Blank", false),
  SubAvatarItem("BeardMedium", "BeardMedium", false),
  SubAvatarItem("BeardLight", "BeardLight", false)
];
List<SubAvatarItem> hairColor = [
  SubAvatarItem("Auburn", "Auburn", false),
  SubAvatarItem("Black", "Black", false),
  SubAvatarItem("Blonde", "Blonde", false)
];
List<SubAvatarItem> clotheType = [
  SubAvatarItem("BlazerShirt", "BlazerShirt", false),
  SubAvatarItem("BlazerSweater", "BlazerSweater", false),
  SubAvatarItem("CollarSweater", "CollarSweater", false)
];
List<SubAvatarItem> clotheColor = [
  SubAvatarItem("Black", "Black", false),
  SubAvatarItem("Blue01", "Blue01", false),
  SubAvatarItem("Blue02", "Blue02", false)
];
List<SubAvatarItem> eyeType = [
  SubAvatarItem("Close", "Close", false),
  SubAvatarItem("Cry", "Cry", false),
  SubAvatarItem("Dizzy", "Dizzy", false)
];
List<SubAvatarItem> eyebrowType = [
  SubAvatarItem("Angry", "Angry", false),
  SubAvatarItem("AngryNatural", "AngryNatural", false),
  SubAvatarItem("Default", "Default", false)
];
List<SubAvatarItem> mouthType = [
  SubAvatarItem("Concerned", "Concerned", false),
  SubAvatarItem("Disbelief", "Disbelief", false),
  SubAvatarItem("Eating", "Eating", false)
];
List<SubAvatarItem> skinColor = [
  SubAvatarItem("Tanned", "Tanned", false),
  SubAvatarItem("Yellow", "Yellow", false),
  SubAvatarItem("Pale", "Pale", false),
];

class SubAvatarItem {
  String libApi;
  String libUI;
  bool isUnlock;

  SubAvatarItem(
    this.libApi,
    this.libUI,
    this.isUnlock
  );

  static List<SubAvatarItem> getALLSubAvatarItem(){
    List<SubAvatarItem> l =[];
        l+=topType;
        l+=accessoriesType;
        l+=facialHairType;
        l+=hairColor;
        l+=clotheType;
        l+=clotheColor;
        l+=eyeType;
        l+=eyebrowType;
        l+=mouthType;
        l+=skinColor;
        return l;
  }

  static SubAvatarItem getSubAvatarItemFrom(String lib){
    for (SubAvatarItem sub in SubAvatarItem.getALLSubAvatarItem()){
      if(sub.libApi == lib){
        return sub;
      }

    }
  }


}

class Avatar {
  SubAvatarItem top = topType[0];
  SubAvatarItem accessories = accessoriesType[0];
  SubAvatarItem hairColo = hairColor[0];
  SubAvatarItem facialHair = facialHairType[0];
  SubAvatarItem clothe = clotheType[0];
  SubAvatarItem clotheColo = clotheColor[0];
  SubAvatarItem eye = eyeType[0];
  SubAvatarItem eyebrow = eyebrowType[0];
  SubAvatarItem mouth = mouthType[0];
  SubAvatarItem skinColo = skinColor[0];

  Avatar() {
    this.top = topType[0];
    this.accessories = accessoriesType[0];
    this.hairColo = hairColor[0];
    this.facialHair = facialHairType[0];
    this.clothe = clotheType[0];
    this.clotheColo = clotheColor[0];
    this.eye = eyeType[0];
    this.eyebrow = eyebrowType[0];
    this.mouth = mouthType[0];
    this.skinColo = skinColor[0];
  }


    String getImageUrl(){
      return "https://avataaars.io/?accessoriesType=" + this.accessories.libApi
          +"&avatarStyle=Circle&clotheType=" + this.clothe.libApi
          + "&eyeType="+this.eye.libApi+"&eyebrowType="+this.eyebrow.libApi
          +"&facialHairType="+this.facialHair.libApi+"&hairColor="+this.hairColo.libApi
          +"&mouthType=" +this.mouth.libApi+"&skinColor="+ this.skinColo.libApi
          +"&topType="+this.top.libApi+"&clotheColor="+this.clothe.libApi;
    }

    void setAvataarParameters({top,accessories,hairColo,facialHair,clothe,clotheColo,eye,eyebrow,mouth,skinColo}){
      if(top!=null)
        this.top = top;
      if(accessories!=null)
        this.accessories = accessories;
      if(hairColo!=null)
        this.hairColo = hairColo;
      if(facialHair!=null)
        this.facialHair = facialHair;
      if(clothe!=null)
        this.clothe = clothe;
      if(clotheColo!=null)
        this.clotheColo = clotheColo;
      if(eye!=null)
        this.eye = eye;
      if(eyebrow!=null)
        this.eyebrow = eyebrow;
      if(mouth!=null)
        this.mouth = mouth;
      if(skinColo!=null)
        this.skinColo = skinColo;
    }



}

