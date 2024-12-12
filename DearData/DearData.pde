String[] genres = {"Reggaeton", "Latin", "Trap", "Pop"};
color[] genreColors = {
  color(255, 100, 100),  // Red for Reggaeton
  color(100, 255, 100),  // Green for Latin
  color(100, 100, 255),  // Blue for Trap
  color(255, 255, 100)   // Yellow for Pop
};

Object[][] data = {
  {0, 0, 5, 210, "DJ Snake"}, {0, 1, 3, 180, "J Balvin"}, {1, 0, 7, 240, "Daddy Yankee"},
  {1, 1, 4, 190, "Jennifer Lopez"}, {2, 2, 6, 200, "Bad Bunny"}, {2, 3, 5, 195, "Black Eyed Peas"},
  {3, 1, 8, 205, "Sech"}, {3, 2, 4, 220, "Jhay Cortez"}, {4, 0, 5, 210, "Ozuna"}, 
  {4, 3, 5, 215, "Cardi B"}, {5, 1, 3, 230, "Karol G"}, {5, 2, 6, 185, "Maluma"},
  {6, 0, 9, 210, "Bad Bunny"}, {6, 1, 5, 200, "Sebastian Yatra"}, {7, 2, 4, 240, "Ozuna"},
  {7, 3, 6, 220, "Tainy"}, {8, 0, 7, 195, "Nicky Jam"}, {8, 1, 2, 205, "Anuel AA"},
  {9, 3, 5, 210, "Black Eyed Peas"}, {9, 1, 6, 215, "Sebastian Yatra"}, {10, 2, 3, 225, "Anuel AA"},
  {10, 3, 7, 230, "Becky G"}, {11, 0, 8, 210, "Lunay"}, {11, 1, 5, 200, "Nicky Jam"},
  {12, 2, 6, 220, "Romeo Santos"}, {12, 3, 3, 180, "Nicki Minaj"}, {13, 0, 4, 230, "Wisin"},
  {13, 1, 2, 215, "Sebastian Yatra"}, {14, 2, 6, 200, "Crissin"}, {14, 3, 7, 245, "Totoy El Frio"},
  {15, 1, 8, 210, "Don Omar"}, {15, 0, 5, 210, "J Balvin"}, {16, 3, 5, 180, "CNCO"},
  {16, 2, 6, 225, "Sech"}, {17, 0, 4, 230, "Karol G"}, {17, 1, 3, 200, "Anuel AA"},
  {18, 3, 6, 195, "Daddy Yankee"}, {18, 2, 5, 210, "Sebastian Yatra"}, {19, 0, 5, 215, "Ozuna"},
  {19, 1, 4, 210, "Bad Bunny"}
};

PVector[] genrePositions;
float hoverRadius = 100; 
int hoveredGenre = -1; 

void setup() {
  size(900, 600);
  genrePositions = new PVector[genres.length];
  
  for (int i = 0; i < genres.length; i++) {
    genrePositions[i] = new PVector(150 + i * 200, height / 2 - 50);
  }
  
  noStroke();
  textAlign(CENTER);
}

void draw() {
  background(255);
  
  hoveredGenre = -1;

  for (int i = 0; i < genres.length; i++) {
    drawGenreCircle(i);
    if (dist(mouseX, mouseY, genrePositions[i].x, genrePositions[i].y) < hoverRadius) {
      hoveredGenre = i;
    }
  }
  
  for (int i = 0; i < data.length; i++) {
    drawSongPulse(data[i]);
  }
  
  if (hoveredGenre != -1) {
    displayArtistInfo(hoveredGenre);
  }
}

void drawGenreCircle(int genreIndex) {
  fill(genreColors[genreIndex]);
  ellipse(genrePositions[genreIndex].x, genrePositions[genreIndex].y, 100, 100);
  
  fill(0);
  textSize(14);
  text(genres[genreIndex], genrePositions[genreIndex].x, genrePositions[genreIndex].y + 70);
}

void drawSongPulse(Object[] songData) {
  int genreIndex = (int) songData[1];
  int playCount = (int) songData[2];
  
  float radius = map(playCount, 1, 10, 10, 80);
  float alpha = map(playCount, 1, 10, 50, 200);
  
  fill(genreColors[genreIndex], alpha);
  ellipse(genrePositions[genreIndex].x, genrePositions[genreIndex].y, radius, radius);
}

void displayArtistInfo(int genreIndex) {
  float boxX = genrePositions[genreIndex].x - 80;
  float boxY = genrePositions[genreIndex].y + 90;
  float boxWidth = 160;
  float boxHeight = 80;
    
  fill(240);
  rect(boxX, boxY, boxWidth, boxHeight, 10);
    
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(12);
  text("Top Songs in " + genres[genreIndex], boxX + boxWidth / 2, boxY + 15);
    
  int displayed = 0;
  for (Object[] song : data) {
    if ((int) song[1] == genreIndex && displayed < 3) {
      String artist = (String) song[4];
      text(artist, boxX + boxWidth / 2, boxY + 30 + displayed * 20);
      displayed++;
    }
  }
}
