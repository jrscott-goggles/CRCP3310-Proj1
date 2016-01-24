//Justin Scott
//Project 1: Visualization of Unstructured Data
//Create a visualization based on the text of Alice in Wonderland

BufferedReader reader;
String line;

void setup() {
  size(788, 888);
  reader = createReader("pg11.txt");
}

void draw() {
  try {
    line = reader.readLine();
  } 
  catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line == null) {
    noLoop();  
  } else {
    println(line);
  }
}