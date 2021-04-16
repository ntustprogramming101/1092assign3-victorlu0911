final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;
final int soilCount = 6;
final int soilW = 80;
final int soilH = 80;
final int soilYSpace = soilW*4;
final int maxHealth = 5;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24, life, groundhogImg, soldierImg, cabbageImg, stone1Img, stone2Img;
PImage [] imgSoil;

int [] soilY;
int soldierX, soldierY, cabbageX, cabbageY, initSoilY;

//groundhog spacing
final int spacing = 80;
float groundhogX = 4*spacing;
float groundhogY= spacing;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);//480,1840
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	soil8x24 = loadImage("img/soil8x24.png");
  life = loadImage("img/life.png");
  groundhogImg = loadImage("img/groundhogIdle.png");
  soldierImg = loadImage("img/soldier.png");
  cabbageImg = loadImage("img/cabbage.png");
  stone1Img = loadImage("img/stone1.png");
  stone2Img = loadImage("img/stone2.png");

  //soil setup
  imgSoil = new PImage[soilCount];
  for(int i = 0; i < soilCount; i++){
    imgSoil[i] = loadImage("img/soil"+i+".png");
  }  
  
  //soldier show
  soldierX = 0;
  soldierY = floor(random(2,6))*80;
  
  //cabbage show
  cabbageX = floor(random(0,8))*80;
  cabbageY = floor(random(2,6))*80;
  
  //playerHealth
  playerHealth = 2;
  
  //initSoilY
  initSoilY = 160;
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

  //moving space
  if(groundhogX >= width-spacing){
    groundhogX = width-spacing;
  }
  if(groundhogX <= 0){
    groundhogX = 0;
  }
  if(groundhogY >= height-spacing){
    groundhogY = height-spacing;
  }
  if(groundhogY <= spacing){
    groundhogY = spacing;
  }
  if(initSoilY<=-1440){
    initSoilY=-1440;
  }
  
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, initSoilY - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    for(int x = 0; x < 8; x++){
      for(int y=0; y<24; y++){
        if(y<4){
          image(imgSoil[0], x*soilW, y*soilH+initSoilY);
        }else if(y<8){
          image(imgSoil[1], x*soilW, y*soilH+initSoilY);
        }else if(y<12){
          image(imgSoil[2], x*soilW, y*soilH+initSoilY);
        }else if(y<16){
          image(imgSoil[3], x*soilW, y*soilH+initSoilY);
        }else if(y<20){
          image(imgSoil[4], x*soilW, y*soilH+initSoilY);
        }else if(y<24){
          image(imgSoil[5], x*soilW, y*soilH+initSoilY);
        }
      }
    }
    //Rocks 1-8
    for(int i = 0; i < 8; i++){
      image(stone1Img, i*80, i*80+initSoilY);
    }
    //Rocks 9-16
    for(int x=0; x<8; x++){
      for(int y=0; y<8; y++){
        if((x==0||x==3||x==4||x==7)
        && (y==1||y==2||y==5||y==6)){
        image(stone1Img, x*80, y*80+initSoilY+640);
        }else if((x==1||x==2||x==5||x==6)
        && (y==0||y==3||y==4||y==7)){
        image(stone1Img, x*80, y*80+initSoilY+640);
        }
      }
    }
    //Rock 17-24 stone1
    for(int x=0; x<8; x++){
      for(int y=0; y<8; y++){
        if((x==0||x==3||x==6)
        && (y==1||y==2||y==4||y==5||y==7)){
        image(stone1Img, x*80, y*80+initSoilY+640+640);
        }else if((x==1||x==4||x==7)
        && (y==0||y==1||y==3||y==4||y==6||y==7)){
        image(stone1Img, x*80, y*80+initSoilY+640+640);
        }else if((x==2||x==5)
        && (y==0||y==2||y==3||y==5||y==6)){
        image(stone1Img, x*80, y*80+initSoilY+640+640);
        }
      }
    }
    //Rock 17-24 stone2
    for(int x=0; x<8; x++){
      for(int y=0; y<8; y++){
        if((x==0||x==3||x==6)
        && (y==2||y==5)){
        image(stone2Img, x*80, y*80+initSoilY+640+640);
        }else if((x==1||x==4||x==7)
        && (y==1||y==4||y==7)){
        image(stone2Img, x*80, y*80+initSoilY+640+640);
        }else if((x==2||x==5)
        && (y==0||y==3||y==6)){
        image(stone2Img, x*80, y*80+initSoilY+640+640);
        }
      }
    }

		// Player
      //groundhog
      image(groundhogImg, groundhogX, groundhogY);

      //cabbage
      image(cabbageImg, cabbageX, cabbageY);
      
      //soldier
      if(soldierX>=width){
        soldierX =- spacing;
      }
      image(soldierImg, soldierX, soldierY);
  
      //soldier move
      soldierX+=4;
      soldierX%=width+spacing;

		// Health UI
    for(int i = 0; i < playerHealth; i++){
      image(life, i*70+10, 10);
      
      //if groundhog touch soldier
      if ( groundhogX < soldierX+spacing && groundhogX+spacing > soldierX
          && groundhogY < soldierY+spacing && groundhogY+spacing > soldierY){
            playerHealth --;
            initSoilY = 160;
            groundhogX = spacing*4;
            groundhogY = spacing; 
            soldierY = floor(random(2,6))*80;
            if(cabbageX<width){
            cabbageX = floor(random(0,8))*80;
            cabbageY = floor(random(2,6))*80;
            }
          }

       //if groundhog eat cabbage
      if ( groundhogX < cabbageX+spacing && groundhogX+spacing > cabbageX
          && groundhogY < cabbageY+spacing && groundhogY+spacing > cabbageY 
          && playerHealth < maxHealth){   
            playerHealth ++;
          }
      if ( groundhogX < cabbageX+spacing && groundhogX+spacing > cabbageX
          && groundhogY < cabbageY+spacing && groundhogY+spacing > cabbageY ){   
            cabbageX = cabbageX + 1000;
          }
    }
       //life = 0
       if ( playerHealth == 0 ){
         gameState = GAME_OVER;
       }
		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{
			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);
		}

      //initial life and groundhog and soldier and soil
      playerHealth = 2;
      groundhogX = spacing*4;
      groundhogY = spacing;
      //cabbage
      cabbageX = floor(random(0,8))*80;
      cabbageY = floor(random(2,6))*80;
      initSoilY = 160;
      soldierY = floor(random(2,6))*80;
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
    switch (keyCode){
     case DOWN:
     if(initSoilY>=-1440){
       initSoilY-=spacing;
       cabbageY-=spacing;
       soldierY-=spacing;
     }
     if(initSoilY<=-1440){
      groundhogY+=spacing;
     }
       break;
     case LEFT:
       groundhogX-=spacing;
       break;
     case RIGHT:
       groundhogX+=spacing;
       break;
    }

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
}
