import 'package:mvvm_flutter_app/main.dart';
import 'package:mvvm_flutter_app/network/api-connect.dart';

List<SubAvatarItem> topType = [
  SubAvatarItem("NoHair", "Boule à z", true),
  SubAvatarItem("Eyepatch", "Cache oeil", false),
  SubAvatarItem("Hat", "Chapeau", true),
  SubAvatarItem("Hijab", "Voile", false),
  SubAvatarItem("Turban", "Turban", false),
  SubAvatarItem("WinterHat1", "Chapeau d'hiver 1", true),
  SubAvatarItem("LongHairBob", "Coupe au carré", false),
  SubAvatarItem("WinterHat3", "Chapeau d'hiver 2", false),
  SubAvatarItem("WinterHat4", "Chapeau d'hiver 3", false),
  SubAvatarItem("LongHairBigHair", "Cheveux ondulés", false),
  SubAvatarItem("LongHairBun", "Chignon", false),
  SubAvatarItem("LongHairCurly", "Long cheveux bouclés", false),
  SubAvatarItem("LongHairCurvy", "Cheveux bouclés", true),
  SubAvatarItem("LongHairDreads", "Dreadlocks", false),
  SubAvatarItem("LongHairFrida", "Cheveux fleuris", false),
  SubAvatarItem("LongHairFro", "Coupe afro", false),
  SubAvatarItem("LongHairFroBand", "Coupe afro + bandeau", false),
  SubAvatarItem("LongHairNotTooLong", "mi-long", false),
  SubAvatarItem("LongHairShavedSides", "long et rasés sur les côtés", false),
  SubAvatarItem("ShortHairCaesarSidePart", "court stylé", false),
];
List<SubAvatarItem> accessoriesType = [
  SubAvatarItem("Blank", "Blank", true),
  SubAvatarItem("Kurt", "Kurt", true),
  SubAvatarItem("Prescription01", "Prescription01", false)
];
List<SubAvatarItem> facialHairType = [
  SubAvatarItem("Blank", "Blank", true),
  SubAvatarItem("BeardMedium", "BeardMedium", true),
  SubAvatarItem("BeardLight", "BeardLight", false)
];
List<SubAvatarItem> hairColor = [
  SubAvatarItem("Auburn", "Auburn", true),
  SubAvatarItem("Black", "Black", true),
  SubAvatarItem("Blonde", "Blonde", false)
];
List<SubAvatarItem> clotheType = [
  SubAvatarItem("BlazerShirt", "BlazerShirt", true),
  SubAvatarItem("BlazerSweater", "BlazerSweater", true),
  SubAvatarItem("CollarSweater", "CollarSweater", false)
];
List<SubAvatarItem> clotheColor = [
  SubAvatarItem("Black", "Black", true),
  SubAvatarItem("Blue01", "Blue01", true),
  SubAvatarItem("Blue02", "Blue02", false)
];
List<SubAvatarItem> eyeType = [
  SubAvatarItem("Close", "Close", true),
  SubAvatarItem("Cry", "Cry", true),
  SubAvatarItem("Dizzy", "Dizzy", false)
];
List<SubAvatarItem> eyebrowType = [
  SubAvatarItem("Angry", "Angry", true),
  SubAvatarItem("AngryNatural", "AngryNatural", false),
  SubAvatarItem("Default", "Default", true)
];
List<SubAvatarItem> mouthType = [
  SubAvatarItem("Concerned", "Concerned", true),
  SubAvatarItem("Disbelief", "Disbelief", true),
  SubAvatarItem("Eating", "Eating", false)
];
List<SubAvatarItem> skinColor = [
  SubAvatarItem("Tanned", "Tanned", true),
  SubAvatarItem("Yellow", "Yellow", false),
  SubAvatarItem("Pale", "Pale", true),
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


    void setAvataarParameters({String top,String accessories,String hairColo,String facialHair,String clothe,String clotheColo,String eye,String eyebrow,String mouth,String skinColo}){
      if(top!=null)
        this.top = SubAvatarItem.getSubAvatarItemFrom(top);
      if(accessories!=null)
        this.accessories = SubAvatarItem.getSubAvatarItemFrom(accessories);
      if(hairColo!=null)
        this.hairColo = SubAvatarItem.getSubAvatarItemFrom(hairColo);
      if(facialHair!=null)
        this.facialHair = SubAvatarItem.getSubAvatarItemFrom(facialHair);
      if(clothe!=null)
        this.clothe = SubAvatarItem.getSubAvatarItemFrom(clothe);
      if(clotheColo!=null)
        this.clotheColo = SubAvatarItem.getSubAvatarItemFrom(clotheColo);
      if(eye!=null)
        this.eye = SubAvatarItem.getSubAvatarItemFrom(eye);
      if(eyebrow!=null)
        this.eyebrow = SubAvatarItem.getSubAvatarItemFrom(eyebrow);
      if(mouth!=null)
        this.mouth = SubAvatarItem.getSubAvatarItemFrom(mouth);
      if(skinColo!=null)
        this.skinColo = SubAvatarItem.getSubAvatarItemFrom(skinColo);
    }

  String getApiArray() {
    return "[" + this.accessories.libApi
        +"," + this.clothe.libApi
        + ","+this.eye.libApi+","+this.eyebrow.libApi
        +","+this.facialHair.libApi+","+this.hairColo.libApi
        +"," +this.mouth.libApi+","+ this.skinColo.libApi
        +","+this.top.libApi+","+this.clotheColo.libApi+"]";
  }



}

