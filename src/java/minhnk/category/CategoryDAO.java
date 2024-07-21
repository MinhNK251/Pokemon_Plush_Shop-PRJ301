/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package minhnk.category;

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
public class CategoryDAO {
    Connection con = null;
    PreparedStatement stm = null;
    ResultSet rs = null;
    
    public List<CategoryDTO> getAllCategory() throws SQLException, NamingException{
        List<CategoryDTO> list = new ArrayList<>();
        String query = "select * from Category";
        try {
            con = Util.makeConnection();
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new CategoryDTO(rs.getInt(1),rs.getString(2)));
            }
        } finally{
            if(rs!=null) rs.close();
            if(stm!=null) stm.close();
            if(con!=null) con.close();
        }
        return list;
    }
}
