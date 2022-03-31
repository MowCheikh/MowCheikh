class Rocket {
  float x, y, taille;
  float vitesse;
  color headColor, bodyColor;
  boolean jump;
  boolean moveRight;
  boolean moveLeft;
  Fire fire;
  float realWidth;
  float maxHeight;
  float minHeight;

  Rocket() {
    x = width / 6;
    y = 8 * height / 15;
    taille = width / 20;
    headColor = color(237, 14, 14);
    bodyColor = color(201, 201, 201);
    realWidth = 2 * taille;
    vitesse = 0;
    fire = new Fire(width / 30, color(255, 0, 0), width / 30, x - 1.6 * taille, y);
    maxHeight = 3 * height / 10;
    minHeight = y;
  }

  Rocket(float x, float y, float taille, color headColor, color bodyColor, float maxHeight) {
    this.x = x;
    this.y = y;
    this.taille = taille;
    this.bodyColor = bodyColor;
    this.headColor = headColor;
    this.maxHeight = maxHeight;
    minHeight = y;
    // la vrai taille du rocket, c'est-à-dire en comptant du fin du queue jusqu'à la tête
    // C'est cette valeur qu'on utilise pour le hitbox du rocket
    realWidth = 2 * taille;
    vitesse = 0;
    fire = new Fire(width / 30, color(255, 0, 0), width / 30, x - 1.6 * taille, y);
  }

  void dessiner() { 
    rectMode(CENTER);
    colorMode(RGB);
    fill(bodyColor);
    rect(x, y, taille, taille / 2);
    //tete de la fusée
    fill(headColor);
    triangle(x + taille / 2, y + taille / 4, 
      x + taille / 2, y - taille / 4, 
      x + taille, y);
    //la queue (Je retiens le controle complet sur la couleur du queue)
    float h = height / 100;
    fill(46, 60, 175);
    quad(x - taille / 2, y + taille / 4 - h, x - taille / 2, y - taille / 4 + h, 
      x - 0.8 * taille, y - 0.7 * (taille / 2), x - 0.8 * taille, y + 0.7 * (taille / 2));
  }

  void jumping() {
    y = constrain( y - vitesse, maxHeight, minHeight);
    if ( y == maxHeight) {
      jump = !jump;
    }
    if (jump) {
      vitesse = 4;
      fire.dessiner();
      fire.dessinerStatic(x - 1.65 * taille, y);
    } else if ( y < height / 2) {
      vitesse = -3;
      fire.dessiner();
      fire.dessinerStatic(x - 1.65 * taille, y);
    }
  }

  void move(float speed) {
    if (moveRight) {
      x += speed;
    } else if (moveLeft) {
      x -= speed;
    }
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }
  // vérifie s'il y a une point dans le hitbox du fusée
  boolean pointHitboxCollision(float i, float j) {
    return  abs( x - i) <= taille && abs(y - j) <= taille / 4 ;
  }
}
