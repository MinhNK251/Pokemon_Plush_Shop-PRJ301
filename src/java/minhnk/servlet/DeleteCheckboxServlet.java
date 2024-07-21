package minhnk.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import minhnk.account.AccountDAO;
import minhnk.product.ProductDAO;

/**
 *
 * @author DELL
 */
public class DeleteCheckboxServlet extends HttpServlet {
    private final String manageProduct = "ManageProductServlet";
    private final String manageAccount = "ManageAccountServlet";
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            ProductDAO pDao = new ProductDAO();
            AccountDAO aDao = new AccountDAO();
            String url = null;
            String delId = request.getParameter("id");
            if(delId.equals("Product")){
                url = manageProduct;
                String[] options = request.getParameterValues("options");
                if(options!=null)
                    for(String id: options)
                        pDao.deleteProduct(id);
            }
            if(delId.equals("Account")){
                url = manageAccount;
                String[] options = request.getParameterValues("options");
                if(options!=null)
                    for(String id: options)
                        aDao.deleteAccount(id);
            }
            response.sendRedirect(url);
        } catch(SQLException | NamingException ex){
            ex.printStackTrace();
        } finally{
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
