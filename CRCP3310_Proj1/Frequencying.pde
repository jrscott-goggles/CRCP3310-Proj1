int[] freqs = new int[NUM_LETTERS];
int notLetterFreq = 0;
String keyword = "alice";
int keywordFreq = 0;
IntList keywordOccurances = new IntList();
char mostFreq;
char leastFreq;

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
  } 
  catch (IOException e) {
    println("Could not read data");
    e.printStackTrace();
  }
  println(freqs);
  println("Not letters: " + notLetterFreq);
  println("Keyword: \"" +keyword + "\" appears " + keywordFreq);
  println("Total Chars: " + place);

  mostFreq = findMostFreq(freqs);
  leastFreq = findLeastFreq(freqs);
  println("Most frequent letter: " + mostFreq + " with " + freqs[(int)mostFreq - ASCII_OFFSET]);
  println("Least frequent letter: " + leastFreq + " with " + freqs[(int)leastFreq - ASCII_OFFSET]);
}

void refindKeywordFreq() {
  keywordOccurances.clear();
  keywordFreq = 0;
  reader = createReader(FILE_NAME);
  char[] keyChars = keyword.toCharArray();
  for (int i = 0; i < keyChars.length; ++i) {
    keyChars[i] = Character.toLowerCase(keyChars[i]);
  }
  int keywordPlace = 0;
  try {
    int c;
    int place = 0;
    while ((c = reader.read()) != -1) {
      if (Character.isAlphabetic(c)) {
        char letter = (char)Character.toLowerCase(c);
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
      }
      place++;
    }
  } 
  catch (IOException e) {
    println("Could not read data");
    e.printStackTrace();
  }
  println("Keyword: \"" +keyword + "\" appears " + keywordFreq);
}

char findMostFreq(int[] array) {
  int most = 0;
  int greatest = array[0];
  for (int i = 0; i < array.length; ++i) {
    if (array[i] > greatest) {
      most = i;
      greatest = array[i];
    }
  }
  return char(most + ASCII_OFFSET);
}

char findLeastFreq(int[] array) {
  int least = 0;
  int smallest = array[0];
  for (int i = 0; i < array.length; ++i) {
    if (array[i] < smallest) {
      least = i;
      smallest = array[i];
    }
  }
  return char(least + ASCII_OFFSET);
}