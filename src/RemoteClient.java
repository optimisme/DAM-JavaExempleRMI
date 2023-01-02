import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

/*
 * El client coneix les funcions que
 * estàn disponibles remotament gràcies
 * a la 'interfície' comuna.
 * 
 * Fa crides al servidor i rep les
 * respostes com si fóssin crides a funcions
 * locals
 */

public class RemoteClient { 
    public static void main(String[] args) {

        int port = 5555;
        String registre = "Calculator";
        
        try {

            Registry registry = LocateRegistry.getRegistry("localhost", port);
            RemoteInterface calc = (RemoteInterface) registry.lookup(registre);

            System.out.println("Suma:  2+2=" + calc.add(2, 2));
            System.out.println("Resta: 5-3=" + calc.sub(5, 3));
            System.out.println("Multiplicació: 3*3=" + calc.mul(3, 3));
            System.out.println("Divisió: 20/4=" + calc.div(20, 4));

        } catch (Exception e) { e.printStackTrace(); }
    }
}
