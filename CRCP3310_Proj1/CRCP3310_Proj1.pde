//Justin Scott
//Project 1: Visualization of Unstructured Data
//Create a visualization based on the text of Alice in Wonderland

BufferedReader reader;

int state;
final int STATE_LETTERS = 0;
final int STATE_GRAPH = 1;

int[] freqs = new int[26];
int notLetterFreq = 0;
final int ASCII_OFFSET = 97;

void setup() {
  size(410, 410);
  //reader = createReader("pg11.txt");
  state = STATE_LETTERS;
  prepFreq();
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

char readChar() {
  /*try {
    return (char)reader.read();
  } 
  catch (IOException e) {
    e.printStackTrace();
    println("failed");
    return '0';
  }
  */
  return '0';
}

void drawLetterViz() {
  background(255);
}

void drawFreqGraph() {
  background(0);
}

void prepFreq() {
  for (int i = 0; i < 26; ++i) {
    freqs[i] = 0;
  }
  reader = createReader("pg11.txt");
  try {
    int c;
    while ((c = reader.read()) != -1) {
      if (!Character.isAlphabetic(c)) continue;
      char letter = (char)Character.toLowerCase(c);
      freqs[letter - ASCII_OFFSET]++;
    }
  } catch (IOException e) {
    println("Could not read data");
    e.printStackTrace();
  }
  println(freqs);
}