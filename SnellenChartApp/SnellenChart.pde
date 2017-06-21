
class SnellenChart {
    private float _leftMargin;
    private float _rightMargin;
    private String _characters;
    private String _fontFamily;
    private PFont _labelFont;
    
    private float _initialFontSize;
    private float _fontSizeRatio;
    private float _x;
    private float _y;
    private float _width;
    private float _height;
    
    private ArrayList<PFont> _fonts;
    private ArrayList<String> _lines;
    private ArrayList<Float> _yCoords;
    
    SnellenChart(float initialFontSize, float fontSizeRatio, float x, float y, float width, float height) {
        _leftMargin = 100;
        _rightMargin = 40;
        _characters = "BCDEHKNOPRSUVZ";
        _fontFamily = "HelveticaNeue-Bold";
        _labelFont = createFont("HelveticaNeue", 12);

        _initialFontSize = initialFontSize;
        _fontSizeRatio = fontSizeRatio;
        _x = x;
        _y = y;
        _width = width;
        _height = height;
        
        generateLines();
    }

    private void draw(PGraphics g) {
        for (int i = 0; i < _fonts.size(); i++) {
            drawLine(g, i);
        }
    }
    
    void drawLine(PGraphics g, int index) {
        if (index >= _fonts.size()) {
            return;
        }
        
        PFont font = _fonts.get(index);
        String line = _lines.get(index);
        float y = _yCoords.get(index);
        
        g.pushStyle();
        g.fill(0);

        g.textFont(_labelFont);
        g.text(font.getSize(), _x + _leftMargin - 60, _y + y);
        
        g.textFont(font);
        
        float spacing = getLineSpacing(g, line);
        drawCharacters(g, line, spacing, _x + _leftMargin, _y + y);
        
        g.popStyle();
    }
    
    private void generateLines() {
        pushStyle();
        
        _fonts = new ArrayList<PFont>();
        _lines = new ArrayList<String>();
        _yCoords = new ArrayList<Float>();

        if (_initialFontSize <= 0) {
            return;
        }
        
        PFont font = createFont(_fontFamily, _initialFontSize);
        float currHeight = getLineHeight(font);
        while (currHeight < _height) {
            textFont(font);
            
            String line = "";
            boolean isFirst = true;
            int currWidth = 0;
            float minSpacing = (float)font.getSize() / 2;
            
            while (currWidth < _width - _leftMargin - _rightMargin) {
                String c = getCharacter();
                if (isFirst) {
                    isFirst = false;
                } else {
                    currWidth += minSpacing;
                }
                currWidth += textWidth(c);
                line += c;
            }
            
            _fonts.add(font);
            _lines.add(line);
            _yCoords.add(currHeight);
            
            currHeight += getLineHeight(font);
            font = createFont(_fontFamily, font.getSize() * _fontSizeRatio);
        }
        popStyle();
    }

    private float getLineHeight(PFont font) {
        return 20 + 0.9 * font.getSize();
    }

    private float getLineSpacing(PGraphics g, String line) {
        return (_width - _leftMargin - _rightMargin - textWidth(line)) / (line.length() - 1);
    }

    private void drawCharacters(PGraphics g, String line, float spacing, float x, float y) {
        int currWidth = 0;
        for (int i = 0; i < line.length(); i++) {
            char c = line.charAt(i);
            g.text(c, x + currWidth, y);
            currWidth += g.textWidth(c) + spacing;
        }
    }

    private String getCharacter() {
        return "" + _characters.charAt(floor(random(_characters.length())));
    }

    private String getCharacter(int count) {
        String result = "";
        for (int i = 0; i < count; i++) {
            result += getCharacter();
        }
        return result;
    }
}
