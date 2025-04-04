package com.example.class_nftcollection_040425.Servlet;

import com.example.class_nftcollection_040425.Dao.NFTDao;
import com.example.class_nftcollection_040425.Models.NFT;
import com.example.class_nftcollection_040425.utils.RegexUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class AddNFTServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<String> errors = new ArrayList<>();

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        String priceStr = request.getParameter("price");
        String creator = request.getParameter("creator");
        String categoryIdStr = request.getParameter("categoryId");
        String wallet = request.getParameter("wallet");
        String status = request.getParameter("status");

        double price = 0;
        int categoryId = 0;

        // Validate
        if (name == null || name.length() < 5) {
            errors.add("Tên NFT phải dài ít nhất 5 ký tự.");
        }

        try {
            price = Double.parseDouble(priceStr);
            if (price <= 0) errors.add("Giá NFT phải lớn hơn 0.");
        } catch (Exception e) {
            errors.add("Giá không hợp lệ.");
        }

        if (creator == null || creator.isEmpty()) {
            errors.add("Người tạo không được để trống.");
        }

        if (!RegexUtil.isValidImageUrl(imageUrl)) {
            errors.add("URL ảnh không hợp lệ.");
        }

        if (!RegexUtil.isValidWalletAddress(wallet)) {
            errors.add("Địa chỉ ví không hợp lệ.");
        }

        try {
            categoryId = Integer.parseInt(categoryIdStr);
        } catch (Exception e) {
            errors.add("Danh mục không hợp lệ.");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/AddNFT.jsp").forward(request, response);
            return;
        }

        NFT nft = new NFT();
        nft.setName(name);
        nft.setDescription(description);
        nft.setImageUrl(imageUrl);
        nft.setPrice(price);
        nft.setCreatorName(creator);
        nft.setCategoryId(categoryId);
        nft.setWalletAddress(wallet);
        nft.setStatus(status);

        NFTDao dao = new NFTDao();
        dao.addNFT(nft);

        response.sendRedirect("nfts"); // về danh sách
    }
}

