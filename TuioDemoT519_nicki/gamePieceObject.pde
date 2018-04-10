class gamePieceObject{
  int pieceID; 
  float pieceAngle; 
  int x_pos;
  int y_pos;
  String pieceName;
  TuioObject tuioObj;
  
  //constructor
  gamePieceObject(TuioObject theTUIOObject){
    tuioObj = theTUIOObject;
    pieceID = this.tuioObj.getSymbolID();
    pieceName = this.getPieceName(this.pieceID);
  
  }

  
  //this is done constantly in draw for all pieces
  void getPieceValues(){
    this.pieceAngle = this.tuioObj.getAngle();
    this.x_pos= tuioObj.getScreenX(width);
    this.y_pos = tuioObj.getScreenY(height);
  }
  
  String getPieceName(int tuioObjID){
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
  
  String updateSpinner(){
       String studentName = this.getStudentName(this.pieceAngle);
       fill(#163DD6);  
       textSize(36);
       text("Name: " + studentName,1200,50); 
       return studentName;
  }
  
  String getStudentName(float spinnerAngle){
  
     String stuName = "Unknown";
     String[] names= {"Leah", "Robert", "Nadia", "Tom", "Benny", "Kyla", "Adam", "Jane"};
     int numOfStu = names.length;
     float degreeInterval = (2*3.14)/numOfStu;
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

  String updateSlider(float startPos){
         
         float endPos = this.x_pos;
         float sliderLength = endPos-startPos; 
         String[] emotions= {"Very Sad", "Sad", "Neutral", "Happy", "Very Happy"};
         int numEmotions = emotions.length;
         
         //do some math to determine where the slider is
         int emotionNum= this.getStudentEmotionNum(sliderLength, numEmotions);
         
         
         String studentEmotion = emotions[emotionNum];
         PImage[] emotionImages = {verySadImg, sadImg, neutralImg, happyImg, veryHappyImg};
         PImage emotionImg = emotionImages[emotionNum];
         image(emotionImg, this.x_pos - 100 ,this.y_pos + 150, 100, 100);
         fill(#1D9594);
         textSize(36);
         text("Emotion: " + studentEmotion, 1500, 50);
         return studentEmotion;
  
  }
  
  int getStudentEmotionNum(float sliderLength, int numOfEmotions){
           int startingDistance = 450; //max length of Slider 
           float emotionInterval = startingDistance/(numOfEmotions);
           int emotionSectionNum = int(sliderLength/emotionInterval); 
           if (emotionSectionNum>=numOfEmotions){
             emotionSectionNum = numOfEmotions-1;
           }
         return  emotionSectionNum;
  }
  
  void finishCheckIn(){
     fill(#932222);  
     textSize(72);
     text("Thanks for Checking In", 30, 60);   
  }
  
  void addDataRow(Table stuTable){
       
      TableRow row = stuTable.addRow();
      row.setString("Name", stuName);
      row.setString("Emotion", stuEmotion);
      
      //add date
      int day = day();    // Values from 1 - 31
      int month = month();  // Values from 1 - 12
      int yr = year();   // 2003, 2004, 2005, etc.
      row.setString("Day", String.valueOf(day));
      row.setString("Month", String.valueOf(month));
      row.setString("Year", String.valueOf(yr));
      
      //add time
      int min = minute();  // Values from 0 - 59
      int hr = hour();    // Values from 0 - 23
      row.setString("Time", String.valueOf(hr) + ":" + String.valueOf(min));

      saveTable(stuTable, "data/studentEmotionData.csv");
      
  }
  
}
