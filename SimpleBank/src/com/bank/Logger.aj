package com.bank;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;

public aspect Logger {
	Calendar cal = Calendar.getInstance();
	
	pointcut success() : call(* Bank.createUser*(..) );
    after() : success() {
    //Aspecto ejemplo: solo muestra este mensaje despu�s de haber creado un usuario 
    	System.out.println("**** Usuario creado ****");
    }
	
	pointcut successTransaction() : call(* Bank.moneyMakeTransaction*(..) );
    after() : successTransaction() {
 
    	try ( BufferedWriter bw = new BufferedWriter(new FileWriter("Log.txt", true))) {
            bw.write("Realizar transacción: "+cal.getTime()+"\n");
            System.out.println("**** Realizar transacción: "+cal.getTime()+" ****");
        } catch (IOException ex) {
            System.out.println("No se pudo escribir en el archivo Log.txt");
        }
    }
    
    pointcut successMoneyWithdrawal() : call(* Bank.moneyWithdrawal*(..) );
    after() : successMoneyWithdrawal() {
 
    	try ( BufferedWriter bw = new BufferedWriter(new FileWriter("Log.txt", true))) {
            bw.write("Retirar dinero: "+cal.getTime()+"\n");
            System.out.println("**** Retirar dinero: "+cal.getTime()+" ****");
        } catch (IOException ex) {
            System.out.println("No se pudo escribir en el archivo Log.txt");
        }
    }
   
}