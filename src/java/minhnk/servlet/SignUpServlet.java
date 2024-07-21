package minhnk.servlet;

import minhnk.account.AccountDAO;
import minhnk.account.AccountDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
public class SignUpServlet extends HttpServlet {
    private final String home = "HomeServlet";
    private final String login = "Login.jsp";
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
            String url = home;
            String userName = request.getParameter("txtUserName");
            String password = request.getParameter("txtPassword");
            String rePass = request.getParameter("txtRepeatPassword");
            if(!password.equals(rePass)){
                request.setAttribute("ALERT", "Password doesn't match");
                url = login;
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
            }else{
                AccountDAO aDao = new AccountDAO();
                AccountDTO acc = aDao.checkAccountExist(userName);
                if(acc == null){
                    //dc signup
                    aDao.signUp(userName, password);
                    response.sendRedirect(url);
                }else{
                    //day ve trang login.jsp
                    request.setAttribute("ALERT", "The account is already existed");
                    url = login;
                    RequestDispatcher rd = request.getRequestDispatcher(url);
                    rd.forward(request, response);
                }
            }
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
