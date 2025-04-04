package com.example.class_nftcollection_040425.Servlet;

import com.example.class_nftcollection_040425.Dao.NFTDao;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteNFTServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        NFTDao dao = new NFTDao();
        dao.deleteNFT(id);
        response.sendRedirect("nfts");
    }
}

