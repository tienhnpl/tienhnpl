package com.example.class_nftcollection_040425.Servlet;

import com.example.class_nftcollection_040425.Dao.NFTDao;
import com.example.class_nftcollection_040425.Models.NFT;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class ChangeStatusServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        NFTDao dao = new NFTDao();
        NFT nft = dao.getNFTById(id);

        if (nft != null) {
            // Chuyển trạng thái
            if ("dang_ban".equals(nft.getStatus())) {
                nft.setStatus("khong_ban");
            } else {
                nft.setStatus("dang_ban");
            }
            dao.updateNFT(nft);
        }

        response.sendRedirect("nfts");
    }
}

