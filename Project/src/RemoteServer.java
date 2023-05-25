import java.rmi.Remote;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;

/*
 * El servidor queda esperant peticions
 * en forma de crides a les funcions
 * que estàn disponibles remotament,
 * i les executa retornant els resultats
 * als clients
 */

public class RemoteServer implements RemoteInterface { 
    public static void main(String[] args) {

        int port = 5555;
        String registre = "Calculator";

        // Configura el port de les peticions
        Registry reg = null;
        try {
            reg = LocateRegistry.createRegistry(port);
        } catch (Exception e) { e.printStackTrace(); }

        // Crea el servidor d'objectes remots
        RemoteServer serverObject = new RemoteServer();
        try {
            Remote obj = (RemoteInterface) UnicastRemoteObject.exportObject(serverObject, 0);
            reg.rebind(registre, obj);
            System.out.println("Servidor remot funcionant ...");

        } catch (Exception e) { e.printStackTrace(); }
    }

    public int add(int a, int b) throws RemoteException {
        return (a + b);
    }
    public int sub(int a, int b) throws RemoteException {
        return (a - b);
    }
    public int mul(int a, int b) throws RemoteException {
        return (a * b);
    }
    public int div(int a, int b) throws RemoteException {
        return (a / b);
    }
}
