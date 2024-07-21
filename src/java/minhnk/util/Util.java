/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package minhnk.util;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author DELL
 */
public class Util {
    final static private String DB_NAME="PRJ301_Assignment";
    final static private String DB_USER_NAME="sa";
    final static private String DB_PASSWORD="1234";
    public static Connection makeConnection() throws NamingException, SQLException{
        Connection con = null;
        Context currentContext = new InitialContext();
        Context tomcatContext = (Context) currentContext.lookup("java:comp/env");
        DataSource ds = (DataSource) tomcatContext.lookup("DBCon");
        con = ds.getConnection();
        return con;
    }   
}
