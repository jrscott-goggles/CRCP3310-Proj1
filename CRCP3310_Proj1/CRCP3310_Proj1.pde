//Justin Scott
//Project 1: Visualization of Unstructured Data
//Create a visualization based on the text of Alice in Wonderland

BufferedReader reader;

int state;
final int STATE_LETTERS = 0;
final int STATE_GRAPH = 1;

final String FILE_NAME = "pg11.txt";
final int ASCII_OFFSET = 97;
final int NUM_LETTERS

int[] freqs = new int[NUM_LETTERS];
int notLetterFreq = 0;
PImage letterViz;
color[] colors = new color[NUM_LETTERS];

void setup() {
  size(420, 420);
  state = STATE_LETTERS;
  prepFreq();
  prepColors();
  prepImage();
}

void draw() {
  //in draw, only draw
  if (state == STATE_LETTERS) {
    drawLetterViz();
  } else {
    drawFreqGraph();
  }
}

void mousePressed() {
  state = (state + 1) % 2;
}

void drawLetterViz() {
  image(letterViz, 0, 0);
}

void drawFreqGraph() {
  background(0);
}

void prepFreq() {
  for (int i = 0; i < NUM_LETTERS; ++i) {
    freqs[i] = 0;
  }
  reader = createReader(FILE_NAME);
  try {
    int c;
    while ((c = reader.read()) != -1) {
      if (Character.isAlphabetic(c)) {
        char letter = (char)Character.toLowerCase(c);
        freqs[letter - ASCII_OFFSET]++;
      } else {
       notLetterFreq++;
      }
    }
  } catch (IOException e) {
    println("Could not read data");
    e.printStackTrace();
  }
  println(freqs);
  println("Not letters: " + notLetterFreq);
}

void prepColors() {
  for (int i = 0; i < NUM_LETTERS; ++i) {
    colors[i] = color(random(255), random(255), random(255));
  }
}

void prepImage() {
  letterViz = createImage(420, 420);
  letterViz.loadPixels();
  reader = createReader(FILE_NAME);
  try {
    int c;
    int pixel = 0;
    while ((c = reader.read()) != -1 && pixel < (letterViz.height * letterViz.width)) {
      if ((Character.isAlphabetic(c)) {
        char letter = (char)Character.toLowerCase(c);
        letterViz.pixels[i] = colors[letter - ASCII_OFFSET];
      } else {
        letterViz.pixels[i] = color(0);
      }
      pixel++;
    }
    letterViz.updatePixels();
  } catch (IOException e) {
    println("Could not read data");
    e.printStackTrace();
  }
}
