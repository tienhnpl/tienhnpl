<!-- File: addNFT.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.class_nftcollection_040425.Models.NFTCategory" %>
<%@ page import="com.example.class_nftcollection_040425.Dao.CategoryDao" %>
<%
    List<String> errors = (List<String>) request.getAttribute("errors");
    CategoryDao categoryDao = new CategoryDao();
    List<NFTCategory> categories = categoryDao.getAllCategories();
%>
<html>
<head>
    <title>Thêm NFT</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-6">
<div class="max-w-3xl mx-auto bg-white p-6 rounded-xl shadow-md">
    <h1 class="text-2xl font-bold mb-4">Thêm NFT mới</h1>
    <% if (errors != null && !errors.isEmpty()) { %>
    <div class="bg-red-100 text-red-800 p-4 rounded mb-4">
        <ul>
            <% for (String error : errors) { %>
            <li><%= error %></li>
            <% } %>
        </ul>
    </div>
    <% } %>
    <form action="add-nft" method="post" class="space-y-4">
        <div>
            <label class="block font-medium">Tên NFT</label>
            <input type="text" name="name" class="w-full border rounded px-3 py-2" required minlength="5">
        </div>
        <div>
            <label class="block font-medium">Mô tả</label>
            <textarea name="description" class="w-full border rounded px-3 py-2"></textarea>
        </div>
        <div>
            <label class="block font-medium">Ảnh đại diện (URL)</label>
            <input type="text" name="imageUrl" class="w-full border rounded px-3 py-2">
        </div>
        <div>
            <label class="block font-medium">Giá (ETH)</label>
            <input type="number" name="price" step="0.0001" min="0.0001" class="w-full border rounded px-3 py-2">
        </div>
        <div>
            <label class="block font-medium">Người tạo</label>
            <input type="text" name="creator" class="w-full border rounded px-3 py-2">
        </div>
        <div>
            <label class="block font-medium">Danh mục</label>
            <select name="categoryId" class="w-full border rounded px-3 py-2">
                <% for (NFTCategory c : categories) { %>
                <option value="<%= c.getId() %>"><%= c.getName() %></option>
                <% } %>
            </select>
        </div>
        <div>
            <label class="block font-medium">Địa chỉ ví</label>
            <input type="text" name="wallet" class="w-full border rounded px-3 py-2">
        </div>
        <div>
            <label class="block font-medium">Trạng thái</label>
            <select name="status" class="w-full border rounded px-3 py-2">
                <option value="dang_ban">Đang bán</option>
                <option value="khong_ban">Không bán</option>
                <option value="da_ban">Đã bán</option>
            </select>
        </div>
        <div>
            <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">Lưu NFT</button>
            <a href="nfts" class="ml-3 text-gray-600 hover:underline">Quay lại</a>
        </div>
    </form>
</div>
</body>
</html>
