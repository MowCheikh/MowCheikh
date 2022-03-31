Rocket rocket;
int nombreDeBarriers = 100;
Barrier[] barriers = new Barrier[nombreDeBarriers];
float[] initialPos = new float[barriers.length];
float ecart;
float groundLevel;
Meteor meteor;
Missile missile;
boolean jumpFail;
float sunX, sunY;
int score;
int[] highScore;
String[] highScoreString;

void setup() {
  size(800, 800); 
  // initialisation des variables
  groundLevel =  9 * height / 16;
  ecart = 4 * width / 5;
  sunX = 2*width/3;
  sunY = random(height/10, height/5);
  // Les objets
  rocket = new Rocket( width/6, 8 * height / 15, width / 20, color(237, 14, 14), color(201, 201, 201), 3 * height / 10);
  meteor = new Meteor(- width / 3, 5 * height / 12, width / 20, color(139, 49, 3));
  missile = new Missile(width / 2, 0, 3 * width / 80, color(100, 2, 240));
  // les barrieres
  initialisationDesBarriers();
  // pour retenir le meuilleur score
  highScoreString = loadStrings("highScore.txt");
  highScore = int(highScoreString);
}

void draw() {
  background(255);
  drawBackground();
  rocket.dessiner();
  rocket.jumping();
  rocket.move(2);
  fonctionsDesBarriers();
  gameRules();
  affichage();
}

void keyPressed() {
  if ( key == 'z' && rocket.getY() >= height / 2) {
    rocket.jump = true;
  }
  if ( key == 'd') {
    rocket.moveRight = true;
  }
  if (key == 'q') {
    rocket.moveLeft = true;
  }
}
 
void keyReleased() {
  if ( key == 'd') {
    rocket.moveRight = false;
  }
  if ( key == 'q') {
    rocket.moveLeft = false;
  }
}

void fonctionsDesBarriers() {
  for ( int i = 0; i < barriers.length; i++) {
    barriers[i].dessiner();
    barriers[i].move();
    barriers[i].hitboxDetection(rocket);
    if ( barriers[i].getX() == - ecart) {
      barriers[i].x = initialPos[barriers.length - 1] - width;
    }
  }
  if ( barriers[0].getX() == width / 2) {
    shuffleBarriers(1);
  }
}

// itérations des positions des barrières 
void shuffleBarriers(int k) {
  for (int i = k; i < barriers.length - 1; i++) {
    int j = int(random(i, barriers.length));
    float tempBarrierX = barriers[i].x;
    barriers[i].x = barriers[j].x;
    barriers[j].x = tempBarrierX;
  }
}

void initialisationDesBarriers() {
  for (int i = 0; i < barriers.length; i++) {
    initialPos[i] = width + (i * ecart) - 100;
    if ( i % 3 == 0) {
      barriers[i] = new Barrier(initialPos[i], width / random(20, 40), 
        height / 8, color(66, 222, 36));
    } else if ( i % 3 == 1) {
      barriers[i] = new Barrier(initialPos[i], width / 6, 
        height / random(16, 20), color(66, 222, 36));
    } else {
      barriers[i] = new Barrier(initialPos[i], width / random(40, 60), 
        2 * height / 13, color(66, 222, 36));
    }
  }
  shuffleBarriers(1);
}


// dessin du fond
void drawBackground() {
  background(35, 204, 245);
  strokeWeight(3);
  rectMode(CORNER);
  fill(216, 208, 37);
  rect(0, groundLevel, width, height);
  fill(255, 249, 59);
  noStroke();
  ellipse(sunX, sunY, 3 * width / 20, 3 * width / 20);
  stroke(0);
}

void gameRules() {
  score+= 1;
  if (score > 500) {
    for (int i = 0; i < barriers.length; i++) {
      barriers[i].acceleration = 0.001;
    }
  }
  if ( score > 1000) {
    meteor.dessiner();
    meteor.deplacer();
    meteor.hitboxDetection(rocket);
  }
  if ( score > 2000) {
    missile.dessiner();
    missile.fall(rocket.getX(), rocket.getY());
    // cette condition évite un bug qui detecté une collision lorsque la missile revient a sa position initiale
    if ( missile.y >= height/10) {
      missile.hitboxDetection(rocket);
    }
  }
  if( score > highScore[0]) {
    highScore[0] = score;
    highScoreString[0] = highScore[0] + "";
    saveStrings("Data/highScore.txt", highScoreString);
  }
  // le jeu arrête s'il y a une collision
  if (jumpFail) {
    fill(255, 10, 0);
    textSize(32);
    text("Game Over", width/3, height/4);
    noLoop();
  }
}

void affichage() {
  fill(0);
  textSize(18);
  textAlign(LEFT);
  text("score " + score, width/20, height/20);
  text(" Sautez avec Z, Bougez avec Q et D. Bonne Chance", width/5, 4*height/5);
  text("Highscore " + highScore[0], 3 * width / 4, height / 20);
}
