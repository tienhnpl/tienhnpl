<!-- File: editNFT.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.class_nftcollection_040425.Models.NFT" %>
<%@ page import="com.example.class_nftcollection_040425.Models.NFTCategory" %>
<%@ page import="com.example.class_nftcollection_040425.Dao.CategoryDao" %>
<%@ page import="java.util.List" %>
<%
    NFT nft = (NFT) request.getAttribute("nft");
    CategoryDao categoryDao = new CategoryDao();
    List<NFTCategory> categories = categoryDao.getAllCategories();
%>
<html>
<head>
    <title>Chỉnh sửa NFT</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-6">
<div class="max-w-3xl mx-auto bg-white p-6 rounded-xl shadow-md">
    <h1 class="text-2xl font-bold mb-4">Chỉnh sửa NFT</h1>
    <form action="edit-nft" method="post" class="space-y-4">
        <input type="hidden" name="id" value="<%= nft.getId() %>">

        <div>
            <label class="block font-medium">Tên NFT</label>
            <input type="text" name="name" value="<%= nft.getName() %>"
                   class="w-full border rounded px-3 py-2" required minlength="5">
        </div>

        <div>
            <label class="block font-medium">Mô tả</label>
            <textarea name="description" class="w-full border rounded px-3 py-2"><%= nft.getDescription() %></textarea>
        </div>

        <div>
            <label class="block font-medium">Ảnh đại diện (URL)</label>
            <input type="text" name="imageUrl" value="<%= nft.getImageUrl() %>"
                   class="w-full border rounded px-3 py-2">
        </div>

        <div>
            <label class="block font-medium">Giá (ETH)</label>
            <input type="number" name="price" step="0.0001" min="0.0001" value="<%= nft.getPrice() %>"
                   class="w-full border rounded px-3 py-2">
        </div>

        <div>
            <label class="block font-medium">Người tạo</label>
            <input type="text" name="creator" value="<%= nft.getCreatorName() %>"
                   class="w-full border rounded px-3 py-2">
        </div>

        <div>
            <label class="block font-medium">Danh mục</label>
            <select name="categoryId" class="w-full border rounded px-3 py-2">
                <% for (NFTCategory c : categories) { %>
                <option value="<%= c.getId() %>" <% if (c.getId() == nft.getCategoryId()) { %>selected<% } %>>
                    <%= c.getName() %>
                </option>
                <% } %>
            </select>
        </div>

        <div>
            <label class="block font-medium">Địa chỉ ví</label>
            <input type="text" name="wallet" value="<%= nft.getWalletAddress() %>"
                   class="w-full border rounded px-3 py-2">
        </div>

        <div>
            <label class="block font-medium">Trạng thái</label>
            <select name="status" class="w-full border rounded px-3 py-2">
                <option value="dang_ban" <%= nft.getStatus().equals("dang_ban") ? "selected" : "" %>>Đang bán</option>
                <option value="khong_ban" <%= nft.getStatus().equals("khong_ban") ? "selected" : "" %>>Không bán</option>
                <option value="da_ban" <%= nft.getStatus().equals("da_ban") ? "selected" : "" %>>Đã bán</option>
            </select>
        </div>

        <div>
            <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">Cập nhật NFT</button>
            <a href="nfts" class="ml-3 text-gray-600 hover:underline">Quay lại</a>
        </div>
    </form>
</div>
</body>
</html>

