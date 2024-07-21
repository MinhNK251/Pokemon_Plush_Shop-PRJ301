/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package minhnk.product;

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
public class ProductDAO {
    Connection con = null;
    PreparedStatement stm = null;
    ResultSet rs = null;

    public List<ProductDTO> getAllProduct() throws SQLException, NamingException{
        List<ProductDTO> list = new ArrayList<>();
        String query = "select * from product";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new ProductDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDouble(4),rs.getInt(5),rs.getBoolean(6),rs.getString(7)));
            }
        } finally{
            if(rs!=null) rs.close();
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
        return list;
    }

    public List<ProductDTO> getProductByCID(String cid) throws SQLException, NamingException{
        List<ProductDTO> list = new ArrayList<>();
        String query = "select * from product\n"
                + "where cateID = ?";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, cid);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new ProductDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDouble(4),rs.getInt(5),rs.getBoolean(6),rs.getString(7)));
            }
        } finally{
            if(rs!=null) rs.close();
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
        return list;
    }
    
    public List<ProductDTO> searchByName(String txtSearch) throws SQLException, NamingException{
        List<ProductDTO> list = new ArrayList<>();
        String query = "select * from product\n"
                + "where [name] like ?";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, "%" + txtSearch + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new ProductDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDouble(4),rs.getInt(5),rs.getBoolean(6),rs.getString(7)));
            }
        } finally{
            if(rs!=null) rs.close();
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
        return list;
    }    
    
    public List<ProductDTO> getProductBySellID(int id) throws SQLException, NamingException{
        List<ProductDTO> list = new ArrayList<>();
        String query = "select * from product\n"
                + "where sell_ID = ?";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new ProductDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDouble(4),rs.getInt(5),rs.getBoolean(6),rs.getString(7)));
            }
        } finally{
            if(rs!=null) rs.close();
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
        return list;
    }
    
    public ProductDTO getProductByID(String id) throws SQLException, NamingException{
        String query = "select * from product\n"
                + "where id = ?";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                return new ProductDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDouble(4),rs.getInt(5),rs.getBoolean(6),rs.getString(7));
            }
        } finally{
            if(rs!=null) rs.close();
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
        return null;
    }
    
    public ProductDTO getLast() throws SQLException, NamingException{
        String query = "select top 1 * from product\n"
                + "order by id desc";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                return new ProductDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDouble(4),rs.getInt(5),rs.getBoolean(6),rs.getString(7));
            }
        } finally{
            if(rs!=null) rs.close();
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
        return null;
    }
    
    public void deleteProduct(String pid) throws SQLException, NamingException{
        String query = "delete from product\n"
                + "where id = ?";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, pid);
            stm.executeUpdate();
        } finally{
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
    }

    public void insertProduct(String name, String image, String price, String quantity, String isAvailable, String description, String category, int sid) throws SQLException, NamingException{
        String query = "INSERT [dbo].[product] \n"
                + "([name], [image], [price], [quantity], [isAvailable], [description], [cateID], [sell_ID])\n"
                + "VALUES(?,?,?,?,?,?,?)";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, name);
            stm.setString(2, image);
            stm.setString(3, price);
            stm.setString(4, quantity);
            stm.setString(5, isAvailable);
            stm.setString(6, description);
            stm.setString(7, category);
            stm.setInt(8, sid);
            stm.executeUpdate();
        } finally{
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
    }

    public void editProduct(String name, String image, String price, String quantity, String isAvailable, String description, String category, String pid) throws SQLException, NamingException{
        String query = "update product\n"
                + "set [name] = ?,\n"
                + "[image] = ?,\n"
                + "[price] = ?,\n"
                + "[quantity] = ?,\n"
                + "[isAvailable] = ?,\n"
                + "[description] = ?,\n"
                + "[cateID] = ?\n"
                + "where [id] = ?";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, name);
            stm.setString(2, image);
            stm.setString(3, price);
            stm.setString(4, quantity);
            stm.setString(5, isAvailable);
            stm.setString(6, description);
            stm.setString(7, category);
            stm.setString(8, pid);
            stm.executeUpdate();
        } finally{
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
    }
    
    public List<ProductDTO> pagingHome(int index) throws SQLException, NamingException{
        List<ProductDTO> list = new ArrayList<>();
        String query = "select * from Product\n"
                + "order by id \n"
                + "offset ? rows fetch next 6 rows only;";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, (index-1)*6);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new ProductDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDouble(4),rs.getInt(5),rs.getBoolean(6),rs.getString(7)));
            }
        } finally{
            if(rs!=null) rs.close();
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
        return list;
    }
    
    public List<ProductDTO> pagingProduct(int index, int id) throws SQLException, NamingException{
        List<ProductDTO> list = new ArrayList<>();
        String query = "select * from Product where sell_ID = ?\n"
                + "order by id \n"
                + "offset ? rows fetch next 3 rows only;";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, id);
            stm.setInt(2, (index-1)*3);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new ProductDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDouble(4),rs.getInt(5),rs.getBoolean(6),rs.getString(7)));
            }
        } finally{
            if(rs!=null) rs.close();
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
        return list;
    }
    
    public List<ProductDTO> pagingSearch(String txtSearch, int index) throws SQLException, NamingException{
        List<ProductDTO> list = new ArrayList<>();
        String query = "select * from product\n"
                + "where [name] like ?\n"
                + "order by id \n"
                + "offset ? rows fetch next 6 rows only;";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, "%" + txtSearch + "%");
            stm.setInt(2, (index-1)*6);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new ProductDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDouble(4),rs.getInt(5),rs.getBoolean(6),rs.getString(7)));
            }
        } finally{
            if(rs!=null) rs.close();
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
        return list;
    }
    
    public void checkOut(String id, String amount) throws SQLException, NamingException{
        String query = "UPDATE product\n"
                + "SET [quantity] = [quantity] - ? WHERE [id] = ?";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, amount);
            stm.setString(2, id);
            stm.executeUpdate();
        } finally{
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
    }
}
