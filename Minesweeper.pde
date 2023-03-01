import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 5;
public final static int NUM_COLS = 5;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int row = 0; row < NUM_ROWS; row++)
      for(int col = 0; col < NUM_COLS; col++)
        buttons[row][col] = new MSButton(row,col);
    
    setMines();
}
public void setMines()
{
    int r = 0;
    int c = 0;
    for(int i = 0; i < 5; i++){
      r = (int)(Math.random()*NUM_ROWS);
      c = (int)(Math.random()*NUM_COLS);
    if(!mines.contains(buttons[r][c])){
      mines.add(buttons[r][c]);
    }
   }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
    if(r < NUM_ROWS && r >= 0 && c >= 0 && c < NUM_COLS)
      return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    for(int a = row-1; a < row+1; a++){
      for(int b = col-1; b < col+1; b++){
          if(isValid(a,b) == true && mines.contains(buttons[a][b]))
            numMines++;
      }
    }
    if(mines.contains(buttons[row][col])== true)
      numMines--;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(mouseButton == RIGHT){
          if(flagged == true){
            flagged = false;
            clicked = false;
          }else{
             flagged = true;
          }
        }
    }
    public void draw () 
    {   
        if (flagged)
            fill(0);
         else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
        for(int r = 0; r < NUM_ROWS; r++)
          for(int c = 0; c < NUM_COLS; c++)
            rect(x,y,20,20);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
