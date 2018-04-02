 //<>//
void setup()
{
  // GUI setup
  size(displayWidth,displayHeight);
  
  setup_tuio(); //<>//
}

// within the draw method we retrieve an ArrayList of type <TuioObject>
// from the TuioProcessing client and then loops over all lists to draw the graphical feedback.
void draw()
{
  background(255);
  textFont(font,18*scale_factor);
  fill(255);

  fill(0);                         
  text("MOOD METER",800,100);  
  
  float obj_size = object_size*scale_factor; 
  


  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0;i<tuioObjectList.size();i++) {
     TuioObject tobj = tuioObjectList.get(i);
     // we retrieve some information about this fiducial marker
     int id = tobj.getSymbolID();
     float angle = tobj.getAngle();
     int x = tobj.getScreenX(width);
     int y = tobj.getScreenY(height);
     
     String gamePiece = getGamePiece(id);
     
    
     
     // we draw a circle and write the ID and assigned name of the marker
     stroke(0);
     fill(255);
     ellipse(x, y, obj_size, obj_size);
     fill(0);
     text(""+id + ": " + gamePiece + " " + angle, x-10, y+10);
     
     if(gamePiece == "spinnerPiece"){
       String studentName = getStudentName(angle);
       fill(#163DD6);                         
       text("Name: " + studentName,1200,100);  
  
     
     }
     
     //lets try it as a property of the TuioObject class?
     //tobj.markerName = gamePiece;
     
   }
}

String getGamePiece(int tuioObjID){
  String nameOfPiece ;
   if(tuioObjID==1){
     nameOfPiece = "completePiece";
   }
   else if (tuioObjID==2){
     nameOfPiece = "spinnerPiece";
   } 
   else if (tuioObjID==3){
     nameOfPiece = "sliderStartPiece";
   }
   else if (tuioObjID==4){
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
   text(degreeInterval, 10, 100);
   int spinnerSectionNum = 0;
   if (spinnerAngle <= degreeInterval) {
     spinnerSectionNum = 0;
   }
   else {
     spinnerSectionNum = int(spinnerAngle/degreeInterval);
   }
   fill(#5E10DE);                         
   text(spinnerSectionNum,1000,500);  
   //stuName = names[spinnerSectionNum];
   
     //if(spinnerAngle >= (0*degreeInterval) && spinnerAngle <= (1*degreeInterval)){ 
     //  stuName=names[0];
     //}
     //else if (spinnerAngle >=(1*degreeInterval) && spinnerAngle <= (2*degreeInterval)) {
     //  stuName=names[1];
     //}
     //else if (spinnerAngle >= (2*degreeInterval) && spinnerAngle <= (3*degreeInterval)) {
     //  stuName=names[2];
     //}
     //else if (spinnerAngle >= (3*degreeInterval) && spinnerAngle <= (4*degreeInterval)) {
     //  stuName=names[3];
     //}
    return  stuName;
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