/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package minhnk.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
public class DispatchServlet extends HttpServlet {
    private final String addCartServlet = "AddCartServlet";
    private final String addProductServlet = "AddProductServlet";
    private final String categoryServlet = "CategoryServlet";
    private final String checkOutServlet = "CheckOutServlet";
    private final String deleteCheckboxServlet = "DeleteCheckboxServlet";
    private final String deleteServlet = "DeleteServlet";
    private final String detailServlet = "DetailServlet";
    private final String editServlet = "EditServlet";
    private final String homeServlet = "HomeServlet";
    private final String loadServlet = "LoadServlet";
    private final String logOutServlet = "LogOutServlet";
    private final String loginServlet = "LoginServlet";
    private final String manageProductServlet = "ManageProductServlet";
    private final String removeCartServlet = "RemoveCartServlet";
    private final String saveServlet = "SaveServlet";
    private final String searchServlet = "SearchServlet";
    private final String signUpServlet = "SignUpServlet";
    private final String updateCartServlet = "UpdateCartServlet";
    private final String viewCartServlet = "ViewCartServlet";
    private final String manageAccountServlet = "ManageAccountServlet";
    
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
            String btValue = request.getParameter("action");
            String url = homeServlet;
            if(btValue==null){
                
            } else if(btValue.equals("Home")){
                url = homeServlet;
            } else if(btValue.equals("Category")){
                url = categoryServlet;
            } else if(btValue.equals("Detail")){
                url = detailServlet;
            } else if(btValue.equals("AddCart")){
                url = addCartServlet;
            } else if(btValue.equals("Search")){
                url = searchServlet;
            } else if(btValue.equals("Remove")){
                url = removeCartServlet;
            } else if(btValue.equals("Update")){
                url = updateCartServlet;
            } else if(btValue.equals("Checkout")){
                url = checkOutServlet;
            } else if(btValue.equals("Edit")){
                url = editServlet;
            } else if(btValue.equals("Login")){
                url = loginServlet;
            } else if(btValue.equals("SignUp")){
                url = signUpServlet;
            } else if(btValue.equals("DeleteCheckbox")){
                url = deleteCheckboxServlet;
            } else if(btValue.equals("Load")){
                url = loadServlet;
            } else if(btValue.equals("LogOut")){
                url = logOutServlet;
            } else if(btValue.equals("Delete")){
                url = deleteServlet;
            } else if(btValue.equals("ManageProduct")){
                url = manageProductServlet;
            } else if(btValue.equals("AddProduct")){
                url = addProductServlet;
            } else if(btValue.equals("ViewCart")){
                url = viewCartServlet;
            } else if(btValue.equals("ManageAccount")){
                url = manageAccountServlet;
            } else if(btValue.equals("Save")){
                url = saveServlet;
            }
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
