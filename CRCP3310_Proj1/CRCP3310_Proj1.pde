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

boolean changingKeyword = false;

void setup() {
  size(385, 385);
  noStroke();
  textSize(12);
  textAlign(LEFT, TOP);
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

void keyPressed() {
   if (key == 'r' || key == 'R' && !changingKeyword) {
      prepColors();
      prepImage();
   } else if (state == STATE_GRAPH) {
    if (key == ENTER) {
      changingKeyword = !changingKeyword;
      if (!changingKeyword) {
        refindKeywordFreq();
        prepKeywordOverlay();
      }
    } else if (changingKeyword) {
      if (Character.isAlphabetic(key)) {
        char letter = (char)Character.toLowerCase(key);
        if (keyword == "_") {
          keyword = "" + key;
        } else {
          keyword += letter;
        }
      } else if (keyCode == BACKSPACE) {
        if (keyword.length() == 1) {
          keyword = "_";
        } else {
          keyword = keyword.substring(0, keyword.length() - 1);
        }
      }
    }
  }
}