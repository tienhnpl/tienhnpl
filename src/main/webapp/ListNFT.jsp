<!-- File: listNFT.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.class_nftcollection_040425.Models.NFT" %>
<%@ page import="com.example.class_nftcollection_040425.Models.NFTCategory" %>
<%@ page import="com.example.class_nftcollection_040425.Dao.CategoryDao" %>
<%
    List<NFT> nfts = (List<NFT>) request.getAttribute("nfts");
    int currentPage = (Integer) request.getAttribute("currentPage");
    int totalPages = (Integer) request.getAttribute("totalPages");
%>
<html>
<head>
    <title>Danh sách NFT</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-6">
<div class="max-w-7xl mx-auto">
    <h1 class="text-3xl font-bold mb-6">NFT đang bán</h1>

    <!-- Form tìm kiếm và lọc -->
    <form method="get" action="nfts" class="mb-6 grid grid-cols-1 md:grid-cols-5 gap-4">
        <input type="text" name="keyword" placeholder="Tìm tên hoặc tác giả"
               value="<%= request.getAttribute("keyword") != null ? request.getAttribute("keyword") : "" %>"
               class="px-3 py-2 border rounded w-full">

        <select name="categoryId" class="px-3 py-2 border rounded w-full">
            <option value="">-- Danh mục --</option>
            <%
                CategoryDao categoryDao = new CategoryDao();
                for (NFTCategory cat : categoryDao.getAllCategories()) {
                    String selected = (request.getAttribute("categoryId") != null && String.valueOf(cat.getId()).equals(request.getAttribute("categoryId"))) ? "selected" : "";
            %>
            <option value="<%= cat.getId() %>" <%= selected %>><%= cat.getName() %></option>
            <% } %>
        </select>

        <input type="number" name="minPrice" step="0.01" min="0" placeholder="Giá từ"
               value="<%= request.getAttribute("minPrice") != null ? request.getAttribute("minPrice") : "" %>"
               class="px-3 py-2 border rounded w-full">

        <input type="number" name="maxPrice" step="0.01" min="0" placeholder="Giá đến"
               value="<%= request.getAttribute("maxPrice") != null ? request.getAttribute("maxPrice") : "" %>"
               class="px-3 py-2 border rounded w-full">

        <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">Lọc NFT</button>
    </form>

    <a href="addNFT.jsp"
       class="mb-4 inline-block bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">Thêm NFT</a>

    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
        <% for (NFT nft : nfts) { %>
        <div class="bg-white rounded-xl shadow-md p-4">
            <img src="<%= nft.getImageUrl() %>" alt="<%= nft.getName() %>"
                 class="h-48 w-full object-cover rounded mb-3">
            <h2 class="text-xl font-semibold"><%= nft.getName() %></h2>
            <p class="text-sm text-gray-600 mb-2">Tác giả: <%= nft.getCreatorName() %></p>
            <p class="text-lg text-green-600 font-bold"><%= nft.getPrice() %> ETH</p>
            <div class="mt-4 flex gap-3 text-sm">
                <a href="edit-nft?id=<%= nft.getId() %>" class="text-blue-600 hover:underline">Sửa</a>
                <a href="delete-nft?id=<%= nft.getId() %>" class="text-red-600 hover:underline" onclick="return confirm('Xác nhận xoá NFT này?')">Xoá</a>
                <a href="change-status?id=<%= nft.getId() %>" class="text-yellow-600 hover:underline">Ngừng bán</a>
            </div>
        </div>
        <% } %>
    </div>

    <!-- Phân trang -->
    <div class="mt-6 flex justify-center gap-2">
        <% for (int i = 1; i <= totalPages; i++) { %>
        <a href="nfts?page=<%= i %>"
           class="px-3 py-1 border rounded <% if (i == currentPage) { %>bg-blue-600 text-white<% } else { %>bg-white<% } %>"><%= i %></a>
        <% } %>
    </div>
</div>
</body>
</html>