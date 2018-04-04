
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
  text("MOOD METER!",800,50);  
  fill(255);
  rect(30,90,1000,700);
  

  
  float obj_size = object_size*scale_factor; 
  

  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0;i<tuioObjectList.size();i++) {
       TuioObject tobj = tuioObjectList.get(i);
       
       //create gamePieceObjects  
       gamePieceObject piece = new gamePieceObject(tobj);
       piece.getPieceValues();
       
       //for the spinner
       if(piece.pieceName == "spinnerPiece"){
         piece.updateSpinner();
       }
  
       //for the slider
       if (piece.pieceName == "sliderStopPiece"){
         piece.updateSlider();
       }
     
       if (piece.pieceName == "completePiece") {
         piece.finishCheckIn();
       }
    }
}
