import java.rmi.Remote;
import java.rmi.RemoteException;

/* 
 * Aquesta interficia defineix els
 * mètodes que s'han de cridar remotament
 * des del client
 * 
 * La necessita el servidor per implementar
 * els mètodes
 * 
 * La necessita el client per conèixer
 * els mètodes que pot cridar
 */

public interface RemoteInterface extends Remote {

    public int add(int a, int b) throws RemoteException;
    public int sub(int a, int b) throws RemoteException;
    public int mul(int a, int b) throws RemoteException;
    public int div(int a, int b) throws RemoteException;
}
