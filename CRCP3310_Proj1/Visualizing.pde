PImage letterViz;
color[] colors = new color[NUM_LETTERS];
PImage keywordOverlay;

void drawLetterViz() {
  image(letterViz, 0, 0);
  image(keywordOverlay, 0, 0);
}

void drawFreqGraph() {
  background(255);
  for (int i = 0; i < NUM_LETTERS; ++i) {
      fill(colors[i]);
      int size = (int)map(freqs[i], 0, 10000, 0, 256);
      rect((i + 1) * 14, 256 - size, 14, size);
      
      text(char(i + ASCII_OFFSET), (i + 1) * 14 + 3, 256);
      pushMatrix();
      translate((i + 1) * 14, 250);
      rotate(3 * PI / 2);
      //inverse of the color
      fill(0);
      text(freqs[i], 0, 0);
      popMatrix();
  }
  fill(0);
  text("Most frequent letter: " + mostFreq + " with " + freqs[(int)mostFreq - ASCII_OFFSET], 14, 280);
  text("Least frequent letter: " + leastFreq + " with " + freqs[(int)leastFreq - ASCII_OFFSET], 14, 300);
  text("Keyword: \"" +keyword + "\" appears " + keywordFreq, 14, 320);
  text("Press ENTER to edit keyword.  Press again to initialize change.", 14, 340);
  text("Press R to change color palette.", 14, 360);
}

void prepColors() {
  for (int i = 0; i < NUM_LETTERS; ++i) {
    colors[i] = color(random(188), random(188), random(188));
  }
}

void prepImage() {
  letterViz = createImage(385, 385, RGB);
  letterViz.loadPixels();
  reader = createReader(FILE_NAME);
  try {
    int c;
    int pixel = 0;
    while ((c = reader.read()) != -1 && pixel < (letterViz.height * letterViz.width)) {
      if (Character.isAlphabetic(c)) {
        char letter = (char)Character.toLowerCase(c);
        letterViz.pixels[pixel] = colors[letter - ASCII_OFFSET];
      } else {
        letterViz.pixels[pixel] = color(0);
      }
      pixel++;
    }
  } 
  catch (IOException e) {
    println("Could not read data");
    e.printStackTrace();
  }
  letterViz.updatePixels();
}

void prepKeywordOverlay() {
  keywordOverlay = createImage(385, 385, ARGB);
  keywordOverlay.loadPixels();
  int[] keywordHeres = keywordOccurances.array();
  for (int i = 0; i < keywordHeres.length; ++i) {
    for (int j = 0; j < keyword.length(); ++j) {
      keywordOverlay.pixels[keywordHeres[i] + j] = color(255);
    }
  }
  keywordOverlay.updatePixels();
}