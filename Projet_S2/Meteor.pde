class Meteor {
  float x, y;
  int timer;
  int vitesse;
  float rayon;
  Fire fire;
  color couleur;
  int periode;

  Meteor() {
    x = - width / 3;
    y = 5 * height / 12;
    rayon = width / 20;
    couleur = color(139, 39, 30);
    timer = 0;
    vitesse = 5;
    periode = 500;
    fire = new Fire(1.5 * rayon, color(255, 0, 0), int(rayon / 2), mouseX, mouseY);
  }
  
  Meteor(float x, float y, float rayon, color couleur) {
    this.x = x;
    this.y = y;
    timer = 0;
    vitesse = 5;
    this.rayon = rayon;
    this.couleur = couleur;
    periode = 500;
    fire = new Fire(1.5 * rayon, color(255, 0, 0), int(rayon / 2), mouseX, mouseY);
  }

  void dessiner() {
    fire.dessiner();
    fire.deplacer(x, y);
    fill(couleur);
    ellipse(x, y, rayon, rayon);
  }

  void deplacer() {
    x += vitesse;
    // passage periodique
    timer++;
    if (timer >= periode) {
      vitesse = - vitesse;
      timer = 0;
    }
  }

  void hitboxDetection(Rocket rocket) {
    if (abs(x - rocket.getX()) <= rayon/2 + rocket.realWidth / 2 && 
      abs(y - rocket.getY()) <= rayon/2 + rocket.taille / 4 ) {
      jumpFail = true;
    }
  }
}
