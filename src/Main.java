import java.io.IOException;
import java.util.*;

public class Main {

    static Scanner in = new Scanner(System.in); // System.in és global, Scanner també ho a de ser

    // Main
    public static void main(String[] args) throws InterruptedException, IOException {
        
        boolean running = true;

        while (running) {

            String menu = Colors.CYAN + "Escull una opció:" + Colors.RESET;
            menu = menu + "\n 0) Servidor";
            menu = menu + "\n 1) Client";
            menu = menu + "\n 2) Sortir";
            System.out.println(menu);

            int opcio = Integer.valueOf(llegirLinia("Opció:"));
            
            switch (opcio) {
                case 0: RemoteServer.main(args);     break;
                case 1: RemoteClient.main(args);       break;
                case 2: running = false;            break;
                default: break;
            }
        }

		in.close();
    }

    static public String llegirLinia (String text) {
        System.out.print(Colors.GREEN + text + " " + Colors.RESET);
        return in.nextLine();
    }
}