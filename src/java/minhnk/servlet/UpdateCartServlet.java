package minhnk.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import minhnk.cart.CartDTO;

/**
 *
 * @author DELL
 */
public class UpdateCartServlet extends HttpServlet {
    private final String viewCartServlet = "ViewCartServlet";
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
        String url = viewCartServlet;
        String itemId, message;
        int newQuantity;
        CartDTO item = null;
        HashMap<String, CartDTO> cart = null;
        try {
            itemId = request.getParameter("ITEM_ID");
            newQuantity = Integer.parseInt(request.getParameter("QUANTITY"));
            if(itemId!=null){
                HttpSession sessionCart = request.getSession();
                cart = (HashMap<String, CartDTO>) sessionCart.getAttribute("CART");
                item = cart.get(itemId);
                item.setQuantity(newQuantity);
                message = "Your Cart has been updated successfully";
                request.setAttribute("MESSAGE", "<h4>"+message+"</h4>");
                url= viewCartServlet;
            }
            RequestDispatcher rd =request.getRequestDispatcher(url);
            rd.forward(request, response);
        } catch(Exception e){
            log("UpdateCartServlet has error: "+e.getMessage());
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
