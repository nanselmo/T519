
PImage veryHappyImg;
PImage happyImg;
PImage neutralImg;
PImage sadImg;
PImage verySadImg;

void setup()
{
  // GUI setup
  size(displayWidth,displayHeight);
  
  // Images must be in the "data" directory to load correctly
  veryHappyImg = loadImage("veryhappy.png");
  happyImg = loadImage("happy.png");
  neutralImg = loadImage("neutral.png");
  sadImg = loadImage("sad.png");
  verySadImg = loadImage("verysad.png");
  
  setup_tuio();
}

// within the draw method we retrieve an ArrayList of type <TuioObject>
// from the TuioProcessing client and then loops over all lists to draw the graphical feedback.
void draw()
{
  background(255);
  textFont(font,18*scale_factor);
  

  fill(0);  
  textSize(48);
  text("MOOD METER",800,50);  
  fill(255);
  rect(30,90,1000,700);
  
  float obj_size = object_size*scale_factor; 
  float startSpot = 0;
  Boolean startSpotMarked = false;
  


  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0;i<tuioObjectList.size();i++) {
     TuioObject tobj = tuioObjectList.get(i);
     // we retrieve some information about this fiducial marker
     int id = tobj.getSymbolID();
     float angle = tobj.getAngle();
     int x = tobj.getScreenX(width);
     int y = tobj.getScreenY(height);
     
     String gamePiece = getGamePiece(id);
     
     
     //for the spinner
     if(gamePiece == "spinnerPiece"){
       String studentName = getStudentName(angle);
       fill(#163DD6);  
       textSize(36);
       text("Name: " + studentName,1200,50);     
     }
     
     //for the slider
     if  (gamePiece == "sliderStartPiece" || gamePiece == "sliderStopPiece"){
       if (gamePiece == "sliderStartPiece"){
         startSpot = x;
       //startSpotMarked = true; //don't need to keep checking this
       }
       
       if (gamePiece == "sliderStopPiece"){
         float endSpot = x;
         float sliderDistance = endSpot - startSpot;
         String studentEmotion = getStudentEmotion(sliderDistance);
         PImage emotionImg = veryHappyImg;
         image(emotionImg, (x-60),y, emotionImg.width/10, emotionImg.height/10);
         fill(#1D9594);
         textSize(36);
         text("Emotion: " + studentEmotion, 1500, 50);
       }
     }
     
     //to finish your emotion checkin
     if (gamePiece == "completePiece") {
       fill(#932222);  
       textSize(72);
       text("Thanks for Checking In", 30, 60);
     }
     
     
     //lets try it as a property of the TuioObject class?
     //tobj.markerName = gamePiece;
     
   }
}

String getGamePiece(int tuioObjID){
  String nameOfPiece ;
   if(tuioObjID==0){
     nameOfPiece = "completePiece";
   }
   else if (tuioObjID==1){
     nameOfPiece = "spinnerPiece";
   } 
   else if (tuioObjID==4){
     nameOfPiece = "sliderStartPiece";
   }
   else if (tuioObjID==29){
     nameOfPiece = "sliderStopPiece";
   }
   else {
      nameOfPiece = "unidentifiedPiece";
   }
   return nameOfPiece;
}

String getStudentName(float spinnerAngle){
  
   String stuName = "Unknown";
   String[] names= {"Lilly", "Raegan", "James", "Raven", "A'mya", "Cedric", "Sarah", "Charlie"};
   int numOfStu = names.length;
   float degreeInterval = (2*3.14)/numOfStu;
   float degreeBuffer = degreeInterval/4 ;
   int spinnerSectionNum = 0;
   if (spinnerAngle <= degreeInterval) {
     spinnerSectionNum = 0;
   }
   else {
     spinnerSectionNum = int(spinnerAngle/degreeInterval);
   } 
   
   //cheat this for now, why would section number be 8?
   if (spinnerSectionNum !=8) {
     stuName = names[spinnerSectionNum];
   }
    return  stuName;
}

String getStudentEmotion(float sliderLength){
  
   String stuEmotion = "Unknown";
   String[] emotions= {"Very Sad", "Sad", "Neutral", "Happy", "Very Happy"};
   int numOfEmotions = emotions.length;
   int startingDistance = 430;
   float emotionInterval = startingDistance/(numOfEmotions-1);
   int emotionSectionNum = 0;
   

    emotionSectionNum = int(sliderLength/emotionInterval);
  
   fill(#5E10DE);     

   if (emotionSectionNum>=5){
     emotionSectionNum = 4;
   }
   stuEmotion = emotions[emotionSectionNum];

   return  stuEmotion;
}






//public class extraTuioInfo extends TuioObject {
//  private String title;

//  public extraTuioInfo(int id, String markerName){
//    super(id); //calls the constructor in the parent class to initialize the marker id
//    this.markerName= markerName;
//  }      

//  public String getMarkerName(){
//    return this.markerName;
//  }

//  public void setMarkerName(String markerName) {
//    this.markerName= markerName;
//  }
//}
