package com.example.class_nftcollection_040425.Servlet;

import com.example.class_nftcollection_040425.Dao.NFTDao;
import com.example.class_nftcollection_040425.Models.NFT;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ListNFTServlet extends HttpServlet {
    private static final int DEFAULT_PAGE = 1;
    private static final int DEFAULT_LIMIT = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int page = DEFAULT_PAGE;
        int limit = DEFAULT_LIMIT;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        NFTDao nftDao = new NFTDao();
        List<NFT> nftList = nftDao.getNFTsForSale(page, limit);
        int totalNFTs = nftDao.countNFTsForSale();
        int totalPages = (int) Math.ceil((double) totalNFTs / limit);

        request.setAttribute("nfts", nftList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/ListNFT.jsp").forward(request, response);
    }

}

