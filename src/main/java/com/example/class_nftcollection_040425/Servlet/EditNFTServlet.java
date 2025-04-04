package com.example.class_nftcollection_040425.Servlet;

import com.example.class_nftcollection_040425.Dao.NFTDao;
import com.example.class_nftcollection_040425.Models.NFT;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class EditNFTServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        NFT nft = new NFTDao().getNFTById(id);

        if (nft == null) {
            response.sendRedirect("nfts");
            return;
        }

        request.setAttribute("nft", nft);
        request.getRequestDispatcher("/EditNFT.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // tương tự AddNFTServlet nhưng thêm id và gọi updateNFT()
        int id = Integer.parseInt(request.getParameter("id"));
        NFTDao dao = new NFTDao();
        NFT nft = dao.getNFTById(id);

        if (nft == null) {
            response.sendRedirect("nfts");
            return;
        }

        // Cập nhật dữ liệu từ form
        nft.setName(request.getParameter("name"));
        nft.setDescription(request.getParameter("description"));
        nft.setImageUrl(request.getParameter("imageUrl"));
        nft.setPrice(Double.parseDouble(request.getParameter("price")));
        nft.setCreatorName(request.getParameter("creator"));
        nft.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
        nft.setWalletAddress(request.getParameter("wallet"));
        nft.setStatus(request.getParameter("status"));

        dao.updateNFT(nft);
        response.sendRedirect("nfts");
    }
}

