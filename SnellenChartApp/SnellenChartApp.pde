
SnellenChart chart;
int lineIndex;

void setup() {
    size(1280, 800);
    reset();
}

void reset() {
    chart = new SnellenChart(87, 0.8, width/4, height * 0.1, width/2, height * 0.8);
    lineIndex = -1;
}

void draw() {
    background(255);
    
    noFill();
    stroke(192);
    strokeWeight(2);
    rect(width/4, height * 0.1, width/2, height * 0.8);
    
    fill(0);
    noStroke();

    if (lineIndex >= 0) {
        chart.drawLine(g, lineIndex);
    } else {
        chart.draw(g);
    }
}

void keyReleased() {
    switch (key) {
        case 'e':
            reset();
            break;
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
            lineIndex = key - '1';
            break;
        case '0':
            lineIndex = 9;
            break;
    }
}