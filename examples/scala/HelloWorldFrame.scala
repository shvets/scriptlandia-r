import javax.swing._;

object HelloWorldFrame extends JFrame( "Greetings" ) 
{    
    def main( args: Array[String] ) = 
    {
        setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
        add( new JLabel( "Hello World" ) );
        pack();
        setVisible( true );
    }
}

HelloWorldFrame.main(args)