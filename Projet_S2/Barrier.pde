class Barrier {
  float x, y, bHeight, bWidth;
  float vitesse;
  color couleur;
  float acceleration;


  Barrier(float x, float bWidth, float bHeight, color couleur) {
    this.x = x;
    y = groundLevel - bHeight / 2;
    this.bWidth = bWidth;
    this.bHeight = bHeight;
    vitesse = 3;
    acceleration = 0;
    this.couleur = couleur;
  }

  void dessiner() {
    rectMode(CENTER);
    fill(couleur);
    rect(x, y, bWidth, bHeight);
  }

  void move() {
    x -= vitesse;
    vitesse = constrain(vitesse + acceleration, 3, 5);
  }
  
  void hitboxDetection(Rocket rocket) {
    if ( abs(x - rocket.getX()) <= rocket.realWidth/2 + bWidth/2 &&
    abs(y - rocket.getY()) <= rocket.taille / 4 + bHeight/ 2 ) {
      jumpFail = true;
    }
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }
}
