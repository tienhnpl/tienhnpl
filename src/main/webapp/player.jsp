<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.playerevaluation.Models.Indexer" %>
<%
  List<Object[]> players = (List<Object[]>) request.getAttribute("players");
  List<Indexer> indexers = (List<Indexer>) request.getAttribute("indexers");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Player Information</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 40px;
    }
    h2 {
      text-align: center;
      color: #d48c00;
    }
    .form-group {
      margin-bottom: 15px;
    }
    input, select {
      padding: 8px;
      width: 200px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 30px;
    }
    table, th, td {
      border: 1px solid #ddd;
    }
    th {
      background: #d48c00;
      color: white;
      padding: 10px;
    }
    td {
      text-align: center;
      padding: 8px;
    }
    .action-btn {
      margin: 0 5px;
      color: #555;
      cursor: pointer;
      text-decoration: none;
    }
  </style>
</head>
<body>

<h2>Player Information</h2>

<!-- Add Player Form -->
<form method="post" action="players">
  <input type="hidden" name="action" value="add"/>
  <div class="form-group">
    <label>Player name:</label>
    <input type="text" name="name" placeholder="Player name" required/>
    &nbsp;&nbsp;
    <label>Player age:</label>
    <input type="number" name="age" min="1" placeholder="Player age" required/>
  </div>
  <div class="form-group">
    <label>Index name:</label>
    <select name="indexId" required>
      <option value="">Select Index</option>
      <% for (Indexer idx : indexers) { %>
      <option value="<%= idx.getIndexId() %>"><%= idx.getName() %></option>
      <% } %>
    </select>
    &nbsp;&nbsp;
    <label>Value:</label>
    <input type="number" step="any" name="value" placeholder="Value" required/>
    &nbsp;&nbsp;
    <button type="submit">Add</button>
  </div>
</form>

<!-- Players Table -->
<table>
  <tr>
    <th>Id</th>
    <th>Player name</th>
    <th>Player age</th>
    <th>Index name</th>
    <th>Value</th>
    <th>Actions</th>
  </tr>
  <% if (players != null) {
    for (Object[] row : players) {
      int id = (Integer) row[0];
      String playerName = (String) row[1];
      String playerAge = (String) row[2];
      String indexName = (String) row[3];
      float value = (Float) row[4];
  %>
  <tr>
    <td><%= id %></td>
    <td><%= playerName %></td>
    <td><%= playerAge %></td>
    <td><%= indexName %></td>
    <td><%= value %></td>
    <td>
      <!-- Edit Form (inline update) -->
      <form method="post" action="players" style="display:inline;">
        <input type="hidden" name="action" value="update"/>
        <input type="hidden" name="id" value="<%= id %>"/>
        <input type="hidden" name="indexId" value="<%= getIndexIdByName(indexers, indexName) %>"/>
        <input type="number" name="value" step="any" value="<%= value %>" required style="width:80px;"/>
        <button type="submit" class="action-btn"><i class="fas fa-pen"></i></button>
      </form>
      <!-- Delete Form -->
      <form method="post" action="players" style="display:inline;">
        <input type="hidden" name="action" value="delete"/>
        <input type="hidden" name="id" value="<%= id %>"/>
        <button type="submit" class="action-btn" onclick="return confirm('Are you sure?');">
          <i class="fas fa-trash"></i>
        </button>
      </form>
    </td>
  </tr>
  <% }} %>
</table>

</body>
</html>

<%!
  // Helper function: get indexId by indexName
  public int getIndexIdByName(List<Indexer> indexers, String name) {
    for (Indexer i : indexers) {
      if (i.getName().equals(name)) {
        return i.getIndexId();
      }
    }
    return 0;
  }
%>
