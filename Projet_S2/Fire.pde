/* C'est la classe pour les flames qui sort du rocket et du meteor.
 Evidamment elle est bien inspiré par la classe de Snake vu en cours.
 Mais au lieu de storer les positins des x et des y, on s'interesse qu'au abscisse
 pour notre objectif*/

class Fire {
  float taille;
  color couleur;
  float[] xpos;
  float y;
  /* au introduit un nouveau variable, pour eviter qu'il y ait une relation entre 
   la taille du cercle et la taille du queue */
  int stretch;


  Fire( float taille, color couleur, int stretch, float x0, float y) {
    this.taille = taille;
    this.couleur = couleur;
    this.y = y;
    this.stretch = stretch;
    // tableau pour les valeurs des x
    xpos = new float[stretch];
    for (int i = 0; i < stretch; i++) {
      xpos[i] = x0;
    }
  }

  void dessiner() {
    for (int i = 0; i < stretch; i++) {
      fill(couleur);
      noStroke();
      ellipse(xpos[i], y, i * taille / stretch, i * taille / stretch);
      stroke(0);
    }
  }
  // fonction qui a d'effet de... de deplacer la feu vers une position donnée 
  void deplacer(float x, float y) {
    for ( int i = 0; i < stretch - 1; i++) {
      xpos[i] = xpos[i + 1];
    }
    xpos[stretch - 1] = x;
    this.y = y;
  }

// Pour la feu du fusée
  void dessinerStatic(float x, float y) {
    xpos[stretch - 1] = x;
    for (int i = 0; i < stretch; i++) {
      xpos[i] = xpos[stretch - 1] + i * taille / stretch;
    }
    this.y = y;
  }
}
