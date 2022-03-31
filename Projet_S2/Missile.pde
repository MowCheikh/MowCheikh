class Missile {
  float x, y, taille;
  float gravity, vitesse;
  int timer;
  float X1, X2, Y1;
  float horVitesse;
  color couleur;
  int periode;

  Missile() {
    x = width / 2;
    y = 0;
    taille = 3 * width / 80;
    couleur = color(100, 2, 240);
    timer = 0;
    gravity = 0;
    vitesse = 0;
    horVitesse = 1.6;
    periode = 500;
  }

  Missile(float x, float y, float taille, color couleur) {
    this.x = x;
    this.y = y;
    this.taille = taille;
    this.couleur = couleur;
    timer = 0;
    gravity = 0;
    vitesse = 0;
    horVitesse = 1.6;
    periode = 500;
  }

  void dessiner() {
    getCotes();
    fill(couleur);
    triangle(X1, y, X2, y, x, Y1);
    telegraph();
    time();
    constrain(y, 0, height);
  }

  void telegraph() {
    for ( float i = groundLevel; i > y + taille; i -= 30) {
      strokeWeight(1);
      line(x, i, x, i - 20);
    }
  }

  void fall(float X, float Y) {
    float distance = dist(X, Y, x, y);
    x += horVitesse * ( X - x) / distance; 
    y += vitesse;
    vitesse += gravity;
  }

  void time() {
    timer++;
    if ( timer >= periode) {
      timer = 0;
      gravity = 0.012;
      y = 0;
      vitesse = 0;
    }
  }

  // renvoit les coordonnées des cotés du triangles
  void getCotes() {
    X1 = x - taille / 2;
    X2 = x + taille / 2;
    Y1 = y + taille;
  }
  // vérifie s'il y a une point dans le triangle 
  boolean pointInsideTriangle(float i, float j) {
    return j - 2*i - Y1 +2*x <= 0 && j + 2*i -Y1 -2*x <= 0 
      && j >= y;
  }

  // verifie s'il y a une collision entre un rocket et la missile
  void hitboxDetection(Rocket rocket) {
    for (float i = rocket.getX() - rocket.realWidth/2; 
      i <= rocket.getX() + rocket.realWidth / 2; i += rocket.realWidth / 2) {
      for ( float j = rocket.getY() - rocket.taille / 4; 
        j <= rocket.getY() + rocket.taille / 4; j += rocket. taille / 4) {
        if ( pointInsideTriangle(i, j) || rocket.pointHitboxCollision(x, Y1)) {
          jumpFail = true;
          ellipse(50, 50, 50, 50);
          println(x);
          println(y);
        }
      }
    }
  }
}
