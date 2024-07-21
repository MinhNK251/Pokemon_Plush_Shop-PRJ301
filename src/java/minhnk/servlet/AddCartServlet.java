package minhnk.servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import minhnk.cart.CartDTO;
import minhnk.product.ProductDAO;
import minhnk.product.ProductDTO;

/**
 *
 * @author DELL
 */
public class AddCartServlet extends HttpServlet {
    private final String homeServlet="HomeServlet";
    private final String detailServlet="DetailServlet";
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
        String url = null;
        String message=null, productId, id, urlDetail;
        ProductDTO selectedProduct = null;
        CartDTO item = null;
        HashMap<String, CartDTO> itemsInCart = null;
        try {
            ProductDAO pDAO = new ProductDAO();
            HttpSession shoppingCart = request.getSession();
            itemsInCart = (HashMap<String, CartDTO>) shoppingCart.getAttribute("CART");
            productId = request.getParameter("pid");
            urlDetail = request.getParameter("url");
            selectedProduct = pDAO.getProductByID(productId);
            if(itemsInCart==null){
                itemsInCart = new HashMap<String, CartDTO>();
                shoppingCart.setAttribute("CART", itemsInCart);
            }
            id = String.valueOf(selectedProduct.getId());
            item = itemsInCart.get(id);
            if(item==null){
                item = new CartDTO(id,selectedProduct.getName(), 1, selectedProduct.getPrice());
                itemsInCart.put(item.getItemId(), item);
                message = "The Pokemon "+item.getItemName()+" has been captured successfully";
            } else if(selectedProduct.getQuantity()>item.getQuantity()){
                item.setQuantity(item.getQuantity()+1);
                message = "The Pokemon "+item.getItemName()+"'s quantity in the cart has been updated successfully";
            }
            if(urlDetail!=null)
                url=detailServlet;
            else url = homeServlet;
            request.setAttribute("MESSAGE", "<h4>"+message+"</h4>");
            RequestDispatcher rd =request.getRequestDispatcher(url);
            rd.forward(request, response);
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
