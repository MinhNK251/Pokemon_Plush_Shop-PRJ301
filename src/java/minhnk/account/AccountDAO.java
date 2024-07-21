/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package minhnk.account;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import minhnk.util.Util;

/**
 *
 * @author DELL
 */
public class AccountDAO {
    Connection con = null;
    PreparedStatement stm = null;
    ResultSet rs = null;
    
    public AccountDTO login(String user, String pass) throws SQLException, NamingException{
        String query = "select * from account\n"
                + "where [user] = ?\n"
                + "and pass = ?";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, user);
            stm.setString(2, pass);
            rs = stm.executeQuery();
            while (rs.next()) {
                return new AccountDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getBoolean(4),rs.getBoolean(5));
            }
        } finally{
            if(rs!=null) rs.close();
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
        return null;
    }

    public AccountDTO checkAccountExist(String user) throws SQLException, NamingException{
        String query = "select * from account\n"
                + "where [user] = ?";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, user);
            rs = stm.executeQuery();
            while (rs.next()) {
                return new AccountDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getBoolean(4),rs.getBoolean(5));
            }
        } finally{
            if(rs!=null) rs.close();
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
        return null;
    }

    public void signUp(String user, String pass) throws SQLException, NamingException{
        String query = "insert into account\n"
                + "values(?,?,0,0)";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, user);
            stm.setString(2, pass);
            stm.executeUpdate();
        } finally{
            if(rs!=null) rs.close();
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
    }
    
    public List<AccountDTO> getAllAccounts() throws SQLException, NamingException{
        List<AccountDTO> list = new ArrayList<>();
        String query = "select * from Account";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new AccountDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getBoolean(4),rs.getBoolean(5)));
            }
        } finally{
            if(rs!=null) rs.close();
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
        return list;
    }
    
    public void deleteAccount(String id) throws SQLException, NamingException{
        String query = "delete from Account\n"
                + "where uID = ?";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, id);
            stm.executeUpdate();
        } finally{
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
    }
    
    public void setAdmin(String id, int isAdmin) throws SQLException, NamingException{
        String query = "update Account\n"
                + "set isAdmin = ?\n"
                + "where uID = ?";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, isAdmin);
            stm.setString(2, id);
            stm.executeUpdate();
        } finally{
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
    }
    
    public void setSeller(String id, int isSell) throws SQLException, NamingException{
        String query = "update Account\n"
                + "set isSell = ?\n"
                + "where uID = ?";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, isSell);
            stm.setString(2, id);
            stm.executeUpdate();
        } finally{
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
    }
}
