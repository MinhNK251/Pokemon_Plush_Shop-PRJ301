package minhnk.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import minhnk.account.AccountDTO;
import minhnk.category.CategoryDAO;
import minhnk.category.CategoryDTO;
import minhnk.product.ProductDAO;
import minhnk.product.ProductDTO;

/**
 *
 * @author DELL
 */
public class ManageProductServlet extends HttpServlet {
    private final String manageProductPage = "ManageProduct.jsp";
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
            String url = manageProductPage;
            HttpSession session = request.getSession();
            AccountDTO acc = (AccountDTO) session.getAttribute("ACCOUNT");
            int accId = acc.getId();
            String indexPage = request.getParameter("index");
            int index=1;
            if(indexPage!=null)
                index = Integer.parseInt(indexPage);
            ProductDAO pDao = new ProductDAO();
            CategoryDAO cDao = new CategoryDAO();
            List<ProductDTO> pList = pDao.getProductBySellID(accId);
            List<CategoryDTO> cList = cDao.getAllCategory();
            int totalProduct = pList.size();
            int endPage = totalProduct/3;
            if(totalProduct%3 != 0)
                endPage++;
            pList = pDao.pagingProduct(index,accId);
            request.setAttribute("END", endPage);
            request.setAttribute("PRODUCT_LIST", pList);
            request.setAttribute("CATEGORY_LIST", cList);
            request.setAttribute("TAG", index);
            RequestDispatcher rd = request.getRequestDispatcher(url);
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
