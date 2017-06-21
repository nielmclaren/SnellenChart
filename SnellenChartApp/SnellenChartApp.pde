
String snellCharacters;
int[] snellFontSizes;
ArrayList<PFont> snellFonts;
PFont snellLabelFont;

void setup() {
    size(1280, 800);

    snellCharacters = "BCDEHKNOPRSUVZ";
    snellFontSizes = new int[] {128, 96, 76, 64, 56, 48, 40, 32, 26, 20};
    snellFonts = getFonts("HelveticaNeue-Bold", snellFontSizes);
    snellLabelFont = createFont("HelveticaNeue", 12);

    reset();
}

void reset() {
    drawSnellChart();
}

void draw() {
}

void drawSnellChart() {
    background(255);
    
    float currHeight = 125;
    for (int i = 0; i < snellFontSizes.length; i++) {
        currHeight += drawSnellChartLine(snellFonts.get(i), width/4, currHeight, width/2);
    }
}

float drawSnellChartLine(PFont font, float x, float y, int width) {
    pushStyle();
    fill(0);

    textFont(snellLabelFont);
    text(font.getSize(), x - 60, y);
    
    textFont(font);
    
    String line = getSnellLine(font, width);
    float spacing = getSnellLineSpacing(font, width, line);
    drawSnellChartCharacters(line, spacing, x, y);
    
    popStyle();

    return 20 + 0.9 * font.getSize();
}

String getSnellLine(PFont font, float width) {
    String line = "";
    boolean isFirstCharacter = true;
    int currWidth = 0;
    float spacing = (float)font.getSize() / 2;
    
    while (currWidth < width) {
        String character = getSnellCharacter();
        if (isFirstCharacter) {
            isFirstCharacter = false;
        } else {
            currWidth += spacing;
        }
        currWidth += textWidth(character);
        line += character;
    }
    
    return line;
}

float getSnellLineSpacing(PFont font, float width, String line) {
    return (width - textWidth(line)) / (line.length() - 1);
}

void drawSnellChartCharacters(String line, float spacing, float x, float y) {
    int currWidth = 0;
    for (int i = 0; i < line.length(); i++) {
        char c = line.charAt(i);
        text(c, x + currWidth, y);
        currWidth += textWidth(c) + spacing;
    }
}

String getSnellCharacter(int count) {
  String result = "";
  for (int i = 0; i < count; i++) {
    result += getSnellCharacter();
  }
  return result;
}

String getSnellCharacter() {
    return "" + snellCharacters.charAt(floor(random(snellCharacters.length())));
}

ArrayList<PFont> getFonts(String fontName, int[] fontSizes) {
    ArrayList<PFont> result = new ArrayList<PFont>();
    for (int i = 0; i < fontSizes.length; i++) {
        PFont font = createFont(fontName, fontSizes[i]);
        result.add(font);
    }
    return result;
}

void keyReleased() {
    switch (key) {
        case 'e':
            reset();
            break;
    }
}