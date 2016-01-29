//Justin Scott
//Project 1: Visualization of Unstructured Data
//Create a visualization based on the text of Alice in Wonderland

BufferedReader reader;

int state;
final int STATE_LETTERS = 0;
final int STATE_GRAPH = 1;

final String FILE_NAME = "pg11.txt";
final int ASCII_OFFSET = 97;
final int NUM_LETTERS = 26;

int[] freqs = new int[NUM_LETTERS];
int notLetterFreq = 0;
String keyword = "alice";
int keywordFreq = 0;
IntList keywordOccurances = new IntList();

PImage letterViz;
color[] colors = new color[NUM_LETTERS];
PImage keywordOverlay;

void setup() {
  size(420, 420);
  state = STATE_LETTERS;
  prepFreq();
  prepColors();
  prepImage();
  prepKeywordOverlay();
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
  image(keywordOverlay, 0, 0);
}

void drawFreqGraph() {
  background(0);
}

void prepFreq() {
  for (int i = 0; i < NUM_LETTERS; ++i) {
    freqs[i] = 0;
  }
  reader = createReader(FILE_NAME);
  int place = 0;
  
  char[] keyChars = keyword.toCharArray();
  for (int i = 0; i < keyChars.length; ++i) {
    keyChars[i] = Character.toLowerCase(keyChars[i]);
  }
  int keywordPlace = 0;
  
  try {
    int c;
    while ((c = reader.read()) != -1) {
      if (Character.isAlphabetic(c)) {
        char letter = (char)Character.toLowerCase(c);
        freqs[letter - ASCII_OFFSET]++;
        
        //Find keyword
        if (letter == keyChars[keywordPlace]) {
          if (keywordPlace == (keyChars.length - 1)) {
            keywordFreq++;
            keywordPlace = 0;
            keywordOccurances.append(place - (keyChars.length - 1));
          } else {
          keywordPlace++;
         }
        } else {
          keywordPlace = 0;
        }
      } else {
       notLetterFreq++;
      }
      place++;
    }
  } catch (IOException e) {
    println("Could not read data");
    e.printStackTrace();
  }
  println(freqs);
  println("Not letters: " + notLetterFreq);
  println("Keyword: " + keywordFreq);
}

void prepColors() {
  for (int i = 0; i < NUM_LETTERS; ++i) {
    colors[i] = color(0);
  }
}

void prepImage() {
  letterViz = createImage(420, 420, RGB);
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
        letterViz.pixels[pixel] = color(random(255), random(255), random(255));
      }
      pixel++;
    }
    
  } catch (IOException e) {
    println("Could not read data");
    e.printStackTrace();
  }
}

void prepKeywordOverlay() {
    keywordOverlay = createImage(420, 420, ARGB);
    keywordOverlay.loadPixels();
    int[] keywordHeres = keywordOccurances.array();
    for (int i = 0; i < keywordHeres.length; ++i) {
      for (int j = 0; j < keyword.length(); ++j) {
        letterViz.pixels[keywordHeres[i] + j] = color(255);
      }
    }
    keywordOverlay.updatePixels();
}